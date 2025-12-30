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
import 'package:skapka_app/widgets/forms/custom_form.dart';
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
  final TextEditingController _eventTitleController = TextEditingController();
  DateTime? _openSignUp;
  DateTime? _closeSignUp;
  DateTime? _startDate;
  DateTime? _endDate;

  int _totalParticipantsCount = 0;
  String _patrols = '';
  int _totalLeadersCount = 0;
  int _total18PlusCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _eventTitleController.text = widget.event!.title ?? '';
      _openSignUp = widget.event!.openSignUp;
      _closeSignUp = widget.event!.closeSignUp;
      _startDate = widget.event!.startDate;
      _endDate = widget.event!.endDate;
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
                                              _patrols,
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
