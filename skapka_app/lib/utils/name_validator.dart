import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';

String? validateName(
  bool isSurname,
  String? value, {
  required BuildContext context,
}) {
  if (value == null || value.isEmpty) {
    return isSurname
        ? AppLocalizations.of(context)!.register_screen_1_error_empty_surname
        : AppLocalizations.of(context)!.register_screen_1_error_empty_name;
  }
  if (!RegExp(r"^[a-zA-Z'-]+$").hasMatch(value)) {
    return isSurname
        ? AppLocalizations.of(context)!.register_screen_1_error_invalid_surname
        : AppLocalizations.of(context)!.register_screen_1_error_invalid_name;
  }
  return null;
}
