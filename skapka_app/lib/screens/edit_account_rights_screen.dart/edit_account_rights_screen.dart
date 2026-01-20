import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EditAccountRightsScreen extends StatelessWidget {
  const EditAccountRightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    final SupabaseService supabaseService = SupabaseService();

    loadGroupAccounts() async {
      List<AccountModel> accounts = await supabaseService.getGroupAccounts(
        accountProvider.groupId,
        onlyNotApproved: false,
        surnameSearchQuery: adminProvider.surnameSearchQuery,
      );
      // If new accounts are the same as current, do not update(this also solves issue if any of the lists is empty)
      if (context.mounted && (accounts != adminProvider.groupAccounts)) {
        adminProvider.setGroupAccounts(accounts);
      }
    }

    updateAccountRights(AccountModel account, int newRights) async {
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
      }
    }

    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.admin_panel_screen_button_edit_rights,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.bottomSpace + AppSpacing.xxLarge,
            ),
            child: Column(
              spacing: AppSpacing.large,
              children: [
                // Search bar for accounts
                CustomForm(
                  showSuffixIcon: false,
                  controller: TextEditingController(),
                  onChanged: (String value) {
                    // Update provider and debounce the actual fetch
                    adminProvider.setSurnameSearchQueryDebounced(
                      value,
                      loadGroupAccounts,
                    );
                  },
                  labelText: context
                      .localizations
                      .admin_panel_screen_button_edit_rights_search_field_hint,
                ),
                // List of accounts to approve
                FutureBuilder(
                  future: loadGroupAccounts(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingRotatingLogo();
                    }
                    return Consumer<AdminPanelProvider>(
                      builder: (context, adminProvider, child) => Column(
                        spacing: AppSpacing.medium,
                        children: [
                          // Show accounts that have rights 0, 1, 2 in this order
                          for (var account in [
                            ...adminProvider.groupAccounts.where(
                              (a) => (a.rights == 1),
                            ),
                            ...adminProvider.groupAccounts.where(
                              (a) => (a.rights == 2),
                            ),
                          ])
                            Container(
                              decoration: AppDecorations.primaryContainer(
                                context,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.medium,
                                vertical: AppSpacing.small,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: AppTextTheme.bodyMedium(
                                            context,
                                          ),
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: 2,
                                        label: '2',
                                        labelWidget: Text(
                                          context
                                              .localizations
                                              .admin_panel_screen_button_edit_rights_right_level_2,
                                          style: AppTextTheme.bodyMedium(
                                            context,
                                          ),
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
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
