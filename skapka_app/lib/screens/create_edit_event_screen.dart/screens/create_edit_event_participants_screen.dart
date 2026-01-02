import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/leader_dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/screens/widgets/participant_row.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/content_switcher.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/screens/widgets/patrol_expansion_tile.dart';

@RoutePage()
class CreateEditEventParticipantsScreen extends StatefulWidget {
  final List<DependentModel> groupDependents;
  final List<PatrolModel> groupPatrols;
  final List<TroopModel> groupTroops;
  final List<LeaderModel> groupLeaders;
  final List<EventParticipantModel> initialParticipants;

  const CreateEditEventParticipantsScreen({
    super.key,
    required this.groupDependents,
    required this.groupPatrols,
    required this.groupTroops,
    required this.groupLeaders,
    required this.initialParticipants,
  });

  @override
  State<CreateEditEventParticipantsScreen> createState() =>
      _CreateEditEventParticipantsScreenState();
}

class _CreateEditEventParticipantsScreenState
    extends State<CreateEditEventParticipantsScreen> {
  int _activeSwitcherIndex = 0;
  late List<EventParticipantModel> _selectedParticipants;

  void onChanged(int index) {
    setState(() {
      _activeSwitcherIndex = index;
    });
  }

  final List<LeaderDependentModel> _groupDependentLeaders = [];
  final List<DependentModel> _groupDependentChildren = [];

  @override
  void initState() {
    super.initState();
    _selectedParticipants = List.from(widget.initialParticipants);
    _separateDependents();
  }

  void _separateDependents() {
    _groupDependentLeaders.clear();
    _groupDependentChildren.clear();
    for (var dependent in widget.groupDependents) {
      if (dependent.isLeader) {
        final ledPatrols = widget.groupLeaders
            .where((l) => l.dependentId == dependent.dependentId)
            .map((l) => l.patrolId)
            .toList();
        _groupDependentLeaders.add(
          LeaderDependentModel(
            dependent: dependent,
            leaderOfPatrolId: ledPatrols,
          ),
        );
      } else {
        _groupDependentChildren.add(dependent);
      }
    }
    if (kDebugMode) {
      print(
        'Fetched ${widget.groupDependents.length} dependents: '
        '${_groupDependentLeaders.length} leaders and '
        '${_groupDependentChildren.length} children.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.create_edit_participants_screen_title,
        onBackPressed: () => context.router.pop(_selectedParticipants),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Content switcher with troops and leaders + top padding and side margins
            SizedBox(height: Appbar.topBarHeight + Appbar.bottomRadius),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: AppSpacing.xLarge),
                  ContentSwitcher(
                    items: [
                      ...widget.groupTroops.map((troop) => troop.name),
                      context
                          .localizations
                          .create_edit_participants_screen_leaders,
                    ],
                    selectedIndex: _activeSwitcherIndex,
                    onChanged: onChanged,
                  ),
                  SizedBox(width: AppSpacing.xLarge),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
              child: Column(children: [_buildContent(_activeSwitcherIndex)]),
            ),
          ],
        ),
      ),
      speedDialChildren: [
        SpeedDialChild(
          labelWidget: MainButton.text(
            variant: ButtonStylesVariants.destructive,
            text: context
                .localizations
                .create_edit_participants_screen_dial_limit,
            onPressed: () {
              if (kDebugMode) {
                print(
                  'Set Participant Limit',
                ); // TODO: implement set participant limit
              }
            },
          ),
        ),
        SpeedDialChild(
          labelWidget: MainButton.outlined(
            variant: ButtonStylesVariants.normal,
            type: ButtonType.textIcon,
            iconAsset: 'assets/icons/printer.svg',
            text: context
                .localizations
                .create_edit_participants_screen_dial_print,
            onPressed: () {
              if (kDebugMode) {
                print('Print List'); // TODO: implement print list
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContent(int activeIndex) {
    if (activeIndex == widget.groupTroops.length) {
      // Leaders tab
      final allLeaderIds = _groupDependentLeaders
          .map((l) => l.dependentId)
          .toSet();
      final selectedLeaderIds = _selectedParticipants
          .map((p) => p.dependentId)
          .where((id) => allLeaderIds.contains(id))
          .toSet();

      final areAllSelected =
          allLeaderIds.isNotEmpty &&
          selectedLeaderIds.length == allLeaderIds.length;
      final areSomeSelected =
          selectedLeaderIds.isNotEmpty &&
          selectedLeaderIds.length < allLeaderIds.length;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.small),
            child: Row(
              children: [
                Checkbox(
                  value: areAllSelected
                      ? true
                      : (areSomeSelected ? null : false),
                  tristate: true,
                  activeColor: context.colors.primary.normal,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: AppRadius.xxSmall,
                      cornerSmoothing: AppRadius.smoothNormal,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (!areAllSelected) {
                        for (var leader in _groupDependentLeaders) {
                          if (!_selectedParticipants.any(
                            (p) => p.dependentId == leader.dependentId,
                          )) {
                            _selectedParticipants.add(
                              EventParticipantModel(
                                eventId: widget.initialParticipants.isNotEmpty
                                    ? widget.initialParticipants.first.eventId
                                    : '',
                                dependentId: leader.dependentId!,
                                status: EventParticipantStatus.notSpecified,
                                note: '',
                              ),
                            );
                          }
                        }
                      } else {
                        _selectedParticipants.removeWhere(
                          (p) => allLeaderIds.contains(p.dependentId),
                        );
                      }
                    });
                  },
                ),
                const SizedBox(width: AppSpacing.small),
                Text(
                  context
                      .localizations
                      .create_edit_participants_screen_select_all,
                  style: AppTextTheme.titleSmall(context),
                ),
              ],
            ),
          ),
          ..._groupDependentLeaders.map((leader) {
            final isSelected = _selectedParticipants.any(
              (p) => p.dependentId == leader.dependentId,
            );
            return Column(
              children: [
                ParticipantRow(
                  dependent: leader,
                  isSelected: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedParticipants.add(
                          EventParticipantModel(
                            eventId: widget.initialParticipants.isNotEmpty
                                ? widget.initialParticipants.first.eventId
                                : '',
                            dependentId: leader.dependentId!,
                            status: EventParticipantStatus.notSpecified,
                            note: '',
                          ),
                        );
                      } else {
                        _selectedParticipants.removeWhere(
                          (p) => p.dependentId == leader.dependentId,
                        );
                      }
                    });
                  },
                ),
              ],
            );
          }),
        ],
      );
    } else {
      final selectedTroop = widget.groupTroops[activeIndex];

      final troopPatrols = widget.groupPatrols
          .where((patrol) => patrol.troopId == selectedTroop.troopId)
          .toList();

      // Calculate all dependents for this troop (members + leaders of patrols in this troop)
      final troopPatrolIds = troopPatrols.map((p) => p.patrolId).toSet();

      final troopLeaderIds = widget.groupLeaders
          .where((l) => troopPatrolIds.contains(l.patrolId))
          .map((l) => l.dependentId)
          .toSet();

      final allTroopDependents = widget.groupDependents.where((d) {
        final isMember = troopPatrolIds.contains(d.patrolId);
        final isLeader = troopLeaderIds.contains(d.dependentId);
        return isMember || isLeader;
      }).toList();

      final allTroopDependentIds = allTroopDependents
          .map((d) => d.dependentId)
          .toSet();

      final selectedTroopDependentIds = _selectedParticipants
          .map((p) => p.dependentId)
          .where((id) => allTroopDependentIds.contains(id))
          .toSet();

      final areAllSelected =
          allTroopDependentIds.isNotEmpty &&
          selectedTroopDependentIds.length == allTroopDependentIds.length;
      final areSomeSelected =
          selectedTroopDependentIds.isNotEmpty &&
          selectedTroopDependentIds.length < allTroopDependentIds.length;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.small),
            child: Row(
              children: [
                Checkbox(
                  value: areAllSelected
                      ? true
                      : (areSomeSelected ? null : false),
                  tristate: true,
                  activeColor: context.colors.primary.normal,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: AppRadius.xxSmall,
                      cornerSmoothing: AppRadius.smoothNormal,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (!areAllSelected) {
                        for (var dependent in allTroopDependents) {
                          if (!_selectedParticipants.any(
                            (p) => p.dependentId == dependent.dependentId,
                          )) {
                            _selectedParticipants.add(
                              EventParticipantModel(
                                eventId: widget.initialParticipants.isNotEmpty
                                    ? widget.initialParticipants.first.eventId
                                    : '',
                                dependentId: dependent.dependentId!,
                                status: EventParticipantStatus.notSpecified,
                                note: '',
                              ),
                            );
                          }
                        }
                      } else {
                        _selectedParticipants.removeWhere(
                          (p) => allTroopDependentIds.contains(p.dependentId),
                        );
                      }
                    });
                  },
                ),
                const SizedBox(width: AppSpacing.small),
                Text(
                  context
                      .localizations
                      .create_edit_participants_screen_select_all,
                  style: AppTextTheme.titleSmall(context),
                ),
              ],
            ),
          ),
          Column(
            spacing: AppSpacing.small,
            children: troopPatrols.map((patrol) {
              final patrolLeaderIds = widget.groupLeaders
                  .where((l) => l.patrolId == patrol.patrolId)
                  .map((l) => l.dependentId)
                  .toSet();

              final patrolDependents = widget.groupDependents.where((d) {
                final isMember = d.patrolId == patrol.patrolId;
                final isLeader = patrolLeaderIds.contains(d.dependentId);
                return isMember || isLeader;
              }).toList();

              return PatrolExpansionTile(
                patrol: patrol,
                dependents: patrolDependents,
                leaders: widget.groupLeaders,
                selectedParticipants: _selectedParticipants,
                eventId: widget.initialParticipants.isNotEmpty
                    ? widget.initialParticipants.first.eventId
                    : '',
                onChanged: (updatedList) {
                  setState(() {
                    _selectedParticipants = updatedList;
                  });
                },
              );
            }).toList(),
          ),
        ],
      );
    }
  }
}
