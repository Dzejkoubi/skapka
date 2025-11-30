// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get welcome_screen_title => 'Welcome to\nSkapka';

  @override
  String get welcome_screen_login_button_text => 'Log in';

  @override
  String get welcome_screen_register_button_text => 'Register';

  @override
  String get welcome_screen_songbook_button_text => 'Songbook';
}
