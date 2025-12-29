import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
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

    if (session != null) {
      final accountProvider = context.read<AccountProvider>();
      final account = await supabaseService.getAccountDetails(session.user.id);

      if (account != null) {
        accountProvider.setAccount(account);
        accountProvider.updateEmail(session.user.email ?? '');
        if (account.groupId.isNotEmpty) {
          final groupDetails = await supabaseService.getAccountGroupDetail(
            account.groupId,
          );
          accountProvider.setGroup(groupDetails);
        }

        if (mounted) {
          final dependentsProvider = context.read<DependentsProvider>();
          final List<AccountDependentModel> dependents = await supabaseService
              .getAccountDependents(account.accountId);
          if (dependents.isNotEmpty) {
            for (var ad in dependents) {
              final detail = await supabaseService.getDependentDetail(
                ad.dependentId,
              );
              if (detail != null) {
                final notes = await supabaseService.getDependentNotes(
                  ad.dependentId,
                );
                dependentsProvider.addDependent(
                  ad.copyWith(dependentDetails: detail.copyWith(notes: notes)),
                );
              }
            }
          }
        }
      }

      final isApproved = await supabaseService.isLoggedAccountApproved();
      if (!mounted) return;

      if (isApproved) {
        context.router.replace(const NavbarDashboard());
      } else {
        context.router.replace(const AccountNotApprovedRoute());
      }
    } else {
      context.router.replace(const WelcomeRoute());
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
