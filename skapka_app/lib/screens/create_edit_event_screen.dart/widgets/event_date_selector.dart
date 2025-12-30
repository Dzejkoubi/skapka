import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';

class EventDateSelector extends StatelessWidget {
  final DateTime? openSignUp;
  final DateTime? closeSignUp;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime) onOpenSignUpChanged;
  final Function(DateTime) onCloseSignUpChanged;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;

  const EventDateSelector({
    super.key,
    this.openSignUp,
    this.closeSignUp,
    this.startDate,
    this.endDate,
    required this.onOpenSignUpChanged,
    required this.onCloseSignUpChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  Future<void> _selectDateTime(
    BuildContext context,
    DateTime? initialDate,
    Function(DateTime) onSelected,
  ) async {
    final DateTime now = DateTime.now();
    final DateTime effectiveInitialDate = initialDate ?? now;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      DateTime tempDate = effectiveInitialDate;
      await showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text(AppLocalizations.of(context)!.cancel),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: Text(AppLocalizations.of(context)!.yes),
                    onPressed: () {
                      onSelected(tempDate);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: effectiveInitialDate,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: effectiveInitialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        if (!context.mounted) return;
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(effectiveInitialDate),
        );

        if (pickedTime != null) {
          onSelected(
            DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            ),
          );
        }
      }
    }
  }

  Widget _buildDateRow(
    BuildContext context,
    String label,
    DateTime? date,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              label,
              style: AppTextTheme.bodySmall(
                context,
              ).copyWith(color: context.colors.text.muted),
            ),
          ),
        ),
        Text(
          date != null ? DateFormat('d.M.y HH:mm').format(date) : '-',
          textAlign: TextAlign.right,
          style: AppTextTheme.bodySmall(context),
        ),
        SizedBox(width: AppSpacing.medium),
        MainButton.outlined(
          text: '',
          type: ButtonType.icon,
          variant: ButtonStylesVariants.normal,
          iconAsset: 'assets/icons/pencil.svg',
          onPressed: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      padding: const EdgeInsets.all(AppSpacing.xSmall),
      child: Column(
        children: [
          _buildDateRow(
            context,
            l10n.create_edit_event_screen_event_sign_up_from,
            openSignUp,
            () => _selectDateTime(context, openSignUp, onOpenSignUpChanged),
          ),
          const SizedBox(height: AppSpacing.xSmall),
          _buildDateRow(
            context,
            l10n.create_edit_event_screen_event_sign_up_to,
            closeSignUp,
            () => _selectDateTime(context, closeSignUp, onCloseSignUpChanged),
          ),
          Divider(
            color: context.colors.background.medium,
            height: AppSpacing.medium,
          ),
          _buildDateRow(
            context,
            l10n.create_edit_event_screen_event_from_hint,
            startDate,
            () => _selectDateTime(context, startDate, onStartDateChanged),
          ),
          const SizedBox(height: AppSpacing.xSmall),
          _buildDateRow(
            context,
            l10n.create_edit_event_screen_event_to_hint,
            endDate,
            () => _selectDateTime(context, endDate, onEndDateChanged),
          ),
        ],
      ),
    );
  }
}
