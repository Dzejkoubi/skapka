import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/utils/password_validator.dart';
import 'package:skapka_app/utils/two_passwords_validator.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class RegisterScreenSecond extends StatefulWidget {
  final String email;
  final String name;
  final String surname;
  const RegisterScreenSecond({
    super.key,
    required this.email,
    required this.name,
    required this.surname,
  });

  @override
  State<RegisterScreenSecond> createState() => _RegisterScreenSecondState();
}

class _RegisterScreenSecondState extends State<RegisterScreenSecond> {
  AuthService authService = AuthService();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;

  bool _isLoading = false;

  void _handleRegisterButtonPressed() async {
    setState(() {
      _passwordError = validatePassword(
        _passwordController.text,
        context: context,
      );
      _confirmPasswordError = validateTwoPasswords(
        _passwordController.text,
        _confirmPasswordController.text,
        context: context,
      );
    });

    if (_passwordError == null && _confirmPasswordError == null) {
      setState(() {
        _isLoading = true;
      });
      try {
        await authService.signUp(
          email: widget.email.trim(),
          password: _passwordController.text,
        );

        await authService.editAccountDetails(
          accountId: authService.currentUser!.id,
          name: widget.name,
          surname: widget.surname,
          groupId: 'a0e10271-a919-4e9d-91d7-013c0fe6a625',
          isApproved: false,
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
        if (kDebugMode) {
          print(e);
        }
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: e.statusCode.toString() == 'user_already_exists'
                ? AppLocalizations.of(
                    context,
                  )!.register_screen_2_registration_error_email_used
                : AppLocalizations.of(
                    context,
                  )!.register_screen_2_registration_error_generic,
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: AppLocalizations.of(
              context,
            )!.register_screen_2_registration_error_generic,
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
      canPop: !_isLoading, // Disable back navigation when loading
      child: Scaffold(
        backgroundColor: context.colors.primary.light,
        body: ScrollableOnKeyboardScreenWrapper(
          builder: (constraints) {
            return Column(
              children: [
                SizedBox(height: AppSpacing.large),
                Appbar(
                  showBackChevron: true,
                  showScreenName: false,
                  showSettingsIcon: false,
                  backChevronCanPop: !_isLoading,
                ),
                SizedBox(height: AppSpacing.xLarge),
                // Title with decorative shape
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/images/shapes/shape-3.svg'),
                    Text(
                      AppLocalizations.of(context)!.register_screen_title,
                      style: AppTextTheme.displayLarge(context),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.245),
                SizedBox(height: AppSpacing.medium),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.large,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    spacing: AppSpacing.medium,
                    children: [
                      // Password input field
                      CustomForm(
                        controller: _passwordController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.register_screen_2_password_hint,
                        errorText: _passwordError,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        obscureText: true,
                        onSuffixPressed: () {
                          _passwordController.clear();
                          setState(() {
                            _passwordError = null;
                          });
                        },
                      ),
                      // Surname input field
                      CustomForm(
                        controller: _confirmPasswordController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.register_screen_2_confirm_password_hint,
                        errorText: _confirmPasswordError,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        obscureText: true,
                        onSuffixPressed: () {
                          _confirmPasswordController.clear();
                          setState(() {
                            _confirmPasswordError = null;
                          });
                        },
                      ),

                      // Email input field
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
                          )!.register_screen_2_register_button_text,
                    onPressed: () => _handleRegisterButtonPressed(),
                  ),
                ),

                // Height spacer so the button is in the same height as on the welcome screen
                SizedBox(height: constraints.maxHeight * 0.15),
              ],
            );
          },
        ),
      ),
    );
  }
}
