import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class ConnectAccountDependentsScreen extends StatelessWidget {
  const ConnectAccountDependentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    final SupabaseService supabaseService = SupabaseService();
    final LoadingProvider loadingProvider = context.read<LoadingProvider>();
    // Load or fetch group accounts from Supabase
    // Load or fetch dependents from Supabase
    // Load or fetch account_dependents connections from Supabase
    // Show list of accounts with their dependents underneath with bin icon to remove connection
    // Plus icon next to the account name surname to open screen with list of dependents to connect

    loadData() async {
      final groupId = accountProvider.groupId;

      try {
        if (adminProvider.groupDependents.isEmpty) {
          final dependents = await supabaseService.getGroupDependents(
            groupId: groupId,
          );
          debugPrint(
            'EditLeadersScreen: Fetched ${dependents.length} dependents from DB',
          );
          if (context.mounted &&
              !listEquals(adminProvider.groupDependents, dependents)) {
            adminProvider.setGroupDependents(dependents);
          }
        }
        if (adminProvider.groupAccounts.isEmpty) {
          final accounts = await supabaseService.getGroupAccounts(groupId);
          debugPrint(
            'EditLeadersScreen: Fetched ${accounts.length} accounts from DB',
          );
          if (context.mounted &&
              !listEquals(adminProvider.groupAccounts, accounts)) {
            adminProvider.setGroupAccounts(accounts);
          }
        }
        if (adminProvider.groupAccountsDependentsRelations.isEmpty) {
          final accountDependentsRelations = await supabaseService
              .getAccountDependentRelationsByGroup(groupId: groupId);
          debugPrint(
            'EditLeadersScreen: Fetched ${accountDependentsRelations.length} account_dependents from DB',
          );
          if (context.mounted &&
              !listEquals(
                adminProvider.groupAccountsDependentsRelations,
                accountDependentsRelations,
              )) {
            debugPrint(
              'EditLeadersScreen: Setting ${accountDependentsRelations.length} account_dependents in provider',
            );
            adminProvider.setGroupAccountDependents(accountDependentsRelations);
          }
        }
      } catch (e) {
        debugPrint('Error loading data in EditLeadersScreen: $e');
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
                Column(
                  children: [
                    CustomForm(
                      showSuffixIcon: false,
                      controller: TextEditingController(),
                      onChanged: (String value) {
                        // Update provider and debounce the actual fetch
                        adminProvider.setSurnameSearchQueryDebounced(
                          value,
                          loadData,
                        );
                      },
                      labelText: context
                          .localizations
                          .admin_panel_screen_button_edit_rights_search_field_hint,
                    ),
                  ],
                ),
                // List of accounts to approve
                FutureBuilder(
                  future: loadData(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingRotatingLogo();
                    }
                    return Consumer<AdminPanelProvider>(
                      builder: (context, adminProvider, child) => Column(
                        spacing: AppSpacing.medium,
                        children: [
                          // List of accounts with dependents
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
