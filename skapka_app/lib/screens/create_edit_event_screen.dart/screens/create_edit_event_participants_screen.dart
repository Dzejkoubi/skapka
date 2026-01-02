import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
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
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_participants_screen_title,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
}
