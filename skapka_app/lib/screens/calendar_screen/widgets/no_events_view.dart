import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';

class NoEventsView extends StatelessWidget {
  const NoEventsView({super.key, required this.widget});

  final EventsExpansionTile widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.medium,
        horizontal: AppSpacing.small,
      ),
      child: Column(
        children: [
          Text(
            context
                .localizations
                .calendar_screen_event_expansion_tile_no_events_title,
            style: AppTextTheme.titleMedium(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.small),
          Text(
            switch (widget.type) {
              EventTimeType.future =>
                context
                    .localizations
                    .calendar_screen_event_expansion_tile_future_no_events_subtitle,
              EventTimeType.live =>
                context
                    .localizations
                    .calendar_screen_event_expansion_tile_live_no_events_subtitle,
              EventTimeType.past =>
                context
                    .localizations
                    .calendar_screen_event_expansion_tile_past_no_events_subtitle,
              EventTimeType.draft =>
                context
                    .localizations
                    .calendar_screen_event_expansion_tile_draft_no_events_subtitle,
            },
            style: AppTextTheme.bodyMedium(
              context,
            ).copyWith(color: context.colors.text.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
