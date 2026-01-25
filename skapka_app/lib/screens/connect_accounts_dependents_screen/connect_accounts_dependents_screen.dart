import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/basic_expansion_tile.dart';

@RoutePage()
class ConnectAccountsDependentsScreen extends StatelessWidget {
  const ConnectAccountsDependentsScreen({super.key});

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
            for (var d in accountDependentsRelations) {
              debugPrint(
                'AccountDependentRelation: AccountId=${d.accountId}, DependentId=${d.dependentId}, isMainDependent=${d.isMainDependent}',
              );
            }
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
        screenName:
            context.localizations.admin_panel_screen_button_connect_dependents,
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
                          .admin_panel_screen_search_field_hint,
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
                          ...adminProvider.groupAccounts
                              .where((account) {
                                final query = adminProvider.surnameSearchQuery
                                    .toLowerCase();
                                final name = account.name.toLowerCase();
                                final surname = account.surname.toLowerCase();
                                return name.contains(query) ||
                                    surname.contains(query);
                              })
                              .map((account) {
                                final relations = adminProvider
                                    .groupAccountsDependentsRelations
                                    .where(
                                      (relation) =>
                                          relation.accountId ==
                                          account.accountId,
                                    );

                                final accountDependents = relations.map((
                                  relation,
                                ) {
                                  final dependent = adminProvider
                                      .groupDependents
                                      .where(
                                        (d) =>
                                            d.dependentId ==
                                            relation.dependentId,
                                      )
                                      .firstOrNull;

                                  if (dependent == null) return null;

                                  return AccountDependentModel(
                                    dependentId: dependent.dependentId,
                                    isLeader: dependent.isLeader,
                                    name: dependent.name,
                                    surname: dependent.surname,
                                    nickname: dependent.nickname,
                                    born: dependent.born,
                                    sex: dependent.sex,
                                    parent1Email: dependent.parent1Email,
                                    parent1Phone: dependent.parent1Phone,
                                    parent2Email: dependent.parent2Email,
                                    parent2Phone: dependent.parent2Phone,
                                    contactEmail: dependent.contactEmail,
                                    contactPhone: dependent.contactPhone,
                                    troopId: dependent.troopId,
                                    patrolId: dependent.patrolId,
                                    isArchived: dependent.isArchived,
                                    secretCode: dependent.secretCode,
                                    createdAt: dependent.createdAt,
                                    groupId: dependent.groupId,
                                    skautisId: dependent.skautisId,
                                    notes: const DependentNotesModel(),
                                    isMainDependent: relation.isMainDependent,
                                  );
                                }).whereType<AccountDependentModel>();
                                return BasicExpansionTile(
                                  title:
                                      '${account.name} ${account.surname} (${accountDependents.length})',
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...accountDependents.map(
                                        (dependent) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                '${dependent.name} ${dependent.surname}',
                                                style: AppTextTheme.bodyLarge(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: AppSpacing.medium),
                                            MainButton(
                                              style: ButtonStyleTypes.text,
                                              text: '',
                                              type: ButtonType.icon,
                                              variant: ButtonStylesVariants
                                                  .destructive,
                                              state: dependent.isMainDependent
                                                  ? ButtonState.disabled
                                                  : ButtonState.released,
                                              iconAsset:
                                                  'assets/icons/trash.svg',
                                              onPressed: () => showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return LargeDialog(
                                                    type: LargeDialogType
                                                        .negative,
                                                    title: context
                                                        .localizations
                                                        .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_title,
                                                    description: context
                                                        .localizations
                                                        .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_subtitle(
                                                          '${dependent.name} ${dependent.surname}',
                                                          '${account.name} ${account.surname}',
                                                        ),
                                                    primaryButtonText: context
                                                        .localizations
                                                        .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_title,
                                                    secondaryButtonText: context
                                                        .localizations
                                                        .cancel,
                                                    onPrimaryPressed: () {},
                                                    onSecondaryPressed: () {
                                                      context.pop();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: AppSpacing.medium),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MainButton(
                                            style: ButtonStyleTypes.outlined,
                                            variant:
                                                ButtonStylesVariants.normal,
                                            text: context
                                                .localizations
                                                .admin_panel_screen_connect_accounts_dependents_add_connection_button_text,
                                            onPressed: () =>
                                                context.router.push(
                                                  AddDependentsToAccountRoute(
                                                    adminProvider:
                                                        adminProvider,
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
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
