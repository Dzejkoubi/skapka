import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final EventTimeType eventTimeType;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.eventTimeType,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: event.title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(children: [Row(children: [
                    ],
                  )]),
            ),
          ],
        ),
      ),
    );
  }
}
