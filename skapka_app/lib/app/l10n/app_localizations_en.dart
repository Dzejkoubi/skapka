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

  @override
  String get login_screen_title => 'Login';

  @override
  String get login_screen_email_hint => 'Email address';

  @override
  String get login_screen_password_hint => 'Password';

  @override
  String get login_screen_forgot_password_text => 'Forgot password?';

  @override
  String get login_screen_login_button_text => 'Log in';

  @override
  String get login_screen_login_error_password_empty =>
      'Did you forget your password?';

  @override
  String get login_screen_login_error_password_too_short =>
      'Password must be at least 8 characters.';

  @override
  String get login_screen_login_error_invalid_credentials =>
      'Invalid login credentials.';

  @override
  String get login_screen_login_error_email_empty =>
      'Did you forget your email?';

  @override
  String get login_screen_login_error_email_invalid =>
      'Oops, that doesn\'t look like a valid email.';

  @override
  String get register_screen_title => 'Register';

  @override
  String get register_screen_1_name_hint => 'Name';

  @override
  String get register_screen_1_surname_hint => 'Surname';

  @override
  String get register_screen_1_email_hint => 'Email address';

  @override
  String get register_screen_1_next_button_text => 'Next';

  @override
  String get register_screen_1_error_invalid_name =>
      'Name can only contain letters and hyphens.';

  @override
  String get register_screen_1_error_empty_name => 'Don\'t you have a name?';

  @override
  String get register_screen_1_error_invalid_surname =>
      'Surname can only contain letters and hyphens.';

  @override
  String get register_screen_1_error_empty_surname =>
      'What about your surname?';

  @override
  String get register_screen_1_error_email_empty =>
      'Did you forget your email?';

  @override
  String get register_screen_1_error_email_invalid =>
      'Oops, that doesn\'t look like a valid email.';

  @override
  String get register_screen_2_password_hint => 'Password';

  @override
  String get register_screen_2_confirm_password_hint => 'Confirm password';

  @override
  String get register_screen_2_register_button_text => 'Register';

  @override
  String get register_screen_2_error_passwords_do_not_match =>
      'Passwords do not match.';

  @override
  String get account_not_approved_screen_title => 'Account not yet approved';

  @override
  String get account_not_approved_screen_text =>
      'An administrator must approve your account before you can log in. Once they do, you will receive an email.';

  @override
  String get account_not_approved_screen_notify_administrator_button_text =>
      'Notify administrator';

  @override
  String get account_not_approved_screen_logout_button_text => 'Log out';

  @override
  String get account_not_approved_screen_delete_account_button_text =>
      'Delete account';
}
