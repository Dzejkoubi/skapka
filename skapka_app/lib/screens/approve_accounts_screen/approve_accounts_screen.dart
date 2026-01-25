import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/screens/approve_accounts_screen/widgets/approve_accounts_account_box.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class ApproveAccountsScreen extends StatelessWidget {
  const ApproveAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    final SupabaseService supabaseService = SupabaseService();
    final LoadingProvider loadingProvider = context.read<LoadingProvider>();

    loadGroupAccounts() async {
      try {
        List<AccountModel> accounts = await supabaseService.getGroupAccounts(
          accountProvider.groupId,
          onlyNotApproved: false,
          surnameSearchQuery: adminProvider.surnameSearchQuery,
        );
        debugPrint(
          'ApproveAccountsScreen: Fetched ${accounts.length} accounts from DB',
        );

        // If new accounts are the same as current, do not update(this also solves issue if any of the lists is empty)
        if (context.mounted) {
          debugPrint(
            'ApproveAccountsScreen: Current provider accounts: ${adminProvider.groupAccounts.length}',
          );
          // Use listEquals to check content equality instead of reference equality
          if (!listEquals(accounts, adminProvider.groupAccounts)) {
            debugPrint(
              'ApproveAccountsScreen: Updating provider with new data',
            );
            adminProvider.setGroupAccounts(accounts);
          }
          // } else {
          //   debugPrint(
          //     'ApproveAccountsScreen: Data identical, skipping provider update',
          //   );
          // }
        }
      } catch (e) {
        debugPrint('ApproveAccountsScreen error: $e');
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations.generic_error,
          );
        }
      }
    }

    updateAccountApprovalStatus(AccountModel account, bool isApproved) async {
      loadingProvider.show();
      try {
        await supabaseService.changeAccountApproval(
          account.accountId,
          isApproved,
        );
        await loadGroupAccounts();
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_account_approval_change_success(
                  "${account.name} ${account.surname}",
                  isApproved ? "approved" : "disapproved",
                ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          debugPrint('Error updating account approval status: $e');
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations
                .admin_panel_screen_button_approve_accounts_error(
                  "${account.name} ${account.surname}",
                ),
          );
        }
      } finally {
        loadingProvider.hide();
      }
    }

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
                      .admin_panel_screen_button_approve_accounts_search_field_hint,
                ),
                // List of accounts to approve
                FutureBuilder(
                  future: loadGroupAccounts(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: AppSpacing.medium),
                          LoadingRotatingLogo(),
                          SizedBox(height: AppSpacing.medium),
                        ],
                      );
                    }
                    return Consumer<AdminPanelProvider>(
                      builder: (context, adminProvider, child) => Column(
                        spacing: AppSpacing.medium,
                        children: [
                          // Show accounts that are not approved first
                          for (var account in [
                            ...adminProvider.groupAccounts.where(
                              (a) => !a.isApproved,
                            ),
                            ...adminProvider.groupAccounts.where(
                              (a) => a.isApproved,
                            ),
                          ])
                            ApproveAccountsAccountBox(
                              account: account,
                              updateAccountApprovalStatus:
                                  updateAccountApprovalStatus,
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
