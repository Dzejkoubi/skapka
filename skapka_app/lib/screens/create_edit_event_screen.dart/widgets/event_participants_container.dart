import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/participant_info_row.dart';

class EventParticipantsContainer extends StatelessWidget {
  final int originalParticipantsCount;
  final int invitedParticipantsCount;
  final int signedUpParticipantsCount;
  final int invitedLeadersCount;
  final int signedUpLeadersCount;
  final int invited18PlusLeadersCount;
  final int signedUp18PlusLeadersCount;
  final String targetPatrolNames;
  final List<DependentModel> groupDependents;
  final List<LeaderModel> groupLeaders;
  final List<PatrolModel> groupPatrols;
  final List<TroopModel> groupTroops;
  final List<EventParticipantModel> initialParticipants;
  final ValueChanged<List<EventParticipantModel>>? onParticipantsChanged;

  const EventParticipantsContainer({
    super.key,
    required this.originalParticipantsCount,
    required this.invitedParticipantsCount,
    required this.signedUpParticipantsCount,
    required this.invitedLeadersCount,
    required this.signedUpLeadersCount,
    required this.invited18PlusLeadersCount,
    required this.signedUp18PlusLeadersCount,
    required this.targetPatrolNames,
    required this.groupDependents,
    required this.groupLeaders,
    required this.groupPatrols,
    required this.groupTroops,
    required this.initialParticipants,
    this.onParticipantsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.primaryContainer(context),
      padding: EdgeInsets.all(AppSpacing.small),
      child: Column(
        spacing: AppSpacing.medium,
        children: [
          GestureDetector(
            onTap: () async {
              final result = await context.router.push(
                CreateEditEventParticipantsRoute(
                  groupDependents: groupDependents,
                  groupLeaders: groupLeaders,
                  groupPatrols: groupPatrols,
                  groupTroops: groupTroops,
                  initialParticipants: initialParticipants,
                ),
              );
              if (result != null && result is List<EventParticipantModel>) {
                onParticipantsChanged?.call(result);
              }
            },
            child: Container(
              decoration: AppDecorations.secondaryContainer(context),
              width: double.infinity,
              padding: EdgeInsets.all(AppSpacing.xSmall),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/chevron-right.svg',
                    width: AppSizes.iconSizeSmall,
                    height: AppSizes.iconSizeSmall,
                    colorFilter: ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.create_edit_event_screen_select_participants_text,
                      style: AppTextTheme.titleSmall(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/chevron-right.svg',
                    width: AppSizes.iconSizeSmall,
                    height: AppSizes.iconSizeSmall,
                    colorFilter: ColorFilter.mode(
                      context.colors.primary.light,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xSmall),
            child: Column(
              spacing: AppSpacing.xSmall,
              children: [
                ParticipantInfoRow(
                  label: context
                      .localizations
                      .create_edit_event_screen_total_participants_text,
                  value: invitedParticipantsCount.toString(),
                ),

                if (originalParticipantsCount > 0)
                  ParticipantInfoRow(
                    label: context
                        .localizations
                        .create_edit_event_screen_total_signed_up_participants_text,
                    value: signedUpParticipantsCount.toString(),
                  ),
                if (originalParticipantsCount > 0)
                  ParticipantInfoRow(
                    label: context
                        .localizations
                        .create_edit_event_screen_signed_up_leaders,
                    value: signedUpLeadersCount.toString(),
                  ),
                if (originalParticipantsCount == 0)
                  ParticipantInfoRow(
                    label: context
                        .localizations
                        .create_edit_event_screen_invited_leaders,
                    value: invitedLeadersCount.toString(),
                  ),
                if (originalParticipantsCount > 0)
                  ParticipantInfoRow(
                    label: context
                        .localizations
                        .create_edit_event_screen_signed_up_18_plus,
                    value: signedUp18PlusLeadersCount.toString(),
                  ),
                if (originalParticipantsCount == 0)
                  ParticipantInfoRow(
                    label: context
                        .localizations
                        .create_edit_event_screen_invited_18_plus,
                    value: invited18PlusLeadersCount.toString(),
                  ),
                ParticipantInfoRow(
                  label: context.localizations.create_edit_event_screen_troops,
                  value: targetPatrolNames.isEmpty ? '-' : targetPatrolNames,
                  isScrollable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
