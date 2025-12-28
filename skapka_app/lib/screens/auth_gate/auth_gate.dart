import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/screens/auth_gate/widgets/floating_logo.dart';
import 'package:skapka_app/services/auth_service.dart';

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
    final session = authService.currentSession;

    if (session != null) {
      final isApproved = await authService.isLoggedAccountApproved();
      if (!mounted) return;

      if (isApproved) {
        context.router.replace(const EventsRoute());
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
