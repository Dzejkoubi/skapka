import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/l10n/app_localizations.dart';
import 'package:skapka_app/widgets/screen_wrapper.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        backgroundColor: context.colors.background.light,
        body: Column(
          children: [
            SizedBox(height: 64),
            SizedBox(
              height: 64,
              child: SvgPicture.asset(
                'assets/images/logos/scout_logo_white_without_text.svg',
              ),
            ),
            Text(AppLocalizations.of(context)!.welcome_screen_title),
            Expanded(child: Container()),
            // Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Flex(
                direction: Axis.vertical,
                spacing: 8, // TODO: change to a variable
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.primary.dark,
                      ),
                    ),
                    onPressed: () {
                      print('login button pressed');
                    },
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.welcome_screen_login_button_text,
                      style: AppTextTheme.cta,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('register button pressed');
                    },
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.welcome_screen_register_button_text,
                      style: AppTextTheme.cta,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('songbook button pressed');
                    },
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.welcome_screen_songbook_button_text,
                      style: AppTextTheme.displayLarge,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 128),
          ],
        ),
      ),
    );
  }
}
