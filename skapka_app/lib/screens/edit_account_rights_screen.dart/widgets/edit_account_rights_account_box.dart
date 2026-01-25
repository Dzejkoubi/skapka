import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

class EditAccountRightsAccountBox extends StatelessWidget {
  const EditAccountRightsAccountBox({
    super.key,
    required this.account,
    required this.loadingProvider,
    required this.supabaseService,
    required this.loadGroupAccounts,
  });

  final AccountModel account;
  final LoadingProvider loadingProvider;
  final SupabaseService supabaseService;
  final Future<void> Function() loadGroupAccounts;

  @override
  Widget build(BuildContext context) {
    updateAccountRights(AccountModel account, int newRights) async {
      loadingProvider.show();
      try {
        await supabaseService.updateAccountRights(account.accountId, newRights);
        await loadGroupAccounts();
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_button_edit_rights_change_success(
                  "${account.name} ${account.surname}",
                  newRights.toString(),
                ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          debugPrint('Error updating account rights: $e');
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations
                .admin_panel_screen_button_edit_rights_error(
                  "${account.name} ${account.surname}",
                ),
          );
        }
      } finally {
        loadingProvider.hide();
      }
    }

    return Container(
      decoration: AppDecorations.primaryContainer(context),
      padding: const EdgeInsets.only(left: AppSpacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                '${account.name} ${account.surname}',
                style: AppTextTheme.bodyMedium(context),
              ),
            ),
          ),
          CustomDropdownMenu(
            width: 100,
            dropdownMenuEntries: [
              DropdownMenuEntry(
                value: 1,
                label: '1',
                labelWidget: Text(
                  context
                      .localizations
                      .admin_panel_screen_button_edit_rights_right_level_1,
                  style: AppTextTheme.bodyMedium(context),
                ),
              ),
              DropdownMenuEntry(
                value: 2,
                label: '2',
                labelWidget: Text(
                  context
                      .localizations
                      .admin_panel_screen_button_edit_rights_right_level_2,
                  style: AppTextTheme.bodyMedium(context),
                ),
              ),
            ],
            initialSelection: account.rights,
            onSelected: (value) {
              updateAccountRights(account, value!);
            },
          ),
        ],
      ),
    );
  }
}
