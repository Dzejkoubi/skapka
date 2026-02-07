import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class SendNotificationScreen extends StatelessWidget {
  const SendNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName:
            context.localizations.settings_screen_send_notification_box_title,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                context.localizations.info_screen_title,
                style: AppTextTheme.titleLarge(context),
              ),
              Text(
                textAlign: TextAlign.center,
                context.localizations.info_screen_subtitle,
                style: AppTextTheme.bodyMedium(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
