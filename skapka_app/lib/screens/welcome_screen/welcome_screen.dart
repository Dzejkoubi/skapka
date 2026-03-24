import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/group_model.dart';
import 'package:skapka_app/screens/welcome_screen/widgets/apple_sign_in_button.dart';
import 'package:skapka_app/screens/welcome_screen/widgets/google_sign_in_button.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final supabase = Supabase.instance.client;

  /// Creates an account record in the database if this is the user's first login.
  Future<void> _ensureAccountExists(User user) async {
    final existingAccount = await SupabaseService().getAccountDetails(user.id);
    if (existingAccount != null) return;

    final displayName = (user.userMetadata?['full_name'] as String?) ?? '';
    final nameParts = displayName.split(' ');
    final name = nameParts.isNotEmpty ? nameParts[0] : '';
    final surname = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    await SupabaseService().insertAccount(
      accountId: user.id,
      name: name,
      surname: surname,
      groupId: GroupModel.defaultGroupId,
      isApproved: false,
    );
  }

  /// Handles login process via Google.
  Future<void> onGoogleLogin(BuildContext context) async {
    try {
      await AuthService().signInWithGoogle();
    } catch (e) {
      debugPrint('Google sign-in failed: $e');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) return;
    if (!context.mounted) return;

    await _ensureAccountExists(user);

    if (context.mounted) {
      context.router.replace(AuthGate());
    }
  }

  /// Handles login process via Apple Sign-In.
  ///
  /// Authenticates user via [AuthService.signInWithApple], then creates a new
  /// account record if this is the user's first login. On Android the OAuth
  /// flow opens a browser and returns immediately, so we wait for the
  /// [AuthChangeEvent.signedIn] event before proceeding.
  Future<void> onAppleLogin(BuildContext context) async {
    try {
      await AuthService().signInWithApple();
    } catch (e) {
      debugPrint('Apple sign-in failed: $e');
      return;
    }

    User? user;

    if (Platform.isAndroid) {
      // On Android the browser OAuth returns immediately — wait for the
      // actual sign-in event so the session is available.
      final completer = Completer<User?>();
      late final StreamSubscription<AuthState> sub;
      sub = supabase.auth.onAuthStateChange.listen((data) {
        if (data.event == AuthChangeEvent.signedIn) {
          sub.cancel();
          completer.complete(data.session?.user);
        }
      });

      user = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          sub.cancel();
          return null;
        },
      );
    } else {
      user = supabase.auth.currentUser;
    }

    if (user == null) return;
    if (!context.mounted) return;

    await _ensureAccountExists(user);

    if (context.mounted) {
      context.router.replace(AuthGate());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.huge),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: 128,
                child: SvgPicture.asset(
                  'assets/images/logos/scout-logo-white-without-text.svg',
                ),
              ),
              const SizedBox(height: AppSpacing.large),
              Text(
                textAlign: TextAlign.center,
                context.localizations.welcome_screen_title,
                style: AppTextTheme.displayLarge(
                  context,
                ).copyWith(color: context.colors.text.normalLight),
              ),
              const Spacer(flex: 2),
              // Buttons
              Column(
                spacing: AppSpacing.small,
                children: [
                  MainButton.filled(
                    type: ButtonType.text,
                    variant: ButtonStylesVariants.white,
                    onPressed: () {
                      context.router.push(const LoginRoute());
                    },
                    text: AppLocalizations.of(
                      context,
                    )!.welcome_screen_login_button_text,
                  ),
                  MainButton.outlined(
                    type: ButtonType.text,
                    variant: ButtonStylesVariants.white,
                    text: AppLocalizations.of(
                      context,
                    )!.welcome_screen_register_button_text,
                    onPressed: () {
                      context.router.push(const RegisterRouteFirst());
                    },
                  ),
                  Text(
                    context.localizations.welcome_screen_or_text,
                    style: AppTextTheme.bodyLargeBold(
                      context,
                    ).copyWith(color: context.colors.text.normalLight),
                  ),
                  GoogleSignInButton(onPressed: () => onGoogleLogin(context)),
                  AppleSignInButton(onPressed: () => onAppleLogin(context)),
                  // MainButton.text(
                  //   type: ButtonType.text,
                  //   variant: ButtonStylesVariants.white,
                  //   text: AppLocalizations.of(
                  //     context,
                  //   )!.welcome_screen_songbook_button_text,

                  //   onPressed: () {
                  //     debugPrint('Songbook button pressed');
                  //   },
                  // ), // TODO: Uncomment when songbook is ready
                ],
              ),
              const SizedBox(height: AppSpacing.large),
            ],
          ),
        ),
      ),
    );
  }
}
