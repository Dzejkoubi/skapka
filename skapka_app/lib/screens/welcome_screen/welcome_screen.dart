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
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final supabase = Supabase.instance.client;

  /// Handles login process via Google.
  ///
  /// Calls [AuthService.googleSignIn] to authenticate user.
  /// If user is logged in and found in the database, redirect to home screen.
  Future<void> onGoogleLogin(BuildContext context) async {
    try {
      await AuthService().nativeGoogleSignIn();
    } catch (e) {
      debugPrint('Google sign-in failed: $e');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) return;

    if (context.mounted) {
      // Parse name from Supabase user metadata (populated by Google)
      final displayName = (user.userMetadata?['full_name'] as String?) ?? '';
      final nameParts = displayName.split(' ');
      final name = nameParts.isNotEmpty ? nameParts[0] : '';
      final surname = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : '';

      // Only create account record if this is a new user
      final existingAccount = await SupabaseService().getAccountDetails(
        user.id,
      );
      if (existingAccount == null) {
        await SupabaseService().insertAccount(
          accountId: user.id,
          name: name,
          surname: surname,
          groupId: GroupModel.defaultGroupId,
          isApproved: false,
        );
      }

      if (context.mounted) {
        context.router.push(AuthGate());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SafeArea(
              child: Column(
            children: [
              SizedBox(height: AppSpacing.xLarge),
              SizedBox(
                height: 128,
                child: SvgPicture.asset(
                  'assets/images/logos/scout-logo-white-without-text.svg',
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                context.localizations.welcome_screen_title,
                style: AppTextTheme.displayLarge(
                  context,
                ).copyWith(color: context.colors.text.normalLight),
              ),
              SizedBox(height: constraints.maxHeight * 0.15),
              // Buttons
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.huge,
                ),
                child: Flex(
                  direction: Axis.vertical,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MainButton.outlined(
                          variant: ButtonStylesVariants.white,
                          iconAsset: 'assets/icons/brand-google.svg',
                          type: ButtonType.icon,
                          text: "",
                          onPressed: () => onGoogleLogin(context),
                        ),
                        MainButton.outlined(
                          variant: ButtonStylesVariants.white,
                          iconAsset: 'assets/icons/brand-apple.svg',
                          type: ButtonType.icon,
                          text: "",
                          onPressed: () {
                            debugPrint('Apple Sign-In button pressed');
                          },
                        ),
                      ],
                    ),
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
              ),
              SizedBox(height: AppSpacing.bottomSpace),
            ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
