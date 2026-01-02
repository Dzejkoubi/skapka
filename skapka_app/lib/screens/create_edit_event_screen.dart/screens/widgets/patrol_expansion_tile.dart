import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/screens/widgets/participant_row.dart';

class PatrolExpansionTile extends StatelessWidget {
  final PatrolModel patrol;
  final List<DependentModel> dependents;
  final List<LeaderModel> leaders;
  final List<EventParticipantModel> selectedParticipants;
  final Function(List<EventParticipantModel>) onChanged;
  final String eventId;

  const PatrolExpansionTile({
    super.key,
    required this.patrol,
    required this.dependents,
    required this.leaders,
    required this.selectedParticipants,
    required this.onChanged,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final patrolLeaders = dependents
        .where(
          (d) => leaders.any(
            (l) =>
                l.dependentId == d.dependentId && l.patrolId == patrol.patrolId,
          ),
        )
        .toList();
    final patrolKids = dependents
        .where(
          (d) => !leaders.any(
            (l) =>
                l.dependentId == d.dependentId && l.patrolId == patrol.patrolId,
          ),
        )
        .toList();

    // Calculate selection state
    final allDependentsIds = dependents.map((d) => d.dependentId).toSet();
    final selectedDependentsIds = selectedParticipants
        .map((p) => p.dependentId)
        .where((id) => allDependentsIds.contains(id))
        .toSet();

    final areAllSelected =
        allDependentsIds.isNotEmpty &&
        selectedDependentsIds.length == allDependentsIds.length;
    final areSomeSelected =
        selectedDependentsIds.isNotEmpty &&
        selectedDependentsIds.length < allDependentsIds.length;

    final border = SmoothRectangleBorder(
      side: BorderSide(color: context.colors.background.medium, width: 1.5),
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.medium,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        shape: border,
        collapsedShape: border,
        backgroundColor: context.colors.background.light,
        collapsedBackgroundColor: context.colors.background.light,
        title: Row(
          children: [
            Checkbox(
              value: areAllSelected ? true : (areSomeSelected ? null : false),
              tristate: true,
              activeColor: context.colors.primary.normal,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.xxSmall,
                  cornerSmoothing: AppRadius.smoothNormal,
                ),
              ),
              onChanged: (value) {
                final newSelectedParticipants =
                    List<EventParticipantModel>.from(selectedParticipants);

                // If not all are selected, we select all. Otherwise we deselect all.
                final shouldSelectAll = !areAllSelected;

                if (shouldSelectAll) {
                  for (var dependent in dependents) {
                    if (!newSelectedParticipants.any(
                      (p) => p.dependentId == dependent.dependentId,
                    )) {
                      newSelectedParticipants.add(
                        EventParticipantModel(
                          eventId: eventId,
                          dependentId: dependent.dependentId!,
                          status: EventParticipantStatus.notSpecified,
                          note: '',
                        ),
                      );
                    }
                  }
                } else {
                  newSelectedParticipants.removeWhere(
                    (p) => allDependentsIds.contains(p.dependentId),
                  );
                }
                onChanged(newSelectedParticipants);
              },
            ),
            const SizedBox(width: AppSpacing.small),
            Text(patrol.name, style: AppTextTheme.titleSmall(context)),
          ],
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
        children: [
          if (patrolLeaders.isNotEmpty) ...[
            _buildSectionTitle(context, 'Vedoucí'),
            ...patrolLeaders.map(
              (leader) => _buildParticipantRow(context, leader),
            ),
            const SizedBox(height: AppSpacing.small),
          ],
          if (patrolKids.isNotEmpty) ...[
            _buildSectionTitle(context, 'Děti'),
            ...patrolKids.map((kid) => _buildParticipantRow(context, kid)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.small),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextTheme.bodySmall(context).copyWith(
            color: context.colors.text.muted,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantRow(BuildContext context, DependentModel dependent) {
    final isSelected = selectedParticipants.any(
      (p) => p.dependentId == dependent.dependentId,
    );
    return ParticipantRow(
      dependent: dependent,
      isSelected: isSelected,
      is18plus: dependent.is18plus,
      onChanged: (value) {
        final newList = List<EventParticipantModel>.from(selectedParticipants);
        if (value == true) {
          newList.add(
            EventParticipantModel(
              eventId: '',
              dependentId: dependent.dependentId!,
              status: EventParticipantStatus.notSpecified,
              note: '',
            ),
          );
        } else {
          newList.removeWhere((p) => p.dependentId == dependent.dependentId);
        }
        onChanged(newList);
      },
    );
  }
}
