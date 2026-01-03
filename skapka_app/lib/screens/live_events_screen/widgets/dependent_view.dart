import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/widgets/event_box/event_box.dart';
import 'package:skapka_app/widgets/something_is_missing_widget.dart';

class DependentView extends StatelessWidget {
  final String dependentName;
  final List<EventModel> dependentsLiveEvents;
  final UnitsProvider unitsProvider;
  final String dependentId;
  final List<EventParticipantModel> usersParticipation;
  const DependentView({
    required this.dependentName,
    required this.dependentsLiveEvents,
    required this.unitsProvider,
    required this.dependentId,
    required this.usersParticipation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dependentName,
          style: AppTextTheme.titleMedium(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.medium),
        dependentsLiveEvents.isEmpty
            ? Column(
                children: [
                  SomethingIsMissingWidget(
                    subtitle: context.localizations
                        .live_events_screen_no_live_events_view_subtitle(
                          dependentName,
                        ),
                  ),
                ],
              )
            : Column(
                spacing: AppSpacing.xSmall,
                children: [
                  for (var event in dependentsLiveEvents)
                    EventBox(
                      event: event,
                      eventTimeType: EventTimeType.live,
                      unitsProvider: unitsProvider,
                      dependentId: dependentId,
                      userStatus: usersParticipation
                          .firstWhere((p) => p.eventId == event.eventId)
                          .status,
                    ),
                ],
              ),
      ],
    );
  }
}
