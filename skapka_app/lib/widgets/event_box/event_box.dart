import 'package:auto_route/auto_route.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/event_box/user_status_box.dart';
import 'package:url_launcher/url_launcher.dart';

class EventBox extends StatelessWidget {
  final EventModel event;
  final UserStatus? userStatus;
  final String? dependentId;
  final EventTimeType eventTimeType;

  const EventBox({
    required this.event,
    this.userStatus,
    this.dependentId,
    required this.eventTimeType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AccountProvider accountProvider = context.read<AccountProvider>();

    final now = DateTime.now();

    // Logic for date display
    final startDate = event.startDate;
    final endDate = event.endDate;
    final bool isSingleDay =
        startDate != null &&
        endDate != null &&
        startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day;

    // Determine event state

    // Logic for status box enablement
    final bool isStatusBoxEnabled =
        eventTimeType == EventTimeType.live &&
        (event.openSignUp == null || now.isAfter(event.openSignUp!));

    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('d. M. yyyy');
    final timeFormat = DateFormat('HH:mm');
    final dateTimeFormat = DateFormat('d. M. yyyy HH:mm');

    return GestureDetector(
      onTap: () {
        if (eventTimeType == EventTimeType.live || isUserLeader(context)) {
          // Navigate to event details screen
          context.router.push(
            EventDetailsRoute(event: event, eventTimeType: eventTimeType),
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
                spacing: AppSpacing.xSmall,
                children: [
                  if (eventTimeType == EventTimeType.draft) ...[
                    if (event.openSignUp != null)
                      _buildInfoRow(
                        context,
                        l10n.event_box_sign_up_start_date_text,
                        dateTimeFormat.format(event.openSignUp!),
                      ),
                    if (event.closeSignUp != null)
                      _buildInfoRow(
                        context,
                        l10n.event_box_sign_up_end_date_text,
                        dateTimeFormat.format(event.closeSignUp!),
                      ),
                  ] else if (eventTimeType == EventTimeType.live) ...[
                    if (event.closeSignUp != null)
                      _buildInfoRow(
                        context,
                        l10n.event_box_sign_up_end_date_text,
                        dateTimeFormat.format(event.closeSignUp!),
                      ),
                  ] else if (eventTimeType == EventTimeType.future) ...[
                    if (event.openSignUp != null)
                      _buildInfoRow(
                        context,
                        l10n.event_box_sign_up_start_date_text,
                        dateTimeFormat.format(event.openSignUp!),
                      ),
                  ],
                  if (startDate != null && endDate != null)
                    if (isSingleDay)
                      _buildInfoRow(
                        context,
                        l10n.event_box_event_single_day_text,
                        '${dateFormat.format(startDate)} ${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}',
                      )
                    else ...[
                      _buildInfoRow(
                        context,
                        l10n.event_box_event_multiple_days_start_text,
                        dateTimeFormat.format(startDate),
                      ),
                      _buildInfoRow(
                        context,
                        l10n.event_box_event_multiple_days_end_text,
                        dateTimeFormat.format(endDate),
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

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextTheme.labelMedium(
            context,
          ).copyWith(color: context.colors.text.muted),
        ),
        Text(
          value,
          style: AppTextTheme.labelMedium(
            context,
          ).copyWith(color: context.colors.text.normal),
        ),
      ],
    );
  }
}
