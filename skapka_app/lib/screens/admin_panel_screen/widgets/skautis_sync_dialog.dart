import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_input_dialog.dart';

class SkautisSyncDialog extends StatelessWidget {
  const SkautisSyncDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tokenController = TextEditingController();

    return LargeInputDialog(
      title: context.localizations.admin_panel_screen_button_skautis_sync,
      description:
          context.localizations.admin_panel_screen_skautis_sync_description,
      secondaryButtonText: context.localizations.cancel,
      primaryButtonText: context.localizations.continue_,
      fields: [
        LargeInputDialogField(
          controller: tokenController,
          labelText:
              context.localizations.admin_panel_screen_skautis_sync_token_hint,
          showSuffixIcon: false,
        ),
      ],
      onPrimaryPressed: () async {
        if (tokenController.text.isEmpty) return;

        final loadingProvider = context.read<LoadingProvider>();
        final accountProvider = context.read<AccountProvider>();
        final supabaseService = SupabaseService();
        final router = context.router;

        try {
          loadingProvider.show(
            text:
                context.localizations.admin_panel_screen_skautis_sync_progress,
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
    );
  }
}
