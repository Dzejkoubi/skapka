import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class AddDependentsToAccountScreen extends StatelessWidget {
  final AdminPanelProvider adminProvider;
  const AddDependentsToAccountScreen({required this.adminProvider, super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();

    return ScreenWrapper(
      appBar: Appbar(
        onBackPressed: () {
          adminProvider.clearSurnameSearchQuery();
          context.router.pop();
        },
        showBackChevron: true,
        showSettingsIcon: false,
        screenName:
            context.localizations.admin_panel_screen_button_approve_accounts,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.bottomSpace + AppSpacing.xxLarge,
            ),
            child: Column(spacing: AppSpacing.large, children: [
              ],
            ),
          ),
        ),
      ),
    );
  }
}
