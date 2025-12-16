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
  String get welcome_screen_title => 'Vítej ve\nSkapce';

  @override
  String get welcome_screen_login_button_text => 'Přihlásit se';

  @override
  String get welcome_screen_register_button_text => 'Registrovat se';

  @override
  String get welcome_screen_songbook_button_text => 'Zpěvník';

  @override
  String get login_screen_title => 'Přihlášení';

  @override
  String get login_screen_email_hint => 'E-mail';

  @override
  String get login_screen_password_hint => 'Heslo';

  @override
  String get login_screen_forgot_password_text => 'Zapomněl si heslo?';

  @override
  String get login_screen_login_button_text => 'Přihlásit se';

  @override
  String get login_screen_login_error_password_empty => 'Nezapomeň na heslo.';

  @override
  String get login_screen_login_error_password_too_short =>
      'Heslo musí mít alespoň 8 znaků.';

  @override
  String get login_screen_login_error_invalid_credentials =>
      'Neplatné přihlašovací údaje.';

  @override
  String get login_screen_login_error_email_empty =>
      'Nezapomněl/a si na email?';

  @override
  String get login_screen_login_error_email_invalid =>
      'Pozor, takhle přece nevypadá e-mail.';

  @override
  String get register_screen_title => 'Registrace';

  @override
  String get register_screen_1_name_hint => 'Jméno';

  @override
  String get register_screen_1_surname_hint => 'Příjmení';

  @override
  String get register_screen_1_email_hint => 'E-mail';

  @override
  String get register_screen_1_next_button_text => 'Další';

  @override
  String get register_screen_1_error_invalid_name =>
      'Jméno může obsahovat jen písmena a pomlčky.';

  @override
  String get register_screen_1_error_empty_name => 'Nemáš snad jméno?';

  @override
  String get register_screen_1_error_invalid_surname =>
      'Příjmení může obsahovat jen písmena a pomlčky.';

  @override
  String get register_screen_1_error_empty_surname => 'A co příjmení?';

  @override
  String get register_screen_1_error_email_empty => 'Nezapomněl/a si na email?';

  @override
  String get register_screen_1_error_email_invalid =>
      'Pozor, takhle přece nevypadá e-mail.';

  @override
  String get register_screen_2_password_hint => 'Heslo';

  @override
  String get register_screen_2_confirm_password_hint => 'Potvrď heslo';

  @override
  String get register_screen_2_register_button_text => 'Registrovat';

  @override
  String get register_screen_2_error_passwords_do_not_match =>
      'Hesla se neshodují.';
}
