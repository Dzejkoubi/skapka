import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

@RoutePage()
class RegisterScreenSecond extends StatelessWidget {
  const RegisterScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colors.primary.light,
        body: Column(
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
            // Empty space to push content down so the register button is in the same position as on the welcome screen
            Expanded(child: Container()),
            SizedBox(height: AppSpacing.medium),
            SizedBox(height: AppSpacing.huge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Flex(
                direction: Axis.vertical,
                spacing: AppSpacing.medium,
                children: [TextField(), TextField()],
              ),
            ),
            SizedBox(height: AppSpacing.xxLarge),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.huge),
              child: MainButton.filled(
                variant: ButtonStylesVariants.white,
                text: AppLocalizations.of(
                  context,
                )!.register_screen_2_register_button_text,
                onPressed: () {
                  // TODO: Implement register logic
                },
              ),
            ),
            // Height spacer so the button is in the same height as on the welcome screen
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
