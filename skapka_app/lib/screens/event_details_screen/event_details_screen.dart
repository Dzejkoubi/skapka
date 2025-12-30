import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/event_time_info.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final EventTimeType eventTimeType;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.eventTimeType,
  });

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
              screenName: event.title,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  spacing: AppSpacing.large,
                  children: [
                    Container(
                      decoration: AppDecorations.primaryContainer(context),
                      padding: EdgeInsets.all(AppSpacing.small),
                      child: EventTimeInfo(
                        event: event,
                        eventTimeType: eventTimeType,
                        fullInfo: true,
                      ),
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
                          decoration: AppDecorations.primaryContainer(context),
                          padding: EdgeInsets.all(AppSpacing.small),
                          width: double.infinity,
                          child: MarkdownBody(
                            data: event.instructions ?? '',
                            selectable: true,
                          ),
                        ),
                      ],
                    ),
                    if (event.meetingPlace != null)
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      event.meetingPlace!,
                                      style: AppTextTheme.bodySmall(context),
                                    ),
                                  ),
                                ),
                                MainButton.text(
                                  type: ButtonType.icon,
                                  iconAsset: 'assets/icons/copy.svg',
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: event.meetingPlace!),
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
              ),
            ),
            speedDialChildren: isUserLeader(context)
                ? [
                    SpeedDialChild(
                      labelWidget: MainButton.filled(
                        text: AppLocalizations.of(context)!.edit,
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
