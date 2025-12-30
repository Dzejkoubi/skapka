import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountProvider accountProvider = context.read<AccountProvider>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Consumer<EventsProvider>(
          builder: (context, provider, child) {
            return Column(
              spacing: AppSpacing.large,
              children: [
                EventsExpansionTile(
                  type: EventsExpansionTileType.future,
                  events: provider.futureEvents,
                ),
                EventsExpansionTile(
                  type: EventsExpansionTileType.live,
                  events: provider.liveEvents,
                ),
                EventsExpansionTile(
                  type: EventsExpansionTileType.past,
                  events: provider.pastEvents,
                ),
                if (accountProvider.rights >= 2)
                  EventsExpansionTile(
                    type: EventsExpansionTileType.draft,
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
