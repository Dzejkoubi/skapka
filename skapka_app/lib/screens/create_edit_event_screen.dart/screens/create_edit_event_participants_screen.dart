import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/content_switcher.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_participants_expansion_tile.dart';

@RoutePage()
class CreateEditEventParticipantsScreen extends StatefulWidget {
  final List<DependentModel> groupDependents;
  final List<LeaderModel> groupLeaders;
  final List<PatrolModel> groupPatrols;
  final List<TroopModel> groupTroops;
  final List<EventParticipantModel> initialParticipants;

  const CreateEditEventParticipantsScreen({
    super.key,
    required this.groupDependents,
    required this.groupLeaders,
    required this.groupPatrols,
    required this.groupTroops,
    required this.initialParticipants,
  });

  @override
  State<CreateEditEventParticipantsScreen> createState() =>
      _CreateEditEventParticipantsScreenState();
}

class _CreateEditEventParticipantsScreenState
    extends State<CreateEditEventParticipantsScreen> {
  int _selectedTroopIndex = 0;
  late List<EventParticipantModel> _selectedParticipants;

  @override
  void initState() {
    super.initState();
    _selectedParticipants = List.from(widget.initialParticipants);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> switcherItems = [
      ...widget.groupTroops.map((t) => t.name),
      'Vedoucí',
    ];

    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_participants_screen_title,
        onBackPressed: () => context.router.pop(_selectedParticipants),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: ContentSwitcher(
                items: switcherItems,
                selectedIndex: _selectedTroopIndex,
                onChanged: (index) =>
                    setState(() => _selectedTroopIndex = index),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.medium,
                ),
                child: _buildContent(),
              ),
            ),
          ],
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

  Widget _buildContent() {
    if (_selectedTroopIndex < widget.groupTroops.length) {
      final selectedTroop = widget.groupTroops[_selectedTroopIndex];
      final troopPatrols = widget.groupPatrols
          .where((p) => p.troopId == selectedTroop.troopId)
          .toList();

      return Column(
        spacing: AppSpacing.medium,
        children: [
          ...troopPatrols.map((patrol) {
            return PatrolExpansionTile(
              patrol: patrol,
              dependents: widget.groupDependents
                  .where((d) => d.patrolId == patrol.patrolId)
                  .toList(),
              leaders: widget.groupLeaders,
              selectedParticipants: _selectedParticipants,
              onChanged: (updatedParticipants) {
                setState(() {
                  _selectedParticipants = updatedParticipants;
                });
              },
            );
          }),
          const SizedBox(height: AppSpacing.bottomSpace),
        ],
      );
    } else {
      // Show all leaders
      final allLeaders = widget.groupDependents
          .where(
            (d) =>
                widget.groupLeaders.any((l) => l.dependentId == d.dependentId),
          )
          .toList();

      return Column(
        children: [
          ...allLeaders.map((leader) {
            final isSelected = _selectedParticipants.any(
              (p) => p.dependentId == leader.dependentId,
            );
            return ParticipantRow(
              dependent: leader,
              isSelected: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedParticipants.add(
                      EventParticipantModel(
                        eventId: '', // Will be set on save
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
            );
          }),
          const SizedBox(height: AppSpacing.bottomSpace),
        ],
      );
    }
  }
}
