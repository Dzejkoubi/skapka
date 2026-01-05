import 'package:auto_route/auto_route.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/event_box/participant_event_status_box.dart';
import 'package:skapka_app/widgets/event_time_info.dart';
import 'package:url_launcher/url_launcher.dart';

class EventBox extends StatelessWidget {
  final EventModel event;
  final EventParticipantStatus? userStatus;
  final AccountDependentModel? dependent;
  final EventTimeType eventTimeType;
  final UnitsProvider unitsProvider;

  const EventBox({
    required this.event,
    this.userStatus,
    this.dependent,
    required this.eventTimeType,
    required this.unitsProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final bool isEnabled =
        eventTimeType == EventTimeType.live && event.closeSignUp!.isAfter(now);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (eventTimeType == EventTimeType.live || isUserLeader(context)) {
              // Navigate to event details screen
              Gaimon.soft();
              context.router.push(
                EventDetailsRoute(
                  event: event,
                  eventTimeType: eventTimeType,
                  unitsProvider: unitsProvider,
                ),
              );
            } else {
              Gaimon.error();
              BottomDialog.show(
                context,
                type: BottomDialogType.negative,
                description:
                    context.localizations.event_box_open_error_event_not_live,
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacing.medium),
            decoration: ShapeDecoration(
              color: context.colors.background.light,
              shape: SmoothRectangleBorder(
                side: BorderSide(
                  color: context.colors.background.medium,
                  width: 1,
                ),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.medium,
                  cornerSmoothing: AppRadius.smoothNormal,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: AppSpacing.xxLarge + AppSpacing.small,
                          ),
                          child: Text(
                            event.title ?? '',
                            style: AppTextTheme.titleSmall(context),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (event.targetPatrolsIds != null &&
                    event.targetPatrolsIds!.isNotEmpty) ...[
                  SizedBox(height: AppSpacing.xxSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        unitsProvider.patrols
                            .where(
                              (patrol) => event.targetPatrolsIds!.contains(
                                patrol.patrolId,
                              ),
                            )
                            .map((patrol) => patrol.name)
                            .join(', '),
                        textAlign: TextAlign.left,
                        style: AppTextTheme.labelLarge(
                          context,
                        ).copyWith(color: context.colors.text.muted),
                      ),
                    ],
                  ),
                ],
                if (eventTimeType == EventTimeType.past &&
                    event.photoAlbumLink != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(event.photoAlbumLink!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      child: Text.rich(
                        TextSpan(
                          text:
                              context.localizations.event_box_photos_link_text,
                          style: AppTextTheme.labelLarge(context).copyWith(
                            color: context.colors.secondary.normal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: AppSpacing.large),
                Container(
                  padding: EdgeInsets.all(AppSpacing.small),
                  decoration: ShapeDecoration(
                    color: context.colors.background.lightX,
                    shape: SmoothRectangleBorder(
                      side: BorderSide(
                        color: context.colors.background.mediumLight,
                        width: 1,
                      ),
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: AppRadius.small,
                        cornerSmoothing: AppRadius.smoothNormal,
                      ),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EventTimeInfo(event: event, eventTimeType: eventTimeType),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (eventTimeType == EventTimeType.live && dependent != null)
          Positioned(
            right: AppSpacing.medium,
            top: AppSpacing.medium,
            child: ParticipantEventStatusBox(
              status: userStatus ?? EventParticipantStatus.notSpecified,
              isEnabled: isEnabled,
              eventModel: event,
              dependent: dependent!,
            ),
          ),
      ],
    );
  }
}
