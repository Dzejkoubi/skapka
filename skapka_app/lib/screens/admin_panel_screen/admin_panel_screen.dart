import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/basic_expansion_tile.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
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
        child: SafeArea(
          child: Column(
            spacing: AppSpacing.large,
            children: [
              // DB warnings expansion tile
              BasicExpansionTile(
                title: context
                    .localizations
                    .admin_panel_screen_db_warnings_expansion_tile_title,
                customBorderColor: AppColorTheme.error.normal,
                child: Column(
                  children: [
                    // Warnings list
                    Column(children: [
                      ],
                    ),
                    // Reload warnings button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainButton.filled(
                          variant: ButtonStylesVariants.destructive,
                          text: '',
                          type: ButtonType.icon,
                          onPressed: () {
                            debugPrint('Fetch warnings');
                          },
                          iconAsset: 'assets/icons/reload.svg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Account editing expansion tile
              BasicExpansionTile(
                title: context
                    .localizations
                    .admin_panel_screen_accounts_management_title,
                child: Column(
                  spacing: AppSpacing.xSmall,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.filled(
                          onPressed: () {},
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/check.svg',
                          text: context
                              .localizations
                              .admin_panel_screen_button_approve_accounts,
                          expandToFillWidth: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          onPressed: () {},
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/pencil.svg',
                          text: context
                              .localizations
                              .admin_panel_screen_button_edit_leaders,
                          expandToFillWidth: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          onPressed: () {},
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/license.svg',
                          text: context
                              .localizations
                              .admin_panel_screen_button_edit_permissions,
                          expandToFillWidth: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          onPressed: () {},
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/user-plus.svg',
                          text: context
                              .localizations
                              .admin_panel_screen_button_connect_dependents,
                          expandToFillWidth: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          onPressed: () {},
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/eye-off.svg',
                          text: context
                              .localizations
                              .admin_panel_screen_button_dependent_codes,
                          expandToFillWidth: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Skautis management expansion tile
              BasicExpansionTile(
                title: context
                    .localizations
                    .admin_panel_screen_data_management_title,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/cloud-down.svg',
                          variant: ButtonStylesVariants.normal,
                          text: context
                              .localizations
                              .admin_panel_screen_button_skautis_sync,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Notification settings expansion tile
              BasicExpansionTile(
                title:
                    context.localizations.admin_panel_screen_notification_title,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MainButton.outlined(
                          type: ButtonType.textIcon,
                          iconAsset: 'assets/icons/bell-up.svg',
                          variant: ButtonStylesVariants.normal,
                          text: context
                              .localizations
                              .admin_panel_screen_button_send_notification,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Edit server driven content expansion tile
            ],
          ),
        ),
      ),
    );
  }
}
