import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/live_events_screen/widgets/dependent_view.dart';
import 'package:skapka_app/widgets/something_is_missing_widget.dart';

@RoutePage()
class LiveEventsScreen extends StatelessWidget {
  const LiveEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DependentsProvider dependentsProvider = context.read<DependentsProvider>();
    EventsProvider eventsProvider = context.read<EventsProvider>();

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            dependentsProvider.dependents.isEmpty
                ? SomethingIsMissingWidget(
                    subtitle: context
                        .localizations
                        .live_events_screen_no_dependents_view_subtitle,
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSpacing.bottomSpace + AppSpacing.large,
                    ),
                    child: Column(
                      spacing: AppSpacing.xLarge,
                      children: [
                        for (var dependent in dependentsProvider.dependents)
                          Builder(
                            builder: (context) {
                              final participation = dependentsProvider
                                  .getParticipationForDependent(
                                    dependent.dependentId,
                                  );
                              final liveEvents = eventsProvider.liveEvents;

                              final dependentsLiveEvents = liveEvents.where((
                                event,
                              ) {
                                return participation.any(
                                  (p) => p.eventId == event.eventId,
                                );
                              }).toList();

                              final filteredParticipation = participation
                                  .where(
                                    (p) => dependentsLiveEvents.any(
                                      (e) => e.eventId == p.eventId,
                                    ),
                                  )
                                  .toList();

                              return DependentView(
                                dependentName:
                                    '${dependent.dependentDetails?.name ?? ''} ${dependent.dependentDetails?.surname ?? ''}',
                                dependentsLiveEvents: dependentsLiveEvents,
                                unitsProvider: context.read<UnitsProvider>(),
                                dependentId: dependent.dependentId,
                                usersParticipation: filteredParticipation,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
