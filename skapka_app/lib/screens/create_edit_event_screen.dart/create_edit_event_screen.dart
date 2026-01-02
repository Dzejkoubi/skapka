import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_instructions_container.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_title_form.dart';
import 'package:skapka_app/widgets/forms/form_with_details.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_date_selector.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/create_edit_event_speed_dial.dart';

@RoutePage()
class CreateEditEventScreen extends StatefulWidget {
  final EventModel? event;
  final EventTimeType? eventTimeType;
  final List<EventParticipantModel>? eventParticipants;
  const CreateEditEventScreen({
    super.key,
    this.event,
    this.eventTimeType,
    this.eventParticipants,
  });

  @override
  State<CreateEditEventScreen> createState() => _CreateEditEventScreenState();
}

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  // Original event and edited event for change detection
  late final EventModel? originalEvent;
  late EventModel? editedEvent = EventModel(
    eventId: eventId ?? '',
    title: _eventTitleController.text,
    instructions: _instructions ?? '',
    openSignUp: _openSignUp,
    closeSignUp: _closeSignUp,
    startDate: _startDate,
    endDate: _endDate,
    meetingPlace: _meetingPlaceController.text,
    photoAlbumLink: _photoAlbumLinkController.text,
    groupId: groupId ?? '',
    targetPatrolsIds: targetPatrolsIds ?? [],
    lastEditedBy: lastEditedBy ?? '',
    isDraft: isDraft,
  );

  // Creating local variables to hold form data
  late String? eventId;
  final TextEditingController _eventTitleController = TextEditingController();
  late String? _instructions;
  late DateTime? _openSignUp;
  late DateTime? _closeSignUp;
  late DateTime? _startDate;
  late DateTime? _endDate;
  final TextEditingController _meetingPlaceController = TextEditingController();
  final TextEditingController _photoAlbumLinkController =
      TextEditingController();
  String? groupId;
  List<String>? targetPatrolsIds;
  String? lastEditedBy;
  bool isDraft = false;

  @override
  void initState() {
    super.initState();
    // Setting values from the original event to initialize edited event
    originalEvent = widget.event;
    eventId = widget.event?.eventId;
    _eventTitleController.text = widget.event?.title ?? '';
    _instructions = widget.event?.instructions;
    _openSignUp = widget.event?.openSignUp;
    _closeSignUp = widget.event?.closeSignUp;
    _startDate = widget.event?.startDate;
    _endDate = widget.event?.endDate;
    _meetingPlaceController.text = widget.event?.meetingPlace ?? '';
    _photoAlbumLinkController.text = widget.event?.photoAlbumLink ?? '';
    groupId = widget.event?.groupId;
    targetPatrolsIds = widget.event?.targetPatrolsIds;
    lastEditedBy = widget.event?.lastEditedBy;
    isDraft = widget.event?.isDraft ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Builder(
        builder: (context) {
          final dialOpenNotifier = context.watch<ValueNotifier<bool>>();
          return ScreenWrapper(
            appBar: Appbar(
              showBackChevron: true,
              showSettingsIcon: false,
              screenName: widget.event == null
                  ? context.localizations.create_edit_event_screen_title_create
                  : context.localizations.create_edit_event_screen_title_edit,
              onBackPressed: () {
                if (originalEvent != editedEvent) {
                  // Show confirmation dialog before leaving
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return LargeDialog(
                        type: LargeDialogType.negative,
                        title: context
                            .localizations
                            .create_edit_event_screen_go_back_without_saving_dialog_title,
                        description: context
                            .localizations
                            .create_edit_event_screen_go_back_without_saving_dialog_description,
                        primaryButtonText: context
                            .localizations
                            .create_edit_event_screen_go_back_without_saving_dialog_primary_button_text,
                        secondaryButtonText: context.localizations.cancel,
                        onSecondaryPressed: () => Navigator.of(context).pop(),
                        onPrimaryPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Go back
                        },
                      );
                    },
                  );
                }
              },
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  spacing: AppSpacing.large,
                  children: [
                    EventTitleForm(eventTitleController: _eventTitleController),
                    EventDateSelector(
                      openSignUp: _openSignUp,
                      closeSignUp: _closeSignUp,
                      startDate: _startDate,
                      endDate: _endDate,
                      onOpenSignUpChanged: (d) =>
                          setState(() => _openSignUp = d),
                      onCloseSignUpChanged: (d) =>
                          setState(() => _closeSignUp = d),
                      onStartDateChanged: (d) => setState(() => _startDate = d),
                      onEndDateChanged: (d) => setState(() => _endDate = d),
                    ),
                    EventInstructionsContainer(),
                    FormWithDetails(
                      textController: _meetingPlaceController,
                      labelText: context
                          .localizations
                          .create_edit_event_screen_meeting_place_text,
                      descriptionText: context
                          .localizations
                          .create_edit_event_screen_meeting_place_description,
                    ),
                    FormWithDetails(
                      textController: _photoAlbumLinkController,
                      labelText: context
                          .localizations
                          .create_edit_event_screen_photo_album_link_text,
                      descriptionText: context
                          .localizations
                          .create_edit_event_screen_photo_album_link_description,
                    ),
                    SizedBox(height: AppSpacing.bottomSpace),
                  ],
                ),
              ),
            ),

            speedDialChildren: CreateEditEventSpeedDial.build(
              context: context,
              dialOpenNotifier: dialOpenNotifier,
              event: widget.event,
              eventTimeType: widget.eventTimeType,
              onDelete: () {
                if (kDebugMode) print('User confirmed delete event');
              },
              onPublish: () {
                if (kDebugMode) print('User confirmed publish event');
              },
              onUnpublish: () {
                if (kDebugMode) print('User confirmed unpublish event');
              },
              onSave: ({required bool asDraft}) {
                if (kDebugMode) {
                  print('User confirmed save event (asDraft: $asDraft)');
                }
              },
            ),
            fabKey: dialOpenNotifier.hashCode,
            openCloseDial: dialOpenNotifier,
          );
        },
      ),
    );
  }
}
