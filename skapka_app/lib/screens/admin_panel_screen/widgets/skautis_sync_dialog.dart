import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

class SkautisSyncDialog extends StatelessWidget {
  const SkautisSyncDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tokenController = TextEditingController();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(AppSpacing.large),
        decoration: AppDecorations.primaryContainer(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localizations.admin_panel_screen_button_skautis_sync,
              style: AppTextTheme.bodyLarge(context),
            ),
            const SizedBox(height: AppSpacing.medium),
            Text(
              context.localizations.admin_panel_screen_skautis_sync_description,
              style: AppTextTheme.bodyMedium(context),
            ),
            const SizedBox(height: AppSpacing.medium),
            CustomForm(
              controller: tokenController,
              labelText: context
                  .localizations
                  .admin_panel_screen_skautis_sync_token_hint,
              showSuffixIcon: false,
            ),
            const SizedBox(height: AppSpacing.large),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: AppSpacing.medium,
              children: [
                MainButton.filled(
                  text: context.localizations.cancel,
                  variant: ButtonStylesVariants.destructive,
                  onPressed: () => context.router.pop(),
                ),
                MainButton.filled(
                  text: context.localizations.general_continue,
                  onPressed: () async {
                    if (tokenController.text.isEmpty) return;

                    final loadingProvider = context.read<LoadingProvider>();
                    final accountProvider = context.read<AccountProvider>();
                    final supabaseService = SupabaseService();
                    final router = context.router;

                    try {
                      loadingProvider.show(
                        text: context
                            .localizations
                            .admin_panel_screen_skautis_sync_progress,
                      );

                      await supabaseService.skautisSync(
                        skautisToken: tokenController.text,
                        groupId: accountProvider.groupId,
                      );

                      loadingProvider.hide();

                      if (context.mounted) {
                        BottomDialog.show(
                          context,
                          type: BottomDialogType.positive,
                          description: context
                              .localizations
                              .admin_panel_screen_skautis_sync_success_description,
                        );
                        router.pop();
                      }
                    } catch (e) {
                      debugPrint('Error syncing with SkautIS: $e');
                      loadingProvider.hide();

                      if (context.mounted) {
                        BottomDialog.show(
                          context,
                          type: BottomDialogType.negative,
                          description: context
                              .localizations
                              .admin_panel_screen_skautis_sync_error_description,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
