// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get language => 'Čeština';

  @override
  String get welcome_screen_title => 'Vítejte ve\nSkapce';

  @override
  String get welcome_screen_login_button_text => 'Přihlásit se';

  @override
  String get welcome_screen_register_button_text => 'Registrovat se';

  @override
  String get welcome_screen_songbook_button_text => 'Zpěvník';
}
