import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/live_events_screen/widgets/dependent_view.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/something_is_missing_widget.dart';

@RoutePage()
class LiveEventsScreen extends StatelessWidget {
  const LiveEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DependentsProvider dependentsProvider = context.read<DependentsProvider>();
    EventsProvider eventsProvider = context.read<EventsProvider>();
    SupabaseService supabaseService = SupabaseService();

    return RefreshIndicator(
      color: context.colors.background.light,
      backgroundColor: context.colors.primary.light,
      onRefresh: () async {
        await Future.wait(
          dependentsProvider.dependents.map((dependent) async {
            final participation = await supabaseService
                .getDependentParticipation(dependent.dependentId);
            dependentsProvider.setParticipation(
              dependent.dependentId,
              participation,
            );
          }),
        );
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Consumer<DependentsProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  provider.dependents.isEmpty
                      ? Column(
                          children: [
                            SomethingIsMissingWidget(
                              subtitle: context
                                  .localizations
                                  .live_events_screen_no_dependents_view_subtitle,
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.bottomSpace + AppSpacing.large,
                          ),
                          child: Column(
                            spacing: AppSpacing.xLarge,
                            children: [
                              for (var dependent in provider.dependents.where(
                                (d) => d.dependentDetails?.isArchived != true,
                              ))
                                Builder(
                                  builder: (context) {
                                    final participation = provider
                                        .getParticipationForDependent(
                                          dependent.dependentId,
                                        );
                                    final liveEvents =
                                        eventsProvider.liveEvents;

                                    final dependentsLiveEvents = liveEvents
                                        .where((event) {
                                          return participation.any(
                                            (p) => p.eventId == event.eventId,
                                          );
                                        })
                                        .toList();

                                    final filteredParticipation = participation
                                        .where(
                                          (p) => dependentsLiveEvents.any(
                                            (e) => e.eventId == p.eventId,
                                          ),
                                        )
                                        .toList();

                                    return DependentView(
                                      dependentModel: dependent,
                                      dependentsLiveEvents:
                                          dependentsLiveEvents,
                                      unitsProvider: context
                                          .read<UnitsProvider>(),
                                      usersParticipation: filteredParticipation,
                                    );
                                  },
                                ),
                            ],
                          ),
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
