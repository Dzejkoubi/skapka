import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/l10n/app_localizations.dart';
import 'package:skapka_app/widgets/screen_wrapper.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
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
                    onPressed: () {
                      print('login button pressed');
                    },
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.welcome_screen_login_button_text,
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
