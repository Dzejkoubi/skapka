import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/models/leader_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_instructions_container.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/loading_floating_logo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_participants_container.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_title_form.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/meeting_place_container.dart';
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
  String? _eventId;
  final TextEditingController _eventTitleController = TextEditingController();
  String? _instructions;
  DateTime? _openSignUp;
  DateTime? _closeSignUp;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _meetingPlaceController = TextEditingController();
  String? _photoAlbumLink;
  String? _groupId;
  List<String>? _targetPatrolsIds;
  String? _lastEditedBy;
  bool _isDraft = true;

  late final EventModel originalEvent =
      widget.event ??
      EventModel(
        eventId: '',
        title: '',
        instructions: '',
        openSignUp: null,
        closeSignUp: null,
        startDate: null,
        endDate: null,
        meetingPlace: null,
        photoAlbumLink: null,
        groupId: null,
        targetPatrolsIds: null,
        lastEditedBy: null,
        isDraft: true,
      );

  late EventModel editedEvent = originalEvent.copyWith(
    eventId: _eventId,
    title: _eventTitleController.text,
    instructions: _instructions,
    openSignUp: _openSignUp,
    closeSignUp: _closeSignUp,
    startDate: _startDate,
    endDate: _endDate,
    meetingPlace: _meetingPlaceController.text,
    photoAlbumLink: _photoAlbumLink,
    groupId: _groupId,
    targetPatrolsIds: _targetPatrolsIds,
    lastEditedBy: _lastEditedBy,
    isDraft: _isDraft,
  );

  late List<EventParticipantModel> _originalEventParticipants =
      widget.eventParticipants ?? [];

  late List<EventParticipantModel> _editedEventParticipants = [];

  final SupabaseService _supabaseService = SupabaseService();
  List<DependentModel> _groupDependents = [];
  List<LeaderModel> _groupLeaders = [];
  List<PatrolModel> _groupPatrols = [];
  List<TroopModel> _groupTroops = [];
  late Future<void> _dataFetchFuture;

  int _totalParticipantsCount = 0;
  int _totalSignedUpParticipantsCount = 0;
  String _targetPatrolNames = '';
  int _totalLeadersCount = 0;
  int _total18PlusCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _eventId = widget.event!.eventId;
      _eventTitleController.text = widget.event!.title ?? '';
      _instructions = widget.event!.instructions;
      _openSignUp = widget.event!.openSignUp;
      _closeSignUp = widget.event!.closeSignUp;
      _startDate = widget.event!.startDate;
      _endDate = widget.event!.endDate;
      _meetingPlaceController.text = widget.event!.meetingPlace ?? '';
      _photoAlbumLink = widget.event!.photoAlbumLink;
      _groupId = widget.event!.groupId;
      _targetPatrolsIds = widget.event!.targetPatrolsIds;
      _lastEditedBy = widget.event!.lastEditedBy;
      _isDraft = widget.event!.isDraft;
    }
    _dataFetchFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;

      // Get account to find group_id
      final account = await _supabaseService.getAccountDetails(userId);
      if (account == null) return;
      _groupId = account.groupId;

      // Fetch group data
      final results = await Future.wait([
        _supabaseService.getGroupDependents(_groupId!),
        _supabaseService.getGroupLeaders(_groupId!),
        _supabaseService.getGroupPatrols(_groupId!),
        _supabaseService.getGroupTroops(_groupId!),
      ]);

      _groupDependents = results[0] as List<DependentModel>;
      _groupLeaders = results[1] as List<LeaderModel>;
      _groupPatrols = results[2] as List<PatrolModel>;
      _groupTroops = results[3] as List<TroopModel>;

      if (kDebugMode) {
        print('--- Data Fetch Debug ---');
        print('GroupId: $_groupId');
        print('Dependents: ${_groupDependents.length}');
        print('Leaders: ${_groupLeaders.length}');
        print('Patrols: ${_groupPatrols.map((p) => p.name).toList()}');
        print('Troops: ${_groupTroops.map((t) => t.name).toList()}');
      }

      // If editing, fetch participants if not provided
      if (widget.event != null && widget.eventParticipants == null) {
        _editedEventParticipants = await _supabaseService.getEventParticipants(
          widget.event!.eventId,
          _groupId!,
        );
      } else if (widget.eventParticipants != null) {
        _editedEventParticipants = List.from(widget.eventParticipants!);
      }

      if (kDebugMode) {
        print('Event Participants: ${_editedEventParticipants.length}');
      }

      _calculateStats();
    } catch (e) {
      if (kDebugMode) print('Error fetching data: $e');
    }
  }

  void _calculateStats() {
    _totalParticipantsCount = _editedEventParticipants.length;
    _totalSignedUpParticipantsCount = _editedEventParticipants
        .where((p) => p.status == 'attending' || p.status == 'signed_up')
        .length;

    int leaders = 0;
    int plus18 = 0;
    final Set<String> patrolIds = {};

    for (var p in _editedEventParticipants) {
      // Check leader
      if (_groupLeaders.any((l) => l.dependentId == p.dependentId)) {
        leaders++;
      }

      // Find dependent
      final dependent = _groupDependents.firstWhere(
        (d) => d.dependentId == p.dependentId,
        orElse: () => DependentModel(
          name: '',
          surname: '',
          sex: SexEnum.other,
          isArchived: false,
          secretCode: '',
          createdAt: DateTime.now(),
        ),
      );

      // Check 18+
      if (dependent.born != null) {
        final age = DateTime.now().difference(dependent.born!).inDays / 365.25;
        if (age >= 18) plus18++;
      }

      // Collect patrol ID
      if (dependent.patrolId != null) {
        patrolIds.add(dependent.patrolId!);
      }
    }

    _totalLeadersCount = leaders;
    _total18PlusCount = plus18;

    // Update target patrols
    _targetPatrolsIds = patrolIds.toList();
    if (_targetPatrolsIds != null && _targetPatrolsIds!.isNotEmpty) {
      final names = _groupPatrols
          .where((p) => _targetPatrolsIds!.contains(p.patrolId))
          .map((p) => p.name)
          .toList();
      _targetPatrolNames = names.join(', ');
    } else {
      _targetPatrolNames = '';
    }

    if (kDebugMode) {
      print('--- Stats Calculation Debug ---');
      print('Total Participants: $_totalParticipantsCount');
      print('Signed Up: $_totalSignedUpParticipantsCount');
      print('Leaders Count: $_totalLeadersCount');
      print('18+ Count: $_total18PlusCount');
      print('Target Patrols: $_targetPatrolNames');
    }

    setState(() {});
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
            body: FutureBuilder(
              future: _dataFetchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingFloatingLogo());
                }
                return SingleChildScrollView(
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
                        EventParticipantsContainer(
                          groupDependents: _groupDependents,
                          groupLeaders: _groupLeaders,
                          groupPatrols: _groupPatrols,
                          groupTroops: _groupTroops,
                          eventParticipants: _editedEventParticipants,
                          onParticipantsChanged: (participants) {
                            setState(() {
                              _editedEventParticipants = participants;
                            });
                            _calculateStats();
                          },
                          totalParticipantsCount: _totalParticipantsCount,
                          targetPatrolNames: _targetPatrolNames,
                          totalLeadersCount: _totalLeadersCount,
                          total18PlusCount: _total18PlusCount,
                          totalSignedUpParticipantsCount:
                              _totalSignedUpParticipantsCount,
                        ),
                        EventInstructionsContainer(),
                        MeetingPlaceContainer(
                          meetingPlaceController: _meetingPlaceController,
                        ),
                        SizedBox(height: AppSpacing.bottomSpace),
                      ],
                    ),
                  ),
                );
              },
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
                if (kDebugMode)
                  print('User confirmed save event (asDraft: $asDraft)');
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
