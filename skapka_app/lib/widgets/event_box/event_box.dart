import 'package:auto_route/auto_route.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/event_box/user_status_box.dart';
import 'package:skapka_app/widgets/event_time_info.dart';
import 'package:url_launcher/url_launcher.dart';

class EventBox extends StatelessWidget {
  final EventModel event;
  final UserStatus? userStatus;
  final String? dependentId;
  final EventTimeType eventTimeType;
  final UnitsProvider unitsProvider;

  const EventBox({
    required this.event,
    this.userStatus,
    this.dependentId,
    required this.eventTimeType,
    required this.unitsProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Logic for status box enablement
    final bool isStatusBoxEnabled =
        eventTimeType == EventTimeType.live &&
        (event.openSignUp == null || now.isAfter(event.openSignUp!));

    return GestureDetector(
      onTap: () {
        if (eventTimeType == EventTimeType.live || isUserLeader(context)) {
          // Navigate to event details screen
          context.router.push(
            EventDetailsRoute(
              event: event,
              eventTimeType: eventTimeType,
              unitsProvider: unitsProvider,
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.medium),
        decoration: ShapeDecoration(
          color: context.colors.background.light,
          shape: SmoothRectangleBorder(
            side: BorderSide(color: context.colors.background.medium, width: 1),
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.medium,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      event.title ?? '',
                      style: AppTextTheme.titleSmall(context),
                      maxLines: 1,
                    ),
                  ),
                ),
                if (userStatus != null && dependentId != null) ...[
                  SizedBox(width: AppSpacing.small),
                  UserStatusBox(
                    status: userStatus!,
                    isEnabled: isStatusBoxEnabled,
                    eventId: event.eventId,
                    dependentId: dependentId!,
                  ),
                ],
              ],
            ),
            SizedBox(height: AppSpacing.xSmall),
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
                      text: AppLocalizations.of(
                        context,
                      )!.event_box_photos_link_text,
                      style: AppTextTheme.labelMedium(context).copyWith(
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
                  if (event.targetPatrolsIds != null &&
                      event.targetPatrolsIds!.isNotEmpty) ...[
                    SizedBox(height: AppSpacing.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.event_box_target_patrols_text,
                          style: AppTextTheme.bodySmall(
                            context,
                          ).copyWith(color: context.colors.text.muted),
                        ),
                        Text(
                          unitsProvider.patrols
                              .where(
                                (patrol) => event.targetPatrolsIds!.contains(
                                  patrol.patrolId,
                                ),
                              )
                              .map((patrol) => patrol.name)
                              .join(', '),
                          style: AppTextTheme.bodySmall(
                            context,
                          ).copyWith(color: context.colors.text.normal),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
