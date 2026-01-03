import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/utils/is_user_leader.dart';

class EventTimeInfo extends StatelessWidget {
  final EventModel event;
  final EventTimeType eventTimeType;
  final bool fullInfo;

  const EventTimeInfo({
    required this.event,
    required this.eventTimeType,
    this.fullInfo = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d. M. yyyy');
    final timeFormat = DateFormat('HH:mm');
    final dateTimeFormat = DateFormat('d. M. yyyy HH:mm');

    final startDate = event.startDate;
    final endDate = event.endDate;
    final bool isSingleDay =
        startDate != null &&
        endDate != null &&
        startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day;

    return Column(
      spacing: AppSpacing.xSmall,
      children: [
        if (fullInfo) ...[
          if (isUserLeader(context) && event.openSignUp != null)
            buildRow(
              context,
              context.localizations.event_box_sign_up_start_date_text,
              dateTimeFormat.format(event.openSignUp!),
            ),
          if (event.closeSignUp != null)
            buildRow(
              context,
              context.localizations.event_box_sign_up_end_date_text,
              dateTimeFormat.format(event.closeSignUp!),
            ),
        ] else ...[
          if (eventTimeType == EventTimeType.draft) ...[
            if (event.openSignUp != null)
              buildRow(
                context,
                context.localizations.event_box_sign_up_start_date_text,
                dateTimeFormat.format(event.openSignUp!),
              ),
            if (event.closeSignUp != null)
              buildRow(
                context,
                context.localizations.event_box_sign_up_end_date_text,
                dateTimeFormat.format(event.closeSignUp!),
              ),
          ] else if (eventTimeType == EventTimeType.live) ...[
            if (event.closeSignUp != null)
              buildRow(
                context,
                context.localizations.event_box_sign_up_end_date_text,
                dateTimeFormat.format(event.closeSignUp!),
              ),
          ] else if (eventTimeType == EventTimeType.future) ...[
            if (event.openSignUp != null)
              buildRow(
                context,
                context.localizations.event_box_sign_up_start_date_text,
                dateTimeFormat.format(event.openSignUp!),
              ),
          ],
        ],
        if (startDate != null && endDate != null)
          if (isSingleDay)
            buildRow(
              context,
              context.localizations.event_box_event_single_day_text,
              '${dateFormat.format(startDate)} ${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}',
            )
          else ...[
            buildRow(
              context,
              context.localizations.event_box_event_multiple_days_start_text,
              dateTimeFormat.format(startDate),
            ),
            buildRow(
              context,
              context.localizations.event_box_event_multiple_days_end_text,
              dateTimeFormat.format(endDate),
            ),
          ],
      ],
    );
  }

  Widget buildRow(BuildContext context, String label, String value) {
    final style = AppTextTheme.labelLarge(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style.copyWith(color: context.colors.text.muted)),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              value,
              style: style.copyWith(color: context.colors.text.normal),
            ),
          ),
        ),
      ],
    );
  }
}
