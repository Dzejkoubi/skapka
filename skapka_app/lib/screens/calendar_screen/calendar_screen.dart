import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

@RoutePage()
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: context.colors.background.light,
      backgroundColor: context.colors.primary.light,
      onRefresh: () async {
        final accountProvider = context.read<AccountProvider>();
        final groupId = accountProvider.groupId;

        final events = await SupabaseService().getGroupEvents(groupId: groupId);

        if (context.mounted) {
          context.read<EventsProvider>().setEvents(events);
        }
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                    onLoadMore: provider.hasMorePastEvents
                        ? () async {
                            try {
                              final accountProvider = context
                                  .read<AccountProvider>();
                              final groupId = accountProvider.groupId;

                              // Find oldest event date
                              DateTime oldestDate;
                              if (provider.pastEvents.isNotEmpty) {
                                oldestDate = provider.pastEvents
                                    .map((e) => e.endDate!)
                                    .reduce((a, b) => a.isBefore(b) ? a : b);
                              } else {
                                // Fallback to school year start
                                final now = DateTime.now();
                                final startYear = now.month < 9
                                    ? now.year - 1
                                    : now.year;
                                oldestDate = DateTime(startYear, 9, 1);
                              }

                              final newEvents = await SupabaseService()
                                  .getOlderGroupEvents(
                                    groupId: groupId,
                                    date: oldestDate,
                                  );

                              if (context.mounted) {
                                final eventsProvider = context
                                    .read<EventsProvider>();
                                eventsProvider.addEvents(newEvents);
                                if (newEvents.length < 10) {
                                  eventsProvider.setHasMorePastEvents(false);
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                BottomDialog.show(
                                  context,
                                  type: BottomDialogType.negative,
                                  description:
                                      context.localizations.generic_error,
                                );
                              }
                            }
                          }
                        : null,
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
      ),
    );
  }
}
