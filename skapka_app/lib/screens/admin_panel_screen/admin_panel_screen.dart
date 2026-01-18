import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.admin_panel_screen_title,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: AppSpacing.bottomSpace + AppSpacing.large,
          ),
          child: Column(
            spacing: AppSpacing.large,
            children: [
              // Notifications expansion tile

              // Account editing expansion tile

              // Skautis management expansion tile

              // Notification settings expansion tile

              // Edit server driven content expansion tile
            ],
          ),
        ),
      ),
    );
  }
}
