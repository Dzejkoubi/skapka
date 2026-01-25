import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/switch_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/loading_floating_logo/centered_loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class SetPatrolLeaderScreen extends StatelessWidget {
  final DependentModel dependent;

  const SetPatrolLeaderScreen({super.key, required this.dependent});

  @override
  Widget build(BuildContext context) {
    final AdminPanelProvider adminProvider = context.read<AdminPanelProvider>();
    final AccountProvider accountProvider = context.read<AccountProvider>();
    final UnitsProvider unitsProvider = context.read<UnitsProvider>();
    final SupabaseService supabaseService = SupabaseService();
    final LoadingProvider loadingProvider = context.read<LoadingProvider>();

    loadLeaders() async {
      try {
        final leaders = await supabaseService.getGroupLeaders(
          accountProvider.groupId,
        );
        if (context.mounted &&
            !listEquals(adminProvider.groupLeaders, leaders)) {
          adminProvider.setGroupLeaders(leaders);
        }
      } catch (e) {
        debugPrint('SetPatrolLeaderScreen error: $e');
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context
                .localizations
                .admin_panel_screen_set_patrol_leaders_loading_error,
          );
        }
      }
    }

    togglePatrolLeader(PatrolModel patrol, bool isAssigned) async {
      try {
        loadingProvider.show();
        if (isAssigned) {
          // Remove patrol leader assignment
          await supabaseService.removePatrolLeader(
            dependent.dependentId,
            patrol.patrolId,
          );
        } else {
          // Add patrol leader assignment
          await supabaseService.addPatrolLeader(
            dependentId: dependent.dependentId,
            patrolId: patrol.patrolId,
            groupId: accountProvider.groupId,
          );
        }
        await loadLeaders();
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: isAssigned
                ? context.localizations
                      .admin_panel_screen_set_patrol_leaders_removed(
                        "${dependent.name} ${dependent.surname}",
                        patrol.name,
                      )
                : context.localizations
                      .admin_panel_screen_set_patrol_leaders_assigned(
                        "${dependent.name} ${dependent.surname}",
                        patrol.name,
                      ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          debugPrint('Error toggling patrol leader: $e');
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context
                .localizations
                .admin_panel_screen_set_patrol_leaders_error,
          );
        }
      } finally {
        loadingProvider.hide();
      }
    }

    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations
            .admin_panel_screen_set_patrol_leaders_title(
              "${dependent.name} ${dependent.surname}",
            ),
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
                // List of patrols
                FutureBuilder(
                  future: loadLeaders(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CenteredLoadingRotatingLogo();
                    }
                    return Consumer<AdminPanelProvider>(
                      builder: (context, adminProvider, child) {
                        // Get patrol IDs that this dependent is leader of
                        final assignedPatrolIds = adminProvider.groupLeaders
                            .where(
                              (l) => l.dependentId == dependent.dependentId,
                            )
                            .map((l) => l.patrolId)
                            .toSet();

                        return Column(
                          spacing: AppSpacing.medium,
                          children: [
                            for (var patrol in unitsProvider.patrols)
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
                                      child: Text(
                                        patrol.name,
                                        style: AppTextTheme.bodyMedium(context),
                                      ),
                                    ),
                                    SwitchButton(
                                      value: assignedPatrolIds.contains(
                                        patrol.patrolId,
                                      ),
                                      onChanged: (value) {
                                        togglePatrolLeader(
                                          patrol,
                                          assignedPatrolIds.contains(
                                            patrol.patrolId,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
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
