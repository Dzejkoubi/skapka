import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_floating_logo.dart';
import 'package:skapka_app/app/router/pending_deep_link.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<AuthState>? _authSubscription;

  /// Guards against [_checkAuth] running concurrently. Both the auth listener and
  /// the post-frame callback can trigger it, and overlapping runs used to load
  /// every dependent/event twice.
  bool _isCheckingAuth = false;

  @override
  void initState() {
    super.initState();

    _authSubscription = AuthService().onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        if (mounted) _checkAuth();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAuth());
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );
  }

  Future<void> _checkAuth() async {
    if (!mounted) return;

    // Drop overlapping calls: the auth listener and the post-frame callback can
    // both fire this, and concurrent runs used to load every dependent twice.
    if (_isCheckingAuth) return;
    _isCheckingAuth = true;
    try {
      // Check connectivity first
      final connectivityResult = await Connectivity().checkConnectivity();
      if (!_hasConnection(connectivityResult)) {
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description:
                context.localizations.welcome_screen_no_internet_connection,
          );
        }

        // Listen for connectivity changes to retry
        _connectivitySubscription?.cancel();
        _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
          (results) {
            if (_hasConnection(results)) {
              _connectivitySubscription?.cancel();
              _checkAuth(); // Retry auth check
            }
          },
        );
        return;
      }

      final authService = AuthService();
      final supabaseService = SupabaseService();
      final session = authService.currentSession;

      // 1. Check if user is logged in
      if (session == null && mounted) {
        context.router.replace(WelcomeRoute());
        return;
      }

      // 2. Fetch basic account details

      final account = await supabaseService.getAccountDetails(session!.user.id);
      if (account == null) {
        if (!mounted) return;
        context.router.replace(WelcomeRoute());
        return;
      }

      // 3. Initialize Account Provider
      if (!mounted) return;
      final accountProvider = context.read<AccountProvider>();
      accountProvider.setAccount(account);
      accountProvider.updateEmail(session.user.email ?? '');

      // 4. Check if account is approved by admin
      final isApproved = await supabaseService.isLoggedAccountApproved();
      if (!mounted) return;

      if (!isApproved) {
        context.router.replace(const AccountNotApprovedRoute());
        return;
      }

      // 5. User is approved, load all necessary app data
      await loadAppData(account.accountId, account.groupId);

      if (mounted) {
        context.router.replace(const NavbarDashboard());
        final pendingPath = PendingDeepLink.consume();
        if (pendingPath != null) {
          await Future.delayed(const Duration(milliseconds: 300));
          if (mounted) context.router.navigatePath(pendingPath);
        }
      }
    } finally {
      _isCheckingAuth = false;
    }
  }

  /// Orchestrates loading of all data needed for the main app experience
  Future<void> loadAppData(String accountId, String groupId) async {
    final supabaseService = SupabaseService();

    // Load Group Details
    if (groupId.isNotEmpty) {
      final groupDetails = await supabaseService.getAccountGroupDetail(groupId);
      if (mounted) {
        context.read<AccountProvider>().setGroup(groupDetails);
        context.read<UnitsProvider>().setAccountGroup(groupDetails);
      }
    }

    // Load Dependents, Events and Units in parallel to speed up startup
    await Future.wait([
      _loadDependents(accountId),
      _loadEvents(groupId),
      _loadUnits(groupId),
    ]);
  }

  Future<void> _loadUnits(String groupId) async {
    if (groupId.isEmpty) return;
    final supabaseService = SupabaseService();

    final results = await Future.wait([
      supabaseService.getGroupTroops(groupId),
      supabaseService.getGroupPatrols(groupId),
    ]);

    if (mounted) {
      final unitsProvider = context.read<UnitsProvider>();
      unitsProvider.setTroops(results[0] as List<TroopModel>);
      unitsProvider.setPatrols(results[1] as List<PatrolModel>);
    }
  }

  /// Fetches all dependents linked to the account, including their details and notes
  Future<void> _loadDependents(String accountId) async {
    final supabaseService = SupabaseService();
    final dependentsProvider = Provider.of<DependentsProvider>(
      context,
      listen: false,
    );

    // 1. Fetch relations first
    final relations = await supabaseService.getAccountDependentRelations(
      accountId,
    );

    // 2. Build the full result locally so we can replace provider state in a
    // single atomic step. Loading incrementally (clear() + addDependent per
    // item) duplicated entries when two loads overlapped.
    final loadedDependents = <AccountDependentModel>[];
    final loadedParticipation = <String, List<EventParticipantModel>>{};

    await Future.wait(
      relations.map((relation) async {
        final dependentId = relation.dependentId;

        // Fetch all specific details for dependent in parallel
        final results = await Future.wait([
          supabaseService.getDependentDetail(dependentId),
          supabaseService.getDependentNotes(dependentId),
          supabaseService.getDependentParticipation(dependentId),
        ]);

        final detail = results[0] as DependentModel?;
        final notes = results[1] as DependentNotesModel?;
        final participation = results[2] as List<EventParticipantModel>;

        if (detail != null) {
          final fullDependent = AccountDependentModel(
            dependentId: detail.dependentId,
            isLeader: detail.isLeader,
            name: detail.name,
            surname: detail.surname,
            nickname: detail.nickname,
            born: detail.born,
            sex: detail.sex,
            parent1Email: detail.parent1Email,
            parent1Phone: detail.parent1Phone,
            parent2Email: detail.parent2Email,
            parent2Phone: detail.parent2Phone,
            contactEmail: detail.contactEmail,
            contactPhone: detail.contactPhone,
            troopId: detail.troopId,
            patrolId: detail.patrolId,
            isArchived: detail.isArchived,
            secretCode: detail.secretCode,
            createdAt: detail.createdAt,
            groupId: detail.groupId,
            skautisId: detail.skautisId,
            notes: notes ?? DependentNotesModel.empty(),
            isMainDependent: relation.isMainDependent,
          );

          loadedDependents.add(fullDependent);
          loadedParticipation[dependentId] = participation;
        }
      }),
    );

    // 3. Replace provider state atomically once everything is loaded.
    if (mounted) {
      dependentsProvider.setDependents(loadedDependents, loadedParticipation);
    }
  }

  /// Fetches events for the group starting from the current school year
  Future<void> _loadEvents(String groupId) async {
    if (groupId.isEmpty) return;

    final supabaseService = SupabaseService();
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);

    // Fetch events from the start of the current school year (Sept 1st)
    final now = DateTime.now();
    // If current month is before September (1-8), use previous year. Otherwise, use current year.
    final startYear = now.month < 9 ? now.year - 1 : now.year;
    final schoolYearStart = DateTime(startYear, 9, 1);

    final events = await supabaseService.getGroupEvents(
      groupId: groupId,
      date: schoolYearStart,
    );

    // Replace atomically instead of clear() + addEvent per item, so overlapping
    // loads can't duplicate events.
    if (mounted) {
      eventsProvider.setEvents(events);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: Center(child: LoadingFloatingLogo()),
    );
  }
}
