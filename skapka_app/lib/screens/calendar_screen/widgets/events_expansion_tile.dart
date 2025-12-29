import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/models/event_model.dart';

enum EventsExpansionTileType { future, live, past, draft }

class EventsExpansionTile extends StatelessWidget {
  final EventsExpansionTileType type;
  final List<EventModel> events;

  const EventsExpansionTile({
    required this.type,
    required this.events,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context);
    return ExpansionTile(
      title: Text(config.title),
      backgroundColor: config.backgroundColor,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: config.borderColor),
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppRadius.medium,
          cornerSmoothing: AppRadius.smoothNormal,
        ),
      ),
      children: [],
    );
  }

  _EventsExpansionTileConfig _getConfig(BuildContext context) {
    switch (type) {
      case EventsExpansionTileType.future:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.secondary.light,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_future_title,
        );
      case EventsExpansionTileType.live:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.accent.normal,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_live_title,
        );
      case EventsExpansionTileType.past:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.error.light,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_past_title,
        );
      case EventsExpansionTileType.draft:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.background.light,
          backgroundColor: context.colors.background.medium,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_draft_title,
        );
    }
  }
}

class _EventsExpansionTileConfig {
  final Color borderColor;
  final Color backgroundColor;
  final String title;
  _EventsExpansionTileConfig({
    required this.borderColor,
    required this.backgroundColor,
    required this.title,
  });
}
