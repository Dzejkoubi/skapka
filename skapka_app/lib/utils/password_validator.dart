import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String? validatePassword(String? value, {required BuildContext context}) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(
      context,
    )!.login_screen_login_error_password_empty;
  }
  if (value.length < 8) {
    return AppLocalizations.of(
      context,
    )!.login_screen_login_error_password_too_short;
  }
  return null;
}
