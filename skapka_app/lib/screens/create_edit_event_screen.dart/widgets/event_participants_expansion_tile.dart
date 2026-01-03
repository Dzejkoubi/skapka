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

class PatrolExpansionTile extends StatelessWidget {
  final PatrolModel patrol;
  final List<DependentModel> dependents;
  final List<LeaderModel> leaders;
  final List<EventParticipantModel> selectedParticipants;
  final Function(List<EventParticipantModel>) onChanged;

  const PatrolExpansionTile({
    super.key,
    required this.patrol,
    required this.dependents,
    required this.leaders,
    required this.selectedParticipants,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final patrolLeaders = dependents
        .where((d) => leaders.any((l) => l.dependentId == d.dependentId))
        .toList();
    final patrolKids = dependents
        .where((d) => !leaders.any((l) => l.dependentId == d.dependentId))
        .toList();

    return Container(
      decoration: ShapeDecoration(
        color: context.colors.background.light,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: AppRadius.medium,
            cornerSmoothing: AppRadius.smoothNormal,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(patrol.name, style: AppTextTheme.titleSmall(context)),
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
      onChanged: (value) {
        final newList = List<EventParticipantModel>.from(selectedParticipants);
        if (value == true) {
          newList.add(
            EventParticipantModel(
              eventId: '',
              groupId: dependent.groupId,
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

class ParticipantRow extends StatelessWidget {
  final DependentModel dependent;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const ParticipantRow({
    super.key,
    required this.dependent,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxSmall),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${dependent.name} ${dependent.surname}',
              style: AppTextTheme.bodyMedium(context),
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: context.colors.primary.normal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
