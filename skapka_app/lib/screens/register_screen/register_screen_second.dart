import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/providers/register_provider.dart';
import 'package:skapka_app/utils/password_validator.dart';
import 'package:skapka_app/utils/two_passwords_validator.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

@RoutePage()
class RegisterScreenSecond extends StatefulWidget {
  const RegisterScreenSecond({super.key});

  @override
  State<RegisterScreenSecond> createState() => _RegisterScreenSecondState();
}

class _RegisterScreenSecondState extends State<RegisterScreenSecond> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;

  void _handleRegisterButtonPressed() {
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
      final registerProvider = context.read<RegisterProvider>();
      registerProvider.updatePassword(_passwordController.text);
      registerProvider.updateConfirmPassword(_confirmPasswordController.text);
      // TODO: Implement actual registration logic
      print(
        'Register with: ${registerProvider.email}, '
        '${registerProvider.password}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.large),
                  Appbar(
                    showBackChevron: true,
                    showScreenName: false,
                    showSettingsIcon: false,
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
                  SizedBox(height: constraints.maxHeight * 0.15),
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
                      text: AppLocalizations.of(
                        context,
                      )!.register_screen_2_register_button_text,
                      onPressed: () => _handleRegisterButtonPressed(),
                    ),
                  ),

                  // Height spacer so the button is in the same height as on the welcome screen
                  SizedBox(height: constraints.maxHeight * 0.15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
