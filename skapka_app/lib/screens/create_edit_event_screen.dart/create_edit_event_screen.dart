import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/events_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/utils/event_utils.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_instructions_container.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_participants_container.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_title_form.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/forms/form_with_details.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_floating_logo.dart';
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

enum _ProcessingType { none, creating, editing, deleting }

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  // Services and providers
  final SupabaseService _supabaseService = SupabaseService();
  late final AccountProvider _accountProvider = context.read<AccountProvider>();
  late final UnitsProvider _unitsProvider = context.read<UnitsProvider>();
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
    groupId: _accountProvider.groupId,
    targetPatrolsIds: targetPatrolIds,
    lastEditedBy: lastEditedBy,
    isDraft: isDraft,
  );

  // Total group dependents, leaders, patrols, and troops
  late List<DependentModel> _groupDependents;
  late List<TroopModel> _groupTroops;
  late List<PatrolModel> _groupPatrols;
  late List<LeaderModel> _groupLeaders;

  // Event participants
  late List<EventParticipantModel> _originalEventParticipants;
  late List<EventParticipantModel> _editedEventParticipants;

  // Participant statistics getters
  int get originalParticipantsCount => _originalEventParticipants.length;
  int get totalParticipantsCount => _editedEventParticipants.length;
  int get totalSignedUpParticipantsCount => _editedEventParticipants
      .where((p) => p.status == EventParticipantStatus.signedUp)
      .length;
  int get totalSignedUpLeadersCount => _editedEventParticipants
      .where((p) => p.status == EventParticipantStatus.signedUp)
      .where(
        (p) => _groupDependents.any(
          (l) => l.isLeader && l.dependentId == p.dependentId,
        ),
      )
      .length;
  int get totalInvitedLeadersCount => _editedEventParticipants
      .where(
        (p) => _groupDependents.any(
          (l) => l.isLeader && l.dependentId == p.dependentId,
        ),
      )
      .length;
  int get total18PlusSignedUpLeadersCount =>
      _editedEventParticipants.where((p) {
        if (p.status != EventParticipantStatus.signedUp) return false;
        final dependent = _groupDependents.cast<DependentModel?>().firstWhere(
          (d) => d?.dependentId == p.dependentId,
          orElse: () => null,
        );
        return dependent != null && dependent.isLeader && dependent.is18plus;
      }).length;

  int get total18PlusInvitedLeadersCount => _editedEventParticipants.where((p) {
    final dependent = _groupDependents.cast<DependentModel?>().firstWhere(
      (d) => d?.dependentId == p.dependentId,
      orElse: () => null,
    );
    return dependent != null && dependent.isLeader && dependent.is18plus;
  }).length;

  List<String> get targetPatrolIds {
    final participantDependentIds = _editedEventParticipants
        .map((p) => p.dependentId)
        .toSet();

    return _groupDependents
        .where((d) => participantDependentIds.contains(d.dependentId))
        .map((d) => d.patrolId)
        .whereType<String>()
        .toSet()
        .toList();
  }

  String get targetPatrolNames {
    final patrolIds = targetPatrolIds;
    debugPrint('Found patrol IDs for signed up dependents: $patrolIds');

    final names = _groupPatrols
        .where((p) => patrolIds.contains(p.patrolId))
        .map((p) => p.name)
        .toList();

    return names.isEmpty ? '-' : names.join(', ');
  }

  // Creating local variables to hold new event data -
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
  String? lastEditedBy;
  bool isDraft = true;

  _ProcessingType _processingType = _ProcessingType.none;
  bool get _isProcessing => _processingType != _ProcessingType.none;

  void _setProcessingType(_ProcessingType type) {
    setState(() {
      _processingType = type;
    });

    if (type != _ProcessingType.none) {
      context.read<LoadingProvider>().show(text: _getProcessingText(context));
    } else {
      context.read<LoadingProvider>().hide();
    }
  }

  // Tracks if data loading is complete
  bool _isInitialized = false;
  // Future for initial data fetching
  late Future<void> _initializationFuture;

  /// Fetch all necessary data (dependents, patrols, troops, participants)
  Future<void> fetchRequiredData() async {
    _groupPatrols = _unitsProvider.patrols;
    _groupTroops = _unitsProvider.troops;

    await fetchGroupDependentsAndLeaders(_accountProvider.groupId);
    if (widget.event != null) {
      await fetchEventParticipants(widget.event!.eventId);
    } else {
      _originalEventParticipants = [];
      _editedEventParticipants = [];
    }
    _isInitialized = true;
  }

  @override
  void initState() {
    super.initState();
    _initializationFuture = fetchRequiredData();

    // Setting values from the original event to initialize edited event
    originalEvent = widget.event ?? EventModel.empty();
    eventId = widget.event?.eventId;
    _eventTitleController.text = widget.event?.title ?? '';
    _instructions = widget.event?.instructions;
    _openSignUp = widget.event?.openSignUp;
    _closeSignUp = widget.event?.closeSignUp;
    _startDate = widget.event?.startDate;
    _endDate = widget.event?.endDate;
    _meetingPlaceController.text = widget.event?.meetingPlace ?? '';
    _photoAlbumLinkController.text = widget.event?.photoAlbumLink ?? '';
    lastEditedBy = widget.event?.lastEditedBy;
    isDraft = widget.event?.isDraft ?? true;
  }

  /// Fetch and divide group dependents into leaders, children, and 18+ dependents and store them locally
  Future<void> fetchGroupDependentsAndLeaders(String groupId) async {
    _groupDependents = await _supabaseService.getGroupDependents(
      groupId,
      excludeArchived:
          !(widget.eventTimeType ==
              EventTimeType.past), // If event is past, inlcude archived
    );
    _groupLeaders = await _supabaseService.getGroupLeaders(groupId);
  }

  /// Fetch event participants and store them locally
  Future<void> fetchEventParticipants(String eventId) async {
    _originalEventParticipants = await _supabaseService.getEventParticipants(
      eventId,
      _accountProvider.groupId,
    );
    _editedEventParticipants = List.from(_originalEventParticipants);

    debugPrint(
      'Fetched ${_originalEventParticipants.length} participants for event $eventId.',
    );
  }

  List<EventParticipantModel> get deleteParticipants =>
      _originalEventParticipants
          .where(
            (original) => !_editedEventParticipants.any(
              (edited) => edited.dependentId == original.dependentId,
            ),
          )
          .toList();

  List<EventParticipantModel> get addParticipants => _editedEventParticipants
      .where(
        (edited) => !_originalEventParticipants.any(
          (original) => original.dependentId == edited.dependentId,
        ),
      )
      .toList();

  String? _validateEvent() {
    if (_eventTitleController.text.trim().isEmpty) {
      return context
          .localizations
          .create_edit_event_screen_validation_error_title_empty;
    }
    if (_openSignUp == null ||
        _closeSignUp == null ||
        _startDate == null ||
        _endDate == null) {
      return context
          .localizations
          .create_edit_event_screen_validation_error_dates_empty;
    }
    if (_openSignUp!.isAfter(_closeSignUp!)) {
      return context
          .localizations
          .create_edit_event_screen_validation_error_signup_start_after_end;
    }
    if (_closeSignUp!.isAfter(_startDate!)) {
      return context
          .localizations
          .create_edit_event_screen_validation_error_signup_end_after_start;
    }
    if (_startDate!.isAfter(_endDate!)) {
      return context
          .localizations
          .create_edit_event_screen_validation_error_start_after_end;
    }
    return null;
  }

  // Creating new event
  Future<void> _createNewEvent({required bool asDraft}) async {
    setState(() {
      _setProcessingType(_ProcessingType.creating);
    });
    try {
      final newEvent = editedEvent.copyWith(isDraft: asDraft);
      final createdEvent = await _supabaseService.createEvent(
        newEvent,
        _accountProvider,
      );

      // Update local eventId
      String eventId = createdEvent.eventId;
      debugPrint('New event created with ID: $eventId');

      // Save participants
      for (final participant in _editedEventParticipants) {
        final p = participant.copyWith(
          eventId: eventId,
          groupId: _accountProvider.groupId,
        );
        await _supabaseService.addEventParticipant(p);
      }

      // Sync original participants
      _originalEventParticipants = List.from(_editedEventParticipants);
      debugPrint(
        'Event ${createdEvent.eventId} created successfully as ${asDraft ? 'draft' : 'published'}.',
      );
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description:
              context.localizations.create_edit_event_screen_save_success,
        );

        await _loadEventsAfterSuccess(event: createdEvent);
      }
    } catch (e) {
      debugPrint('Error creating event: $e');
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description:
              context.localizations.create_edit_event_screen_save_error_generic,
        );
      }
    } finally {
      if (mounted) {
        _setProcessingType(_ProcessingType.none);
      }
    }
  }

  // Saving edited event
  Future<void> _saveEditedEvent({required bool asDraft}) async {
    _setProcessingType(_ProcessingType.editing);
    try {
      final updatedEvent = editedEvent.copyWith(isDraft: asDraft);
      await _supabaseService.editEventDetails(updatedEvent, _accountProvider);

      // Handle participants changes
      final participantsToAdd = addParticipants;
      final participantsToDelete = deleteParticipants;

      debugPrint('Adding ${participantsToAdd.length} participants');
      debugPrint('Deleting ${participantsToDelete.length} participants');

      for (final participant in participantsToAdd) {
        // Ensure correct eventId and groupId
        final p = participant.copyWith(
          eventId: updatedEvent.eventId,
          groupId: _accountProvider.groupId,
        );
        await _supabaseService.addEventParticipant(p);
      }

      for (final participant in participantsToDelete) {
        await _supabaseService.removeEventParticipant(
          eventId: updatedEvent.eventId,
          dependentId: participant.dependentId,
        );
      }

      // Sync original participants
      _originalEventParticipants = List.from(_editedEventParticipants);

      debugPrint(
        'Event ${updatedEvent.eventId} saved successfully as ${asDraft ? 'draft' : 'published'}.',
      );

      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description:
              context.localizations.create_edit_event_screen_save_success,
        );
        await _loadEventsAfterSuccess(event: updatedEvent);
      }
    } catch (e) {
      debugPrint('Error saving event: $e');
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description:
              context.localizations.create_edit_event_screen_save_error_generic,
        );
      }
    } finally {
      if (mounted) {
        _setProcessingType(_ProcessingType.none);
      }
    }
  }

  // Deleting event
  Future<void> _deleteEvent() async {
    _setProcessingType(_ProcessingType.deleting);
    try {
      await _supabaseService.deleteEvent(eventId!);
      debugPrint('Event $eventId deleted successfully.');
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description: context
              .localizations
              .create_edit_event_screen_delete_event_success,
        );
        await _loadEventsAfterSuccess();
      }
    } catch (e) {
      debugPrint('Error deleting event: $e');
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description: context
              .localizations
              .create_edit_event_screen_delete_event_error_generic,
        );
      }
    } finally {
      if (mounted) {
        _setProcessingType(_ProcessingType.none);
      }
    }
  }

  // Get the text that should be displayed during processing
  String _getProcessingText(BuildContext context) {
    switch (_processingType) {
      case _ProcessingType.creating:
        return context
            .localizations
            .create_edit_event_screen_creating_event_progress_text;
      case _ProcessingType.editing:
        return context
            .localizations
            .create_edit_event_screen_editing_event_progress_text;
      case _ProcessingType.deleting:
        return context
            .localizations
            .create_edit_event_screen_deleting_event_progress_text;
      case _ProcessingType.none:
        return '';
    }
  }

  Future<void> _loadEventsAfterSuccess({EventModel? event}) async {
    final events = await SupabaseService().getGroupEvents(
      groupId: _accountProvider.groupId,
    );
    if (mounted) {
      context.read<EventsProvider>().setEvents(events);
    }
    if (mounted) {
      if (event == null) {
        // Deletion: pop CreateEdit and pop EventDetails
        context.router.pop(); // Pop CreateEdit
        if (widget.event != null) {
          context.router.pop(); // Pop EventDetails
        }
      } else {
        // Create/Edit: pop CreateEdit and push/replace EventDetails
        final type = EventUtils.getEventTimeType(event);

        if (widget.event != null) {
          // We were editing, replace the old details screen
          context.router.pop(); // Pop CreateEdit
          context.router.popAndPush(
            EventDetailsRoute(
              event: event,
              eventTimeType: type,
              unitsProvider: _unitsProvider,
            ),
          );
        } else {
          // We were creating, replace CreateEdit with new details screen
          context.router.popAndPush(
            EventDetailsRoute(
              event: event,
              eventTimeType: type,
              unitsProvider: _unitsProvider,
            ),
          );
        }
      }
    }
  }

  bool _forcePop = false;

  void _debugPrintChanges() {
    if (!kDebugMode) return;

    final oldE = originalEvent;
    final newE = editedEvent;

    debugPrint('--- CHANGE DETECTION DEBUG TABLE ---');
    debugPrint(
      '${"Field".padRight(20)} | ${"Old Value".padRight(30)} | ${"New Value".padRight(30)} | Changed',
    );
    debugPrint('-' * 100);

    void printDiff(String name, dynamic oldVal, dynamic newVal, bool changed) {
      final oldStr = (oldVal?.toString() ?? 'null')
          .replaceAll('\n', ' ')
          .trim();
      final newStr = (newVal?.toString() ?? 'null')
          .replaceAll('\n', ' ')
          .trim();
      final o = oldStr.length > 28 ? '${oldStr.substring(0, 25)}...' : oldStr;
      final n = newStr.length > 28 ? '${newStr.substring(0, 25)}...' : newStr;

      debugPrint(
        '${name.padRight(20)} | ${o.padRight(30)} | ${n.padRight(30)} | $changed',
      );
    }

    printDiff('Title', oldE.title, newE.title, oldE.title != newE.title);
    printDiff(
      'Instructions',
      oldE.instructions,
      newE.instructions,
      oldE.instructions != newE.instructions,
    );
    printDiff(
      'Open Sign Up',
      oldE.openSignUp,
      newE.openSignUp,
      oldE.openSignUp != newE.openSignUp,
    );
    printDiff(
      'Close Sign Up',
      oldE.closeSignUp,
      newE.closeSignUp,
      oldE.closeSignUp != newE.closeSignUp,
    );
    printDiff(
      'Start Date',
      oldE.startDate,
      newE.startDate,
      oldE.startDate != newE.startDate,
    );
    printDiff(
      'End Date',
      oldE.endDate,
      newE.endDate,
      oldE.endDate != newE.endDate,
    );
    printDiff(
      'Meeting Place',
      oldE.meetingPlace,
      newE.meetingPlace,
      oldE.meetingPlace != newE.meetingPlace,
    );
    printDiff(
      'Photo Link',
      oldE.photoAlbumLink,
      newE.photoAlbumLink,
      oldE.photoAlbumLink != newE.photoAlbumLink,
    );
    printDiff(
      'Draft Status',
      oldE.isDraft,
      newE.isDraft,
      oldE.isDraft != newE.isDraft,
    );

    final participantsChanged = !listEquals(
      _originalEventParticipants,
      _editedEventParticipants,
    );
    printDiff(
      'Participants',
      '${_originalEventParticipants.length} count',
      '${_editedEventParticipants.length} count',
      participantsChanged,
    );

    debugPrint('-' * 100);
  }

  bool get _hasUnsavedChanges {
    if (!_isInitialized) return false;
    _debugPrintChanges();
    // Exclude targetPatrolsIds from event model comparison as it is derived from participants
    return originalEvent.copyWith(targetPatrolsIds: []) !=
            editedEvent.copyWith(targetPatrolsIds: []) ||
        !listEquals(_originalEventParticipants, _editedEventParticipants);
  }

  void _showExitConfirmationDialog() {
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
            setState(() {
              _forcePop = true;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _forcePop || (!_isProcessing && !_hasUnsavedChanges),
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isProcessing) return;
        _showExitConfirmationDialog();
      },
      child: ChangeNotifierProvider(
        create: (_) => ValueNotifier<bool>(false),
        child: FutureBuilder(
          future: _initializationFuture,
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
                      : context
                            .localizations
                            .create_edit_event_screen_title_edit,
                ),
                body: Center(child: const LoadingFloatingLogo()),
              );
            }
            return Builder(
              builder: (context) {
                final dialOpenNotifier = context.watch<ValueNotifier<bool>>();
                return Stack(
                  children: [
                    ScreenWrapper(
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
                        onBackPressed: _isProcessing
                            ? () {}
                            : () => Navigator.of(context).maybePop(),
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
                                onEndDateChanged: (d) =>
                                    setState(() => _endDate = d),
                              ),
                              EventInstructionsContainer(
                                instructions: _instructions,
                                onSave: (newInstructions) {
                                  setState(() {
                                    _instructions = newInstructions;
                                  });
                                },
                              ),
                              EventParticipantsContainer(
                                originalParticipantsCount:
                                    originalParticipantsCount,
                                invitedParticipantsCount:
                                    totalParticipantsCount,
                                signedUpParticipantsCount:
                                    totalSignedUpParticipantsCount,
                                invitedLeadersCount: totalInvitedLeadersCount,
                                signedUpLeadersCount: totalSignedUpLeadersCount,
                                invited18PlusLeadersCount:
                                    total18PlusInvitedLeadersCount,
                                signedUp18PlusLeadersCount:
                                    total18PlusSignedUpLeadersCount,
                                targetPatrolNames: targetPatrolNames,
                                groupDependents: _groupDependents,
                                groupLeaders: _groupLeaders,
                                groupPatrols: _groupPatrols,
                                groupTroops: _groupTroops,
                                initialParticipants: _editedEventParticipants,
                                onParticipantsChanged: (updatedParticipants) {
                                  setState(() {
                                    _editedEventParticipants =
                                        updatedParticipants;
                                  });
                                },
                              ),
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
                          debugPrint('User confirmed delete event');
                          _deleteEvent();
                        },
                        onPublish: () {
                          debugPrint('User confirmed publish event');
                          final error = _validateEvent();
                          if (error != null) {
                            BottomDialog.show(
                              context,
                              type: BottomDialogType.negative,
                              description: error,
                            );
                            return;
                          }
                          if (eventId == null) {
                            _createNewEvent(asDraft: false);
                          } else {
                            _saveEditedEvent(asDraft: false);
                          }
                        },
                        onUnpublish: () {
                          debugPrint('User confirmed unpublish event');
                          if (eventId == null) {
                            _createNewEvent(asDraft: true);
                          } else {
                            _saveEditedEvent(asDraft: true);
                          }
                        },
                        onSave: ({required bool asDraft}) {
                          debugPrint(
                            'User confirmed save event (asDraft: $asDraft)',
                          );
                          final error = _validateEvent();
                          if (error != null) {
                            BottomDialog.show(
                              context,
                              type: BottomDialogType.negative,
                              description: error,
                            );
                            return;
                          }
                          if (eventId == null) {
                            _createNewEvent(asDraft: asDraft);
                          } else {
                            _saveEditedEvent(asDraft: asDraft);
                          }
                        },
                      ),
                      fabKey: dialOpenNotifier.hashCode,
                      openCloseDial: dialOpenNotifier,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
