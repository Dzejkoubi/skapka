import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/utils/email_format_validator.dart';
import 'package:skapka_app/utils/name_validator.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';

@RoutePage()
class RegisterScreenFirst extends StatefulWidget {
  const RegisterScreenFirst({super.key});

  @override
  State<RegisterScreenFirst> createState() => _RegisterScreenFirstState();
}

class _RegisterScreenFirstState extends State<RegisterScreenFirst> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _nameError;
  String? _surnameError;
  String? _emailError;

  void _handleNextButtonPressed() {
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final email = _emailController.text.trim();

    setState(() {
      _nameError = validateName(false, name, context: context);
      _surnameError = validateName(true, surname, context: context);
      _emailError = validateEmail(email, context: context);
    });

    if (_nameError == null && _surnameError == null && _emailError == null) {
      context.router.push(
        RegisterRouteSecond(email: email, name: name, surname: surname),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: ScrollableOnKeyboardScreenWrapper(
        builder: (constraints) => Column(
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
                SvgPicture.asset('assets/images/shapes/shape-2.svg'),
                Text(
                  AppLocalizations.of(context)!.register_screen_title,
                  style: AppTextTheme.displayLarge(context),
                ),
              ],
            ),
            SizedBox(height: constraints.maxHeight * 0.16),
            SizedBox(height: AppSpacing.medium),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Flex(
                direction: Axis.vertical,
                spacing: AppSpacing.medium,
                children: [
                  // Name input field
                  CustomForm(
                    controller: _nameController,
                    labelText: AppLocalizations.of(
                      context,
                    )!.register_screen_1_name_hint,
                    errorText: _nameError,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.givenName],
                    onSuffixPressed: () {
                      _nameController.clear();
                      setState(() {
                        _nameError = null;
                      });
                    },
                  ),
                  // Surname input field
                  CustomForm(
                    controller: _surnameController,
                    labelText: AppLocalizations.of(
                      context,
                    )!.register_screen_1_surname_hint,
                    errorText: _surnameError,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.familyName],
                    onSuffixPressed: () {
                      _surnameController.clear();
                      setState(() {
                        _surnameError = null;
                      });
                    },
                  ),
                  // Email input field
                  CustomForm(
                    controller: _emailController,
                    labelText: AppLocalizations.of(
                      context,
                    )!.register_screen_1_email_hint,
                    errorText: _emailError,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    onSuffixPressed: () {
                      _emailController.clear();
                      setState(() {
                        _emailError = null;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.xxLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.huge),
              child: MainButton.filled(
                variant: ButtonStylesVariants.white,
                text: AppLocalizations.of(
                  context,
                )!.register_screen_1_next_button_text,
                onPressed: () => _handleNextButtonPressed(),
              ),
            ),

            // Height spacer so the button is in the same height as on the welcome screen
            SizedBox(height: constraints.maxHeight * 0.10),
          ],
        ),
      ),
    );
  }
}
