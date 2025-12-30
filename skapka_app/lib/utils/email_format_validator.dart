import 'package:flutter/widgets.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';

String? validateEmail(String? value, {required BuildContext context}) {
  if (value == null || value.isEmpty) {
    return context.localizations.login_screen_login_error_email_empty;
  }
  // Basic email validation
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!emailRegex.hasMatch(value)) {
    return context.localizations.login_screen_login_error_email_invalid;
  }
  return null;
}
