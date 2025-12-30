import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class CreateEditEventParticipantsScreen extends StatelessWidget {
  final List<DependentModel>? getGroupDependents;
  final List<EventParticipantModel>? eventParticipants;

  const CreateEditEventParticipantsScreen({
    super.key,
    this.getGroupDependents,
    this.eventParticipants,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_participants_screen_title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(children: [Text('ljflkdsjlfkds')])),
      ),
    );
  }
}
