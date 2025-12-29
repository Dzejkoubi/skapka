import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/screens/auth_gate/widgets/floating_logo.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/services/supabase_service.dart';

@RoutePage()
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAuth());
  }

  Future<void> _checkAuth() async {
    if (!mounted) return;

    final authService = AuthService();
    final supabaseService = SupabaseService();
    final session = authService.currentSession;

    // 1. Check if user is logged in
    if (session == null) {
      context.router.replace(const WelcomeRoute());
      return;
    }

    // 2. Fetch basic account details

    final account = await supabaseService.getAccountDetails(session.user.id);
    if (account == null) {
      if (!mounted) return;
      context.router.replace(const WelcomeRoute());
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
    await _loadAppData(account.accountId, account.groupId);

    if (mounted) {
      context.router.replace(const NavbarDashboard());
    }
  }

  /// Orchestrates loading of all data needed for the main app experience
  Future<void> _loadAppData(String accountId, String groupId) async {
    final supabaseService = SupabaseService();

    // Load Group Details
    if (groupId.isNotEmpty) {
      final groupDetails = await supabaseService.getAccountGroupDetail(groupId);
      if (mounted) context.read<AccountProvider>().setGroup(groupDetails);
    }

    // Load Dependents and Events in parallel to speed up startup
    await Future.wait([_loadDependents(accountId), _loadEvents(groupId)]);
  }

  /// Fetches all dependents linked to the account, including their details and notes
  Future<void> _loadDependents(String accountId) async {
    final supabaseService = SupabaseService();
    final dependentsProvider = Provider.of<DependentsProvider>(
      context,
      listen: false,
    );

    final dependents = await supabaseService.getAccountDependents(accountId);

    dependentsProvider.clear();
    for (var ad in dependents) {
      final detail = await supabaseService.getDependentDetail(ad.dependentId);
      if (detail != null) {
        final notes = await supabaseService.getDependentNotes(ad.dependentId);
        if (mounted) {
          dependentsProvider.addDependent(
            ad.copyWith(dependentDetails: detail.copyWith(notes: notes)),
          );
        }
      }
    }
  }

  /// Fetches events for the group starting from the current school year
  Future<void> _loadEvents(String groupId) async {
    if (groupId.isEmpty) return;

    final supabaseService = SupabaseService();
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);

    // Fetch events from the start of the current school year (Sept 1st)
    final schoolYearStart = DateTime(DateTime.now().year, 9, 1);
    final events = await supabaseService.getGroupEvents(
      groupId,
      schoolYearStart,
    );

    eventsProvider.clear();
    if (mounted) {
      for (var event in events) {
        eventsProvider.addEvent(event);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: Center(
        child: GestureDetector(
          onTap: () => AuthService().signOut(),
          child: FloatingLogo(),
        ),
      ),
    );
  }
}
