import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/leader_dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_instructions_container.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_title_form.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/forms/form_with_details.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/loading_floating_logo.dart';
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
  // Services and providers
  final SupabaseService _supabaseService = SupabaseService();
  late final AccountProvider _accountProvider = context.read<AccountProvider>();
  // Original event and edited event for change detection
  late final EventModel originalEvent;
  EventModel get editedEvent => EventModel(
    eventId: eventId ?? '',
    title: _eventTitleController.text,
    instructions: _instructions,
    openSignUp: _openSignUp,
    closeSignUp: _closeSignUp,
    startDate: _startDate,
    endDate: _endDate,
    meetingPlace: _meetingPlaceController.text,
    photoAlbumLink: _photoAlbumLinkController.text,
    groupId: groupId,
    targetPatrolsIds: targetPatrolsIds,
    lastEditedBy: lastEditedBy,
    isDraft: isDraft,
  );

  // Total group dependents, leaders, patrols, and troops
  late List<DependentModel> _groupDependents;
  late List<LeaderDependentModel> _groupDependentLeaders;
  late List<DependentModel> _groupDependentChildren;
  late List<TroopModel> _groupTroops;
  late List<PatrolModel> _groupPatrols;
  late List<EventParticipantModel> _eventParticipants;

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
  bool isDraft = true;

  /// Fetch all necessary data (dependents, patrols, troops, participants)
  Future<void> fetchAllData() async {
    await fetchAndDivideGroupDependents(_accountProvider.groupId);
    await fetchGroupPatrolsAndTroops(_accountProvider.groupId);
    if (widget.event != null) {
      await fetchEventParticipants(widget.event!.eventId);
    }
  }

  @override
  void initState() {
    super.initState();

    // Setting values from the original event to initialize edited event
    originalEvent =
        widget.event ??
        EventModel(
          eventId: '',
          title: '',
          instructions: null,
          openSignUp: null,
          closeSignUp: null,
          startDate: null,
          endDate: null,
          meetingPlace: '',
          photoAlbumLink: '',
          groupId: null,
          targetPatrolsIds: null,
          lastEditedBy: null,
          isDraft: true,
        );
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
    isDraft = widget.event?.isDraft ?? true;
  }

  /// Fetch and divide group dependents into leaders and children and store them locally
  Future<void> fetchAndDivideGroupDependents(String groupId) async {
    _groupDependents = await _supabaseService.getGroupDependents(groupId);
    List<LeaderModel> groupLeaders = await _supabaseService.getGroupLeaders(
      groupId,
    );

    _groupDependentLeaders = [];
    _groupDependentChildren = [];

    for (var dependent in _groupDependents) {
      if (dependent.isLeader) {
        final ledPatrols = groupLeaders
            .where((l) => l.dependentId == dependent.dependentId)
            .map((l) => l.patrolId)
            .toList();
        _groupDependentLeaders.add(
          LeaderDependentModel(
            dependent: dependent,
            leaderOfPatrolId: ledPatrols,
          ),
        );
      } else {
        _groupDependentChildren.add(dependent);
      }
    }
    print(
      'Fetched ${_groupDependents.length} dependents: '
      '${_groupDependentLeaders.length} leaders and '
      '${_groupDependentChildren.length} children for group $groupId.',
    );
  }

  ///Fetch group patrols and troops and store them locally
  Future<void> fetchGroupPatrolsAndTroops(String groupId) async {
    _groupPatrols = await _supabaseService.getGroupPatrols(groupId);
    _groupTroops = await _supabaseService.getGroupTroops(groupId);
    print(
      'Fetched ${_groupPatrols.length} patrols and ${_groupTroops.length} troops for group $groupId.',
    );
  }

  /// Fetch event participants and store them locally
  Future<void> fetchEventParticipants(String eventId) async {
    _eventParticipants = await _supabaseService.getEventParticipants(
      eventId,
      groupId!,
    );
    print(
      'Fetched ${_eventParticipants.length} participants for event $eventId.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: FutureBuilder(
        future: fetchAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ScreenWrapper(
              appBar: Appbar(
                showBackChevron: true,
                showSettingsIcon: false,
                screenName: widget.event == null
                    ? context
                          .localizations
                          .create_edit_event_screen_title_create
                    : context.localizations.create_edit_event_screen_title_edit,
              ),
              body: Center(child: const LoadingFloatingLogo()),
            );
          }
          return Builder(
            builder: (context) {
              final dialOpenNotifier = context.watch<ValueNotifier<bool>>();
              return ScreenWrapper(
                appBar: Appbar(
                  showBackChevron: true,
                  showSettingsIcon: false,
                  screenName: widget.event == null
                      ? context
                            .localizations
                            .create_edit_event_screen_title_create
                      : context
                            .localizations
                            .create_edit_event_screen_title_edit,
                  onBackPressed: () {
                    // print(
                    //   'Original eventId: ${originalEvent.eventId}; Edited eventId: ${editedEvent.eventId}',
                    // );
                    // print(
                    //   'Original eventTitle: ${originalEvent.title}; Edited eventTitle: ${editedEvent.title}',
                    // );
                    // print(
                    //   'Original eventInstructions: ${originalEvent.instructions}; Edited eventInstructions: ${editedEvent.instructions}',
                    // );
                    // print(
                    //   'Original eventOpenSignUp: ${originalEvent.openSignUp}; Edited eventOpenSignUp: ${editedEvent.openSignUp}',
                    // );
                    // print(
                    //   'Original eventCloseSignUp: ${originalEvent.closeSignUp}; Edited eventCloseSignUp: ${editedEvent.closeSignUp}',
                    // );
                    // print(
                    //   'Original eventStartDate: ${originalEvent.startDate}; Edited eventStartDate: ${editedEvent.startDate}',
                    // );
                    // print(
                    //   'Original eventEndDate: ${originalEvent.endDate}; Edited eventEndDate: ${editedEvent.endDate}',
                    // );
                    // print(
                    //   'Original eventMeetingPlace: ${originalEvent.meetingPlace}; Edited eventMeetingPlace: ${editedEvent.meetingPlace}',
                    // );
                    // print(
                    //   'Original eventPhotoAlbumLink: ${originalEvent.photoAlbumLink}; Edited eventPhotoAlbumLink: ${editedEvent.photoAlbumLink}',
                    // );
                    // print(
                    //   'Original groupId: ${originalEvent.groupId}; Edited groupId: ${editedEvent.groupId}',
                    // );
                    // print(
                    //   'Original targetPatrolsIds: ${originalEvent.targetPatrolsIds}; Edited targetPatrolsIds: ${editedEvent.targetPatrolsIds}',
                    // );
                    // print(
                    //   'Original lastEditedBy: ${originalEvent.lastEditedBy}; Edited lastEditedBy: ${editedEvent.lastEditedBy}',
                    // );
                    // print(
                    //   'Original eventIsDraft: ${originalEvent.isDraft}; Edited eventIsDraft: ${editedEvent.isDraft}',
                    // );

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
                            onSecondaryPressed: () =>
                                Navigator.of(context).pop(),
                            onPrimaryPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              Navigator.of(context).pop(); // Go back
                            },
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      spacing: AppSpacing.large,
                      children: [
                        EventTitleForm(
                          eventTitleController: _eventTitleController,
                        ),
                        EventDateSelector(
                          openSignUp: _openSignUp,
                          closeSignUp: _closeSignUp,
                          startDate: _startDate,
                          endDate: _endDate,
                          onOpenSignUpChanged: (d) =>
                              setState(() => _openSignUp = d),
                          onCloseSignUpChanged: (d) =>
                              setState(() => _closeSignUp = d),
                          onStartDateChanged: (d) =>
                              setState(() => _startDate = d),
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
          );
        },
      ),
    );
  }
}
