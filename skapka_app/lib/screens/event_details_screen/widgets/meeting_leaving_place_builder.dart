import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

class MeetingLeavingPlaceBuilder extends StatelessWidget {
  const MeetingLeavingPlaceBuilder({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bool hasMeeting = event.meetingPlace?.isNotEmpty ?? false;
        final bool hasLeaving = event.leavingPlace?.isNotEmpty ?? false;

        if (!hasMeeting && !hasLeaving) {
          return const SizedBox.shrink();
        }

        if (hasMeeting && !hasLeaving) {
          return Column(
            spacing: AppSpacing.medium,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(
                  context,
                )!.create_edit_event_screen_meeting_place_text,
                style: AppTextTheme.titleLarge(context),
              ),
              Container(
                decoration: AppDecorations.primaryContainer(context),
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
          );
        }

        if (!hasMeeting && hasLeaving) {
          return Column(
            spacing: AppSpacing.medium,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(
                  context,
                )!.create_edit_event_screen_leave_place_text,
                style: AppTextTheme.titleLarge(context),
              ),
              Container(
                decoration: AppDecorations.primaryContainer(context),
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
                          event.leavingPlace!,
                          style: AppTextTheme.bodySmall(context),
                        ),
                      ),
                    ),
                    MainButton.text(
                      type: ButtonType.icon,
                      iconAsset: 'assets/icons/copy.svg',
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: event.leavingPlace!),
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
          );
        }

        if (hasMeeting && hasLeaving) {
          if (event.meetingPlace == event.leavingPlace) {
            // Same place
            return Column(
              spacing: AppSpacing.medium,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(
                    context,
                  )!.create_edit_event_screen_meeting_and_leave_place_text,
                  style: AppTextTheme.titleLarge(context),
                ),
                Container(
                  decoration: AppDecorations.primaryContainer(context),
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
            );
          } else {
            // Different places
            return Column(
              spacing: AppSpacing.medium,
              children: [
                // Meeting place
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(
                    context,
                  )!.create_edit_event_screen_meeting_place_text,
                  style: AppTextTheme.titleLarge(context),
                ),
                Container(
                  decoration: AppDecorations.primaryContainer(context),
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
                // Leaving place
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(
                    context,
                  )!.create_edit_event_screen_leave_place_text,
                  style: AppTextTheme.titleLarge(context),
                ),
                Container(
                  decoration: AppDecorations.primaryContainer(context),
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
                            event.leavingPlace!,
                            style: AppTextTheme.bodySmall(context),
                          ),
                        ),
                      ),
                      MainButton.text(
                        type: ButtonType.icon,
                        iconAsset: 'assets/icons/copy.svg',
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: event.leavingPlace!),
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
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
