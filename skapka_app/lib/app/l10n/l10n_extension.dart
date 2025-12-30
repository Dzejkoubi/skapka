import 'package:flutter/widgets.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
