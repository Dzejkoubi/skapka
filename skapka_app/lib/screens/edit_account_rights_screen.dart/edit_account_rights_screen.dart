import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/screens/edit_account_rights_screen.dart/widgets/edit_account_rights_account_box.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/centered_loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EditAccountRightsScreen extends StatelessWidget {
  const EditAccountRightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    final SupabaseService supabaseService = SupabaseService();
    final LoadingProvider loadingProvider = context.read<LoadingProvider>();

    loadGroupAccounts() async {
      List<AccountModel> accounts = await supabaseService.getGroupAccounts(
        accountProvider.groupId,
        onlyNotApproved: false,
      );
      // If new accounts are the same as current, do not update(this also solves issue if any of the lists is empty)
      if (context.mounted && (accounts != adminProvider.groupAccounts)) {
        adminProvider.setGroupAccounts(accounts);
      }
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        adminProvider.clearSearchQuery();
      },
      child: ScreenWrapper(
        appBar: Appbar(
          showBackChevron: true,
          showSettingsIcon: false,
          screenName:
              context.localizations.admin_panel_screen_button_edit_rights,
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
                  Column(
                    children: [
                      CustomForm(
                        showSuffixIcon: false,
                        controller: TextEditingController(),
                        onChanged: (String value) {
                          adminProvider.setSearchQuery(value);
                        },
                        labelText: context
                            .localizations
                            .admin_panel_screen_search_field_hint,
                      ),
                      Selector<AdminPanelProvider, String>(
                        selector: (_, provider) => provider.searchQuery,
                        builder: (context, surnameSearchQuery, __) {
                          if (surnameSearchQuery.isEmpty) {
                            return Column(
                              children: [
                                const SizedBox(height: AppSpacing.xSmall),
                                Text(
                                  context
                                      .localizations
                                      .admin_panel_screen_button_edit_rights_cant_change_admin_rights,
                                  style: AppTextTheme.bodySmall(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  // List of accounts to approve
                  FutureBuilder(
                    future: loadGroupAccounts(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CenteredLoadingRotatingLogo();
                      }
                      return Consumer<AdminPanelProvider>(
                        builder: (context, adminProvider, child) {
                          final query = adminProvider.searchQuery.toLowerCase();
                          final filteredAccounts = adminProvider.groupAccounts
                              .where((a) {
                                if (query.isEmpty) return true;
                                final fullName = '${a.name} ${a.surname}'
                                    .toLowerCase();
                                final reversedName = '${a.surname} ${a.name}'
                                    .toLowerCase();
                                return fullName.contains(query) ||
                                    reversedName.contains(query);
                              })
                              .toList();

                          return Column(
                            spacing: AppSpacing.medium,
                            children: [
                              // Show accounts that have rights 0, 1, 2 in this order
                              for (var account in [
                                ...filteredAccounts.where(
                                  (a) => (a.rights == 1),
                                ),
                                ...filteredAccounts.where(
                                  (a) => (a.rights == 2),
                                ),
                              ])
                                EditAccountRightsAccountBox(
                                  account: account,
                                  loadingProvider: loadingProvider,
                                  supabaseService: supabaseService,
                                  loadGroupAccounts: loadGroupAccounts,
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
