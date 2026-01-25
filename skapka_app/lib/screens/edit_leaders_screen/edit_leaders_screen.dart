import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/dependents/leader_dependent_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/screens/edit_leaders_screen/widgets/edit_leaders_leader_box.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EditLeadersScreen extends StatelessWidget {
  const EditLeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    AccountProvider accountProvider = context.read<AccountProvider>();
    final SupabaseService supabaseService = SupabaseService();

    // Load dependents and leaders if not already loaded
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
        if (adminProvider.groupLeaders.isEmpty) {
          final leaders = await supabaseService.getGroupLeaders(groupId);
          debugPrint(
            'EditLeadersScreen: Fetched ${leaders.length} leaders from DB',
          );
          if (context.mounted &&
              !listEquals(adminProvider.groupLeaders, leaders)) {
            adminProvider.setGroupLeaders(leaders);
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
            context.localizations.admin_panel_screen_button_edit_leaders,
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
                CustomForm(
                  showSuffixIcon: false,
                  controller: TextEditingController(),
                  onChanged: (String value) {
                    // Update provider and debounce the actual fetch
                    adminProvider.setSurnameSearchQueryDebounced(
                      value,
                      () async {},
                    );
                  },
                  labelText: context
                      .localizations
                      .admin_panel_screen_button_approve_accounts_search_field_hint,
                ),
                FutureBuilder(
                  future: loadData(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: AppSpacing.medium),
                              LoadingRotatingLogo(),
                              SizedBox(height: AppSpacing.medium),
                            ],
                          ),
                        ),
                      );
                    }
                    return Consumer<AdminPanelProvider>(
                      builder: (context, adminProvider, child) {
                        final query = adminProvider.surnameSearchQuery
                            .toLowerCase();
                        final dependents = adminProvider.groupDependents.where((
                          d,
                        ) {
                          if (query.isEmpty) return true;
                          final fullName = '${d.name} ${d.surname}'
                              .toLowerCase();
                          final reversedName = '${d.surname} ${d.name}'
                              .toLowerCase();
                          return fullName.contains(query) ||
                              reversedName.contains(query);
                        }).toList();

                        final leaders = adminProvider.groupLeaders;

                        final Set<String> dependentIdsWithLeader = leaders
                            .map((leader) => leader.dependentId)
                            .toSet();

                        final leaderDependents = dependents
                            .where((d) => d.isLeader)
                            .map((d) {
                              // Find all patrols this dependent is a leader of
                              final leaderOfPatrols = leaders
                                  .where((l) => l.dependentId == d.dependentId)
                                  .map((l) => l.patrolId)
                                  .toList();

                              return LeaderDependentModel(
                                dependent: d,
                                leaderOfPatrolId: leaderOfPatrols,
                              );
                            })
                            .toList();

                        // Sort leaders: first those who have a leader entry (assigned patrols), then others
                        leaderDependents.sort((a, b) {
                          // Check if leader has entry in leaders table (has assigned patrols)
                          final aHasLeadersEntry = dependentIdsWithLeader
                              .contains(a.dependent.dependentId);
                          final bHasLeadersEntry = dependentIdsWithLeader
                              .contains(b.dependent.dependentId);

                          if (aHasLeadersEntry && !bHasLeadersEntry) return -1;
                          if (!aHasLeadersEntry && bHasLeadersEntry) return 1;
                          return a.dependent.surname.compareTo(
                            b.dependent.surname,
                          );
                        });

                        final regularDependents = dependents
                            .where((d) => !d.isLeader)
                            .toList();
                        regularDependents.sort(
                          (a, b) => a.surname.compareTo(b.surname),
                        );

                        return Column(
                          spacing: AppSpacing.medium,
                          children: [
                            if (leaderDependents.isNotEmpty)
                              ...leaderDependents.map(
                                (leader) => EditLeadersLeaderBox(
                                  leader: leader,
                                  onRefresh: () {
                                    adminProvider.groupDependents.clear();
                                    adminProvider.groupLeaders.clear();
                                    loadData();
                                  },
                                ),
                              ),
                            Divider(color: context.colors.background.medium),
                            if (regularDependents.isNotEmpty)
                              ...regularDependents.map(
                                (dependent) => EditLeadersLeaderBox(
                                  dependent: dependent,
                                  onRefresh: () {
                                    adminProvider.groupDependents.clear();
                                    adminProvider.groupLeaders.clear();
                                    loadData();
                                  },
                                ),
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
    );
  }
}
