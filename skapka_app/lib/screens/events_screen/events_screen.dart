import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

@RoutePage()
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    return Scaffold(
      backgroundColor: context.colors.background.light,
      body: SafeArea(
        child: Column(
          children: [
            Appbar(
              showBackChevron: false,
              showScreenName: true,
              screenName: AppLocalizations.of(context)!.events_screen_title,
              showSettingsIcon: true,
            ),
            SizedBox(height: AppSpacing.large),
            MainButton(
              style: ButtonStyleTypes.filled,
              variant: ButtonStylesVariants.normal,
              text: 'Example Button',
              onPressed: () {
                _authService.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
