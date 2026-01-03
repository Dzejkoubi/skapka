import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/utils/is_user_admin.dart';
import 'package:skapka_app/utils/is_user_leader.dart';

class CreateEditEventSpeedDial {
  static List<SpeedDialChild> build({
    required BuildContext context,
    required ValueNotifier<bool> dialOpenNotifier,
    required EventModel? event,
    required EventTimeType? eventTimeType,
    required VoidCallback onDelete,
    required VoidCallback onPublish,
    required VoidCallback onUnpublish,
    required Function({required bool asDraft}) onSave,
  }) {
    final l10n = context.localizations;
    final isDraft = event == null || eventTimeType == EventTimeType.draft;
    final isFutureOrLive =
        event != null &&
        (eventTimeType == EventTimeType.future ||
            eventTimeType == EventTimeType.live);
    final isPast = event != null && eventTimeType == EventTimeType.past;

    if (isDraft) {
      return [
        _buildDeleteChild(
          context,
          dialOpenNotifier,
          l10n,
          eventTimeType,
          onDelete,
          event,
        ),
        _buildPublishChild(context, dialOpenNotifier, l10n, onPublish),
        _buildSaveChild(context, dialOpenNotifier, l10n, onSave, asDraft: true),
      ];
    } else if (isFutureOrLive) {
      return [
        _buildDeleteChild(
          context,
          dialOpenNotifier,
          l10n,
          eventTimeType,
          onDelete,
          event,
        ),
        _buildUnpublishChild(
          context,
          dialOpenNotifier,
          l10n,
          eventTimeType,
          onUnpublish,
        ),
        _buildSaveChild(
          context,
          dialOpenNotifier,
          l10n,
          onSave,
          asDraft: false,
        ),
      ];
    } else if (isPast) {
      return [
        _buildDeleteChild(
          context,
          dialOpenNotifier,
          l10n,
          eventTimeType,
          onDelete,
          event,
        ),
        _buildUnpublishChild(
          context,
          dialOpenNotifier,
          l10n,
          eventTimeType,
          onUnpublish,
        ),
        _buildSaveChild(
          context,
          dialOpenNotifier,
          l10n,
          onSave,
          asDraft: false,
        ),
      ];
    }

    return [];
  }

  static SpeedDialChild _buildDeleteChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
    EventTimeType? eventTimeType,
    VoidCallback onDelete,
    EventModel? event,
  ) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.destructive,
        iconAsset: 'assets/icons/trash.svg',
        text: l10n.create_edit_event_screen_speed_dial_delete_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;

          if (event == null || event.eventId.isEmpty) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description: l10n
                  .create_edit_event_screen_delete_event_error_event_not_created,
            );
            return;
          }

          if (!isUserLeader(context)) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description:
                  l10n.create_edit_event_screen_delete_event_error_not_rights,
            );
            return;
          }

          if (eventTimeType == EventTimeType.past && !isUserAdmin(context)) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description: l10n
                  .create_edit_event_screen_delete_event_error_past_event_admin_only,
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
                onDelete();
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

  static SpeedDialChild _buildPublishChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
    VoidCallback onPublish,
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
                onPublish();
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

  static SpeedDialChild _buildUnpublishChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
    EventTimeType? eventTimeType,
    VoidCallback onUnpublish,
  ) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.normal,
        iconAsset: 'assets/icons/x.svg',
        text: l10n.create_edit_event_screen_speed_dial_unpublish_event_text,
        onPressed: () {
          dialOpenNotifier.value = false;

          if (eventTimeType == EventTimeType.past && !isUserAdmin(context)) {
            BottomDialog.show(
              context,
              type: BottomDialogType.negative,
              description: l10n
                  .create_edit_event_screen_delete_event_error_past_event_admin_only,
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
                onUnpublish();
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

  static SpeedDialChild _buildSaveChild(
    BuildContext context,
    ValueNotifier<bool> dialOpenNotifier,
    AppLocalizations l10n,
    Function({required bool asDraft}) onSave, {
    required bool asDraft,
  }) {
    return SpeedDialChild(
      labelWidget: MainButton.outlined(
        type: ButtonType.textIcon,
        variant: ButtonStylesVariants.normal,
        iconAsset: 'assets/icons/device-floppy.svg',
        text: l10n.save,
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
                  : l10n.save,
              onPrimaryPressed: () {
                onSave(asDraft: asDraft);
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
