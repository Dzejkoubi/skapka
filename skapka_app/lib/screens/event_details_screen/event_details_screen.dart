import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/event_details_screen/widgets/instructions_box.dart';
import 'package:skapka_app/screens/event_details_screen/widgets/meeting_leaving_place_builder.dart';
import 'package:skapka_app/screens/event_details_screen/widgets/sign_up_dependents_boxes.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/event_time_info.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final EventTimeType eventTimeType;
  final UnitsProvider unitsProvider;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.eventTimeType,
    required this.unitsProvider,
  });

  @override
  Widget build(BuildContext context) {
    DependentsProvider dependentsProvider = context.read<DependentsProvider>();
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Builder(
        builder: (context) {
          final dialOpenNotifier = context.watch<ValueNotifier<bool>>();
          return ScreenWrapper(
            appBar: Appbar(
              showBackChevron: true,
              showSettingsIcon: false,
              screenName: event.title,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Consumer<DependentsProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppSpacing.bottomSpace + AppSpacing.xxLarge,
                      ),
                      child: Column(
                        spacing: AppSpacing.large,
                        children: [
                          if (dependentsProvider.dependents.isNotEmpty &&
                              eventTimeType == EventTimeType.live)
                            SignUpDependentsBoxes(
                              dependentsProvider: dependentsProvider,
                              event: event,
                              eventTimeType: eventTimeType,
                            ),
                          Container(
                            padding: EdgeInsets.all(AppSpacing.small),
                            decoration: AppDecorations.primaryContainer(
                              context,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EventTimeInfo(
                                  event: event,
                                  eventTimeType: eventTimeType,
                                ),
                                if (event.targetPatrolsIds != null &&
                                    event.targetPatrolsIds!.isNotEmpty) ...[
                                  SizedBox(height: AppSpacing.small),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.event_box_target_patrols_text,
                                        style: AppTextTheme.bodySmall(context)
                                            .copyWith(
                                              color: context.colors.text.muted,
                                            ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          child: Text(
                                            unitsProvider.patrols
                                                .where(
                                                  (patrol) => event
                                                      .targetPatrolsIds!
                                                      .contains(
                                                        patrol.patrolId,
                                                      ),
                                                )
                                                .map((patrol) => patrol.name)
                                                .join(', '),
                                            style:
                                                AppTextTheme.bodySmall(
                                                  context,
                                                ).copyWith(
                                                  color: context
                                                      .colors
                                                      .text
                                                      .normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (event.instructions != null &&
                              event.instructions!.trim().isNotEmpty)
                            InstructionsBox(event: event),
                          MeetingLeavingPlaceBuilder(event: event),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            speedDialChildren: isUserLeader(context)
                ? [
                    SpeedDialChild(
                      labelWidget: MainButton(
                        text: context.localizations.edit,
                        onPressed: () {
                          dialOpenNotifier.value = false;
                          context.router.push(
                            CreateEditEventRoute(
                              event: event,
                              eventTimeType: eventTimeType,
                            ),
                          );
                        },
                        style:
                            (eventTimeType == EventTimeType.live ||
                                eventTimeType == EventTimeType.past)
                            ? ButtonStyleTypes.outlined
                            : ButtonStyleTypes.filled,
                        variant: ButtonStylesVariants.normal,
                      ),
                    ),
                    if (eventTimeType == EventTimeType.live ||
                        eventTimeType == EventTimeType.past)
                      SpeedDialChild(
                        labelWidget: MainButton(
                          style: ButtonStyleTypes.filled,
                          variant: eventTimeType == EventTimeType.live
                              ? ButtonStylesVariants.success
                              : ButtonStylesVariants.destructive,
                          text: context
                              .localizations
                              .live_event_attendance_speed_dial_button,
                          onPressed: () {
                            dialOpenNotifier.value = false;
                            context.router.push(LiveEventAttendanceRoute());
                          },
                        ),
                      ),
                  ]
                : null,
            fabKey: dialOpenNotifier.hashCode,
            openCloseDial: dialOpenNotifier,
          );
        },
      ),
    );
  }
}
