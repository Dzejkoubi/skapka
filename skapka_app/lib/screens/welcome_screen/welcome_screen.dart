import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSpacing.bottomSpace),
            SizedBox(
              height: 256,
              child: SvgPicture.asset(
                'assets/images/logos/scout_logo_white_without_text.svg',
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.welcome_screen_title,
              style: AppTextTheme.displayLarge(
                context,
              ).copyWith(color: context.colors.text.normalLight),
            ),
            Expanded(child: Container()),
            // Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.huge),
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
                  MainButton.text(
                    type: ButtonType.text,
                    variant: ButtonStylesVariants.white,
                    text: AppLocalizations.of(
                      context,
                    )!.welcome_screen_songbook_button_text,
                    onPressed: () {
                      print('songbook button pressed');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.bottomSpace),
          ],
        ),
      ),
    );
  }
}
