import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/widgets/event_box/event_box.dart';
import 'package:skapka_app/widgets/something_is_missing_widget.dart';

class DependentView extends StatelessWidget {
  final AccountDependentModel dependentModel;
  final List<EventModel> dependentsLiveEvents;
  final UnitsProvider unitsProvider;
  final List<EventParticipantModel> usersParticipation;
  const DependentView({
    required this.dependentModel,
    required this.dependentsLiveEvents,
    required this.unitsProvider,
    required this.usersParticipation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${dependentModel.name} ${dependentModel.surname}',
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
                          dependentModel.name,
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
                      dependent: dependentModel,
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
