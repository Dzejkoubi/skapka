import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
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
  final List<LeaderDependentModel> _groupDependentLeaders = [];
  final List<DependentModel> _groupDependentChildren = [];

  @override
  void initState() {
    super.initState();
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
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_participants_screen_title,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              for (var patrol in widget.groupPatrols)
                PatrolExpansionTile(
                  patrol: patrol,
                  dependents: widget.groupDependents,
                  leaders: widget.groupLeaders,
                  selectedParticipants: widget.initialParticipants,
                  onChanged: (updatedParticipants) {
                    // Handle participant changes here
                  },
                ),
            ],
          ),
        ),
      ),
      speedDialChildren: [
        SpeedDialChild(
          labelWidget: MainButton.text(
            variant: ButtonStylesVariants.destructive,
            text: AppLocalizations.of(
              context,
            )!.create_edit_participants_screen_dial_limit,
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
            text: AppLocalizations.of(
              context,
            )!.create_edit_participants_screen_dial_print,
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
