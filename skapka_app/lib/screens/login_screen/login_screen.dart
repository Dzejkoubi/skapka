import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/utils/email_format_validator.dart';
import 'package:skapka_app/utils/password_validator.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() {
      _emailError = validateEmail(_emailController.text, context: context);
      _passwordError = validatePassword(
        _passwordController.text,
        context: context,
      );
    });

    if (_emailError == null && _passwordError == null) {
      setState(() {
        _isLoading = true;
      });
      try {
        // First, try to sign in the user
        await authService.signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: AppLocalizations.of(
              context,
            )!.login_screen_login_success,
          );
          context.router.replaceAll([const AuthGate()]);
        }
      } on AuthException catch (e) {
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: e.message.contains('Invalid login credentials')
                ? AppLocalizations.of(
                    context,
                  )!.login_screen_login_error_invalid_credentials
                : AppLocalizations.of(
                    context,
                  )!.login_screen_login_error_generic,
          );
        }
      } catch (e) {
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: AppLocalizations.of(
              context,
            )!.login_screen_login_error_generic,
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _isLoading ? false : true, // Disable back navigation when loading
      child: Scaffold(
        backgroundColor: context.colors.primary.light,
        body: ScrollableOnKeyboardScreenWrapper(
          builder: (constraints) {
            return Column(
              children: [
                SizedBox(height: AppSpacing.large),
                Appbar(
                  backChevronCanPop: !_isLoading,
                  showBackChevron: true,
                  showScreenName: false,
                  showSettingsIcon: false,
                ),
                SizedBox(height: AppSpacing.xLarge),
                // Title with decorative shape
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/images/shapes/shape-1.svg'),
                    Text(
                      AppLocalizations.of(context)!.login_screen_title,
                      style: AppTextTheme.displayLarge(context),
                    ),
                  ],
                ),
                // Flexible spacer that grows to push content to center/bottom
                SizedBox(height: constraints.maxHeight * 0.18),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.large,
                  ),
                  child: Column(
                    children: [
                      CustomForm(
                        controller: _emailController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.login_screen_email_hint,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        errorText: _emailError,
                        onSuffixPressed: () {
                          _emailController.clear();
                          setState(() {
                            _emailError = null;
                          });
                        },
                      ),
                      SizedBox(height: AppSpacing.medium),
                      CustomForm(
                        controller: _passwordController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.login_screen_password_hint,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        errorText: _passwordError,
                        onSuffixPressed: () {
                          _passwordController.clear();
                          setState(() {
                            _passwordError = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xxLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.huge,
                  ),
                  child: MainButton.filled(
                    variant: ButtonStylesVariants.white,
                    text: _isLoading
                        ? AppLocalizations.of(context)!.loading
                        : AppLocalizations.of(
                            context,
                          )!.login_screen_login_button_text,
                    onPressed: _handleLogin,
                  ),
                ),

                // Bottom spacer
                SizedBox(height: constraints.maxHeight * 0.20),
                SizedBox(height: AppSpacing.xxLarge),
              ],
            );
          },
        ),
      ),
    );
  }
}
