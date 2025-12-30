import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';
import 'package:skapka_app/utils/is_user_leader.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Consumer<EventsProvider>(
          builder: (context, provider, child) {
            return Column(
              spacing: AppSpacing.large,
              children: [
                EventsExpansionTile(
                  type: EventTimeType.future,
                  events: provider.futureEvents,
                ),
                EventsExpansionTile(
                  type: EventTimeType.live,
                  events: provider.liveEvents,
                ),
                EventsExpansionTile(
                  type: EventTimeType.past,
                  events: provider.pastEvents,
                ),
                if (isUserLeader(context))
                  EventsExpansionTile(
                    type: EventTimeType.draft,
                    events: provider.draftEvents,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
