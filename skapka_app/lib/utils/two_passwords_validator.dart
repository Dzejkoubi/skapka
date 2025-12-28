import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';

String? validateTwoPasswords(
  String? password1,
  String? password2, {
  required BuildContext context,
}) {
  if (password1 != password2) {
    return AppLocalizations.of(
      context,
    )!.register_screen_2_error_passwords_do_not_match;
  }
  return null;
}
