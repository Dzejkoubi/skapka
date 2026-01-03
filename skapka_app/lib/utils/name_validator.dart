import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';

String? validateName(
  bool isSurname,
  String? value, {
  required BuildContext context,
}) {
  if (value == null || value.isEmpty) {
    return isSurname
        ? context.localizations.register_screen_1_error_empty_surname
        : context.localizations.register_screen_1_error_empty_name;
  }
  if (!RegExp(r"^[a-zA-Z'-]+$").hasMatch(value)) {
    return isSurname
        ? context.localizations.register_screen_1_error_invalid_surname
        : context.localizations.register_screen_1_error_invalid_name;
  }
  return null;
}
