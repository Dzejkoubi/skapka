import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

class EventTitleForm extends StatelessWidget {
  const EventTitleForm({
    super.key,
    required TextEditingController eventTitleController,
  }) : _eventTitleController = eventTitleController;

  final TextEditingController _eventTitleController;

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      controller: _eventTitleController,
      labelText: AppLocalizations.of(
        context,
      )!.create_edit_event_screen_event_title_hint,
      characterLimit: 50,
      showSuffixIcon: false,
      validator: (title) {
        if (title == null || title.isEmpty) {
          return AppLocalizations.of(
            context,
          )!.create_edit_event_screen_event_title_error_empty;
        } else if (title.length > 50) {
          return AppLocalizations.of(
            context,
          )!.create_edit_event_screen_event_title_error_too_long;
        }
        return null;
      },
    );
  }
}
