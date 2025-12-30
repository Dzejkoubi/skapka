import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_title_form.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_date_selector.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/create_edit_event_speed_dial.dart';

@RoutePage()
class CreateEditEventScreen extends StatefulWidget {
  final EventModel? event;
  final EventTimeType? eventTimeType;
  const CreateEditEventScreen({super.key, this.event, this.eventTimeType});

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
  String? _meetingPlace;
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
    meetingPlace: _meetingPlace,
    photoAlbumLink: _photoAlbumLink,
    groupId: _groupId,
    targetPatrolsIds: _targetPatrolsIds,
    lastEditedBy: _lastEditedBy,
    isDraft: _isDraft,
  );

  int _totalParticipantsCount = 0;
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
      _meetingPlace = widget.event!.meetingPlace;
      _photoAlbumLink = widget.event!.photoAlbumLink;
      _groupId = widget.event!.groupId;
      _targetPatrolsIds = widget.event!.targetPatrolsIds;
      _lastEditedBy = widget.event!.lastEditedBy;
      _isDraft = widget.event!.isDraft;
    }
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
                  ? AppLocalizations.of(
                      context,
                    )!.create_edit_event_screen_title_create
                  : AppLocalizations.of(
                      context,
                    )!.create_edit_event_screen_title_edit,
              onBackPressed: () {
                if (originalEvent != editedEvent) {
                  // Show confirmation dialog before leaving
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return LargeDialog(
                        type: LargeDialogType.negative,
                        title: AppLocalizations.of(
                          context,
                        )!.create_edit_event_screen_go_back_without_saving_dialog_title,
                        description: AppLocalizations.of(
                          context,
                        )!.create_edit_event_screen_go_back_without_saving_dialog_description,
                        primaryButtonText: AppLocalizations.of(
                          context,
                        )!.create_edit_event_screen_go_back_without_saving_dialog_primary_button_text,
                        secondaryButtonText: AppLocalizations.of(
                          context,
                        )!.cancel,
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
            body: SafeArea(
              child: ScrollableOnKeyboardScreenWrapper(
                builder: (constraints) {
                  return Column(
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
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          decoration: AppDecorations.primaryContainer(context),
                          padding: EdgeInsets.all(AppSpacing.small),
                          child: Container(
                            decoration: AppDecorations.secondaryContainer(
                              context,
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(AppSpacing.xSmall),
                            child: Column(
                              spacing: AppSpacing.medium,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/chevron-right.svg',
                                      width: AppSizes.iconSizeSmall,
                                      height: AppSizes.iconSizeSmall,
                                      colorFilter: ColorFilter.mode(
                                        Colors.transparent,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.create_edit_event_screen_select_participants_text,
                                        style: AppTextTheme.titleSmall(context),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/chevron-right.svg',
                                      width: AppSizes.iconSizeSmall,
                                      height: AppSizes.iconSizeSmall,
                                      colorFilter: ColorFilter.mode(
                                        context.colors.primary.light,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  spacing: AppSpacing.xSmall,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.create_edit_event_screen_total_participants_text}:',
                                          style:
                                              AppTextTheme.bodyMedium(
                                                context,
                                              ).copyWith(
                                                color:
                                                    context.colors.text.muted,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.medium,
                                        ),
                                        Text(
                                          '$_totalParticipantsCount',
                                          style: AppTextTheme.bodyMedium(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.create_edit_event_screen_troops}:',
                                          style:
                                              AppTextTheme.bodyMedium(
                                                context,
                                              ).copyWith(
                                                color:
                                                    context.colors.text.muted,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.medium,
                                        ),
                                        Flexible(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              _targetPatrolNames,
                                              style: AppTextTheme.bodyMedium(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.create_edit_event_screen_18_leaders}:',
                                          style:
                                              AppTextTheme.bodyMedium(
                                                context,
                                              ).copyWith(
                                                color:
                                                    context.colors.text.muted,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: AppSpacing.medium,
                                        ),
                                        Flexible(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              '$_totalLeadersCount / $_total18PlusCount',
                                              style: AppTextTheme.bodyMedium(
                                                context,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
