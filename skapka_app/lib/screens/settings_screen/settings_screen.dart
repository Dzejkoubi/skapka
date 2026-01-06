import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/screens/settings_screen/widgets/account_container.dart';
import 'package:skapka_app/screens/settings_screen/widgets/set_app_language_dropdown_menu.dart';
import 'package:skapka_app/screens/settings_screen/widgets/set_app_theme_dropdown_menu.dart';
import 'package:skapka_app/screens/settings_screen/widgets/settings_box.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/utils/is_user_admin.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    AccountProvider accountProvider = context.read<AccountProvider>();
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.settings_screen_title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: AppSpacing.large,
            children: [
              if (isUserAdmin(context))
                SettingsBox(
                  text: context
                      .localizations
                      .settings_screen_admin_panel_box_title,
                  route: AdminPanelRoute(),
                ),
              if (isUserLeader(context))
                SettingsBox(
                  text: context
                      .localizations
                      .settings_screen_send_notification_box_title,
                  route: SendNotificationRoute(),
                ),
              AccountContainer(
                accountProvider: accountProvider,
                authService: authService,
              ),
              SetAppThemeDropdownMenu(),
              SetAppLanguageDropdownMenu(),
              SizedBox(height: AppSpacing.huge),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.medium),
                      child: Text(
                        '${context.localizations.settings_screen_app_version_title}${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                        style: AppTextTheme.bodySmall(
                          context,
                        ).copyWith(color: context.colors.text.muted),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: AppSpacing.bottomSpace),
            ],
          ),
        ),
      ),
    );
  }
}
