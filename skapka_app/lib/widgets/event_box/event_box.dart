import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/widgets/event_box/user_status_box.dart';
import 'package:url_launcher/url_launcher.dart';

class EventBox extends StatelessWidget {
  final EventModel event;
  final UserStatus? userStatus;
  final String? dependentId;

  const EventBox({
    required this.event,
    this.userStatus,
    this.dependentId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Logic for sign up info and status box
    final bool showSignUpInfo =
        event.closeSignUp != null &&
        event.closeSignUp!.isAfter(now) &&
        (event.startDate != null && event.startDate!.isAfter(now));

    final bool isStatusBoxEnabled =
        showSignUpInfo &&
        (event.openSignUp == null || now.isAfter(event.openSignUp!));

    // Logic for date display
    final startDate = event.startDate;
    final endDate = event.endDate;
    final bool isSingleDay =
        startDate != null &&
        endDate != null &&
        startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day;

    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('d. M. yyyy');
    final timeFormat = DateFormat('HH:mm');
    final dateTimeFormat = DateFormat('d. M. yyyy HH:mm');

    return Container(
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
              Text(event.title ?? '', style: AppTextTheme.titleSmall(context)),
              Spacer(),
              if (userStatus != null && dependentId != null)
                UserStatusBox(
                  status: userStatus!,
                  isEnabled: isStatusBoxEnabled,
                  eventId: event.eventId,
                  dependentId: dependentId!,
                ),
            ],
          ),
          SizedBox(height: AppSpacing.xSmall),
          Column(
            spacing: AppSpacing.xxSmall,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (event.photoAlbumLink != null)
                GestureDetector(
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
                          '${AppLocalizations.of(context)!.event_box_photos_link_text}: ',
                      style: AppTextTheme.bodyMedium(context).copyWith(
                        color: context.colors.secondary.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
            ],
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
                if (showSignUpInfo && event.closeSignUp != null)
                  _buildInfoRow(
                    context,
                    l10n.event_box_sign_up_end_date_text,
                    dateTimeFormat.format(event.closeSignUp!),
                  ),
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
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextTheme.bodyMedium(
            context,
          ).copyWith(color: context.colors.text.muted),
        ),
        Text(
          value,
          style: AppTextTheme.bodyMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.text.normal,
          ),
        ),
      ],
    );
  }
}
