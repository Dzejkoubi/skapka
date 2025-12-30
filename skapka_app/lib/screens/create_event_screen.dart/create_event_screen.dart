import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

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
              screenName: AppLocalizations.of(
                context,
              )!.create_event_screen_title,
            ),
            body: SafeArea(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.create_event_screen_title,
                ),
              ),
            ),
            speedDialChildren: [
              SpeedDialChild(
                labelWidget: MainButton.outlined(
                  type: ButtonType.textIcon,
                  variant: ButtonStylesVariants.destructive,
                  iconAsset: 'assets/icons/trash.svg',
                  text: AppLocalizations.of(
                    context,
                  )!.create_event_screen_speed_dial_delete_event_text,
                  onPressed: () => {
                    dialOpenNotifier.value = false,
                    showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          type: LargeDialogType.negative,
                          title: AppLocalizations.of(
                            context,
                          )!.create_event_screen_delete_event_dialog_title,
                          description: AppLocalizations.of(
                            context,
                          )!.create_event_screen_delete_event_dialog_description,
                          primaryButtonText: AppLocalizations.of(
                            context,
                          )!.create_event_screen_delete_event_dialog_primary_button_text,
                          onPrimaryPressed: () {
                            if (kDebugMode) {
                              print(
                                'User confirmed delete event',
                              ); // TODO: implement delete event
                            }
                            Navigator.of(context).pop();
                          },
                          secondaryButtonText: AppLocalizations.of(
                            context,
                          )!.cancel,
                          onSecondaryPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  },
                ),
              ),
              SpeedDialChild(
                labelWidget: MainButton.filled(
                  type: ButtonType.textIcon,
                  variant: ButtonStylesVariants.success,
                  iconAsset: 'assets/icons/plus.svg',
                  text: AppLocalizations.of(
                    context,
                  )!.create_event_screen_speed_dial_publish_event_text,
                  onPressed: () => {
                    dialOpenNotifier.value = false,
                    showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          type: LargeDialogType.positive,
                          title: AppLocalizations.of(
                            context,
                          )!.create_event_screen_publish_event_dialog_title,
                          description: AppLocalizations.of(
                            context,
                          )!.create_event_screen_publish_event_dialog_description,
                          primaryButtonText: AppLocalizations.of(
                            context,
                          )!.create_event_screen_publish_event_dialog_primary_button_text,
                          onPrimaryPressed: () {
                            if (kDebugMode) {
                              print(
                                'User confirmed publish event',
                              ); // TODO: implement publish event
                              Navigator.of(context).pop();
                            }
                          },
                          secondaryButtonText: AppLocalizations.of(
                            context,
                          )!.cancel,
                          onSecondaryPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  },
                ),
              ),
              SpeedDialChild(
                labelWidget: MainButton.outlined(
                  type: ButtonType.textIcon,
                  variant: ButtonStylesVariants.normal,
                  iconAsset: 'assets/icons/device-floppy.svg',
                  text: AppLocalizations.of(
                    context,
                  )!.create_event_screen_speed_dial_save_event_text,
                  onPressed: () => {
                    dialOpenNotifier.value = false,
                    showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          type: LargeDialogType.basic,
                          title: AppLocalizations.of(
                            context,
                          )!.create_event_screen_save_event_dialog_title,
                          description: AppLocalizations.of(
                            context,
                          )!.create_event_screen_save_event_dialog_description,
                          primaryButtonText: AppLocalizations.of(
                            context,
                          )!.create_event_screen_save_event_dialog_primary_button_text,
                          onPrimaryPressed: () {
                            if (kDebugMode) {
                              print(
                                'User confirmed save event',
                              ); // TODO: implement save event
                              Navigator.of(context).pop();
                            }
                          },
                          secondaryButtonText: AppLocalizations.of(
                            context,
                          )!.cancel,
                          onSecondaryPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  },
                ),
              ),
            ],
            fabKey: dialOpenNotifier.hashCode,
            openCloseDial: dialOpenNotifier,
          );
        },
      ),
    );
  }
}
