import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/utils/is_user_admin.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _eventTitleController.text = widget.event!.title ?? '';
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
                    children: [
                      CustomForm(
                        controller: _eventTitleController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.create_edit_event_screen_event_title_hint,
                      ),
                    ],
                  );
                },
              ),
            ),
            speedDialChildren: _buildSpeedDialChildren(
              context,
              dialOpenNotifier,
            ),
            fabKey: dialOpenNotifier.hashCode,
            openCloseDial: dialOpenNotifier,
          );
        },
      ),
    );
  }

  List<SpeedDialChild> _buildSpeedDialChildren(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final isDraft =
        widget.event == null || widget.eventTimeType == EventTimeType.draft;
    final isFutureOrLive =
        widget.event != null &&
        (widget.eventTimeType == EventTimeType.future ||
            widget.eventTimeType == EventTimeType.live);
    final isPast =
        widget.event != null && widget.eventTimeType == EventTimeType.past;

    if (isDraft) {
      return [
        _buildDeleteChild(context, dialOpenNotifier, l10n),
        _buildPublishChild(context, dialOpenNotifier, l10n),
        _buildSaveChild(context, dialOpenNotifier, l10n, asDraft: true),
      ];
    } else if (isFutureOrLive) {
      return [
        _buildDeleteChild(context, dialOpenNotifier, l10n),
        _buildUnpublishChild(context, dialOpenNotifier, l10n),
        _buildSaveChild(context, dialOpenNotifier, l10n, asDraft: false),
      ];
    } else if (isPast) {
      return [
        _buildDeleteChild(context, dialOpenNotifier, l10n),
        _buildUnpublishChild(context, dialOpenNotifier, l10n),
        _buildSaveChild(context, dialOpenNotifier, l10n, asDraft: false),
      ];
    }

    return [];
  }

  SpeedDialChild _buildDeleteChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
  ) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.destructive,
        iconAsset: 'assets/icons/trash.svg',
        text: l10n.create_edit_event_screen_speed_dial_delete_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;

          if (widget.eventTimeType == EventTimeType.past &&
              !isUserAdmin(context)) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description:
                  l10n.create_edit_event_screen_past_event_admin_only_error,
            );
            return;
          }

          showDialog(
            context: context,
            builder: (_) => LargeDialog(
              type: LargeDialogType.negative,
              title: l10n.create_edit_event_screen_delete_event_dialog_title,
              description:
                  l10n.create_edit_event_screen_delete_event_dialog_description,
              primaryButtonText: l10n
                  .create_edit_event_screen_delete_event_dialog_primary_button_text,
              onPrimaryPressed: () {
                if (kDebugMode) print('User confirmed delete event');
                Navigator.of(context).pop();
              },
              secondaryButtonText: l10n.cancel,
              onSecondaryPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
    );
  }

  SpeedDialChild _buildPublishChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
  ) {
    return SpeedDialChild(
      labelWidget: MainButton.filled(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.success,
        iconAsset: 'assets/icons/plus.svg',
        text: l10n.create_edit_event_screen_speed_dial_publish_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;
          showDialog(
            context: context,
            builder: (_) => LargeDialog(
              type: LargeDialogType.positive,
              title: l10n.create_edit_event_screen_publish_event_dialog_title,
              description: l10n
                  .create_edit_event_screen_publish_event_dialog_description,
              primaryButtonText: l10n
                  .create_edit_event_screen_publish_event_dialog_primary_button_text,
              onPrimaryPressed: () {
                if (kDebugMode) print('User confirmed publish event');
                Navigator.of(context).pop();
              },
              secondaryButtonText: l10n.cancel,
              onSecondaryPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
    );
  }

  SpeedDialChild _buildUnpublishChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
  ) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.normal,
        iconAsset: 'assets/icons/x.svg',
        text: l10n.create_edit_event_screen_speed_dial_unpublish_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;

          if (widget.eventTimeType == EventTimeType.past &&
              !isUserAdmin(context)) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description:
                  l10n.create_edit_event_screen_past_event_admin_only_error,
            );
            return;
          }

          showDialog(
            context: context,
            builder: (_) => LargeDialog(
              type: LargeDialogType.negative,
              title: l10n.create_edit_event_screen_unpublish_event_dialog_title,
              description: l10n
                  .create_edit_event_screen_unpublish_event_dialog_description,
              primaryButtonText: l10n
                  .create_edit_event_screen_unpublish_event_dialog_primary_button_text,
              onPrimaryPressed: () {
                if (kDebugMode) print('User confirmed unpublish event');
                Navigator.of(context).pop();
              },
              secondaryButtonText: l10n.cancel,
              onSecondaryPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
    );
  }

  SpeedDialChild _buildSaveChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n, {
    required bool asDraft,
  }) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.normal,
        iconAsset: 'assets/icons/device-floppy.svg',
        text: l10n.create_edit_event_screen_speed_dial_save_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;
          showDialog(
            context: context,
            builder: (_) => LargeDialog(
              type: asDraft ? LargeDialogType.basic : LargeDialogType.positive,
              title: asDraft
                  ? l10n.create_edit_event_screen_save_event_dialog_title
                  : l10n.create_edit_event_screen_save_changes_dialog_title,
              description: asDraft
                  ? l10n.create_edit_event_screen_save_event_dialog_description
                  : l10n.create_edit_event_screen_save_changes_dialog_description,
              primaryButtonText: asDraft
                  ? l10n.create_edit_event_screen_save_event_dialog_primary_button_text
                  : l10n.create_edit_event_screen_save_changes_dialog_primary_button_text,
              onPrimaryPressed: () {
                if (kDebugMode) print('User confirmed save event');
                Navigator.of(context).pop();
              },
              secondaryButtonText: l10n.cancel,
              onSecondaryPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
    );
  }
}
