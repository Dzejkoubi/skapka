import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/no_events_view.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/event_box/event_box.dart';

class EventsExpansionTile extends StatefulWidget {
  final EventTimeType type;
  final List<EventModel> events;
  final VoidCallback? onLoadMore;

  const EventsExpansionTile({
    required this.type,
    required this.events,
    this.onLoadMore,
    super.key,
  });

  @override
  State<EventsExpansionTile> createState() => _EventsExpansionTileState();
}

class _EventsExpansionTileState extends State<EventsExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context);
    final border = SmoothRectangleBorder(
      side: BorderSide(color: config.borderColor, width: 1.5),
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.medium,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          // If new state opened
          if (value == true && !_isExpanded) {
            Gaimon.soft();
          }
          // If new state closed
          else if (value == false && _isExpanded) {
            Gaimon.rigid();
          }
          setState(() {
            _isExpanded = value;
          });
        },
        title: Text(
          '${config.title} (${widget.events.length})',
          style: AppTextTheme.titleSmall(context),
        ),
        backgroundColor: config.backgroundColor,
        collapsedBackgroundColor: config.backgroundColor,
        shape: border,
        collapsedShape: border,
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: SvgPicture.asset(
            'assets/icons/chevron-up.svg',
            colorFilter: ColorFilter.mode(
              context.colors.text.normal,
              BlendMode.srcIn,
            ),
            width: AppSizes.iconSizeSmall,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.small,
        ),
        children: [
          if (widget.events.isEmpty)
            NoEventsView(widget: widget)
          else ...[
            for (final event in widget.events)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.small),
                child: EventBox(
                  event: event,
                  eventTimeType: widget.type,
                  unitsProvider: context.read<UnitsProvider>(),
                ),
              ),
            if (widget.onLoadMore != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.small),
                child: MainButton(
                  style: ButtonStyleTypes.outlined,
                  variant: ButtonStylesVariants.normal,
                  text: AppLocalizations.of(context)!.load_more,
                  onPressed: widget.onLoadMore,
                  expandToFillWidth: true,
                ),
              ),
          ],
        ],
      ),
    );
  }

  _EventsExpansionTileConfig _getConfig(BuildContext context) {
    switch (widget.type) {
      case EventTimeType.future:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.secondary.light,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_future_title,
        );
      case EventTimeType.live:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.accent.normal,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_live_title,
        );
      case EventTimeType.past:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.error.light,
          backgroundColor: context.colors.background.light,
          title: AppLocalizations.of(
            context,
          )!.calendar_screen_event_expansion_tile_past_title,
        );
      case EventTimeType.draft:
        return _EventsExpansionTileConfig(
          borderColor: context.colors.background.medium,
          backgroundColor: context.colors.background.light,
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
