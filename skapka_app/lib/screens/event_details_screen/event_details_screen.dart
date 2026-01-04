import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/event_box/participant_event_status_box.dart';
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
                        bottom: AppSpacing.bottomSpace + AppSpacing.large,
                      ),
                      child: Column(
                        spacing: AppSpacing.large,
                        children: [
                          if (dependentsProvider.dependents.isNotEmpty)
                            Column(
                              spacing: AppSpacing.small,
                              children: [
                                for (var dependent
                                    in dependentsProvider.dependents)
                                  Builder(
                                    builder: (context) {
                                      final participation = dependentsProvider
                                          .getParticipationForDependent(
                                            dependent.dependentId,
                                          );
                                      final eventParticipationList =
                                          participation.where(
                                            (p) => p.eventId == event.eventId,
                                          );

                                      if (eventParticipationList.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      final eventParticipation =
                                          eventParticipationList.first;

                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppSpacing.small,
                                          vertical: AppSpacing.xSmall,
                                        ),
                                        decoration:
                                            AppDecorations.primaryContainer(
                                              context,
                                            ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${dependent.dependentDetails?.name} ${dependent.dependentDetails?.surname}',
                                              style:
                                                  AppTextTheme.bodyLarge(
                                                    context,
                                                  ).copyWith(
                                                    color: context
                                                        .colors
                                                        .text
                                                        .normal,
                                                  ),
                                            ),
                                            ParticipantEventStatusBox(
                                              status: eventParticipation.status,
                                              isEnabled:
                                                  eventTimeType ==
                                                      EventTimeType.live &&
                                                  event.closeSignUp!.isAfter(
                                                    DateTime.now(),
                                                  ),
                                              eventModel: event,
                                              dependent: dependent,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          Column(
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
                                                    .contains(patrol.patrolId),
                                              )
                                              .map((patrol) => patrol.name)
                                              .join(', '),
                                          style: AppTextTheme.bodySmall(context)
                                              .copyWith(
                                                color:
                                                    context.colors.text.normal,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                          Column(
                            spacing: AppSpacing.medium,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(
                                  context,
                                )!.create_edit_event_screen_instructions_text,
                                style: AppTextTheme.titleMedium(context),
                              ),
                              Container(
                                decoration: AppDecorations.primaryContainer(
                                  context,
                                ),
                                padding: EdgeInsets.all(AppSpacing.small),
                                width: double.infinity,
                                child: MarkdownBody(
                                  data: event.instructions ?? '',
                                  selectable: true,
                                ),
                              ),
                            ],
                          ),
                          if (event.meetingPlace != null &&
                              event.meetingPlace!.isNotEmpty)
                            Column(
                              spacing: AppSpacing.medium,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(
                                    context,
                                  )!.create_edit_event_screen_meeting_place_text,
                                  style: AppTextTheme.titleMedium(context),
                                ),
                                Container(
                                  decoration: AppDecorations.primaryContainer(
                                    context,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.small,
                                    vertical: AppSpacing.xSmall,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            event.meetingPlace!,
                                            style: AppTextTheme.bodySmall(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                                      MainButton.text(
                                        type: ButtonType.icon,
                                        iconAsset: 'assets/icons/copy.svg',
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: event.meetingPlace!,
                                            ),
                                          );
                                          BottomDialog.show(
                                            context,
                                            type: BottomDialogType.basic,
                                            description: AppLocalizations.of(
                                              context,
                                            )!.common_copied_to_clipboard,
                                          );
                                        },
                                        text: '',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                      labelWidget: MainButton.filled(
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
