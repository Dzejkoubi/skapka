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
  String get navbar_dependents => 'Dependents';

  @override
  String get navbar_events => 'Events';

  @override
  String get navbar_calendar => 'Calendar';

  @override
  String get navbar_info => 'Information';

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
  String get login_screen_login_error_email_not_confirmed =>
      'Email address is not confirmed. Please check your inbox.';

  @override
  String get login_screen_login_error_email_empty =>
      'Did you forget your email?';

  @override
  String get login_screen_login_error_email_invalid =>
      'Oops, that doesn\'t look like a valid email.';

  @override
  String get login_screen_login_success => 'Login successful!';

  @override
  String get login_screen_login_error_generic =>
      'Something went wrong. Please try again.';

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
  String get register_screen_2_registration_success =>
      'Registration successful!';

  @override
  String get register_screen_2_registration_error_email_used =>
      'This email is already in use. Try logging in or use a different email.';

  @override
  String get register_screen_2_registration_error_rate_limit =>
      'Too many attempts. Please try again later.';

  @override
  String get register_screen_2_registration_error_weak_password =>
      'Password is too weak.';

  @override
  String get register_screen_2_registration_error_generic =>
      'Registration failed. Please try again.';

  @override
  String get account_not_approved_screen_title => 'Account not yet approved';

  @override
  String account_not_approved_screen_text(String name_surname) {
    return 'An administrator must approve your account${name_surname}before you can log in. Once they do, you will receive an email.';
  }

  @override
  String get account_not_approved_screen_notify_administrator_button_text =>
      'Notify administrator';

  @override
  String get account_not_approved_screen_notify_administrator_dialog_title =>
      'Notify administrator';

  @override
  String
  get account_not_approved_screen_notify_administrator_dialog_description =>
      'This step will notify the administrator by email. It can be sent once a day.';

  @override
  String
  get account_not_approved_screen_notify_administrator_dialog_primary_button_text =>
      'Send notification';

  @override
  String
  get account_not_approved_screen_notify_administrator_button_error_dialog =>
      'Notifications can only be sent once every 24 hours. Please try again later.';

  @override
  String get account_not_approved_screen_notify_success =>
      'Administrator has been notified.';

  @override
  String get account_not_approved_screen_notify_error =>
      'Failed to notify administrator. Please try again later.';

  @override
  String get account_not_approved_screen_logout_button_text => 'Log out';

  @override
  String get account_not_approved_screen_logout_dialog_title => 'Log out';

  @override
  String get account_not_approved_screen_logout_dialog_description =>
      'Are you sure you want to log out of your account?';

  @override
  String get account_not_approved_screen_logout_dialog_primary_button_text =>
      'Log out';

  @override
  String get account_not_approved_screen_logout_success =>
      'Logged out successfully.';

  @override
  String get account_not_approved_screen_logout_error =>
      'Failed to log out. Please try again.';

  @override
  String get account_not_approved_screen_delete_account_button_text =>
      'Delete account';

  @override
  String get account_not_approved_screen_delete_account_dialog_title =>
      'Delete account';

  @override
  String get account_not_approved_screen_delete_account_dialog_description =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String
  get account_not_approved_screen_delete_account_dialog_primary_button_text =>
      'Delete account';

  @override
  String get account_not_approved_screen_delete_success =>
      'Your account has been deleted.';

  @override
  String get account_not_approved_screen_delete_error =>
      'Failed to delete account. Please try again later.';

  @override
  String get events_screen_title => 'Events';

  @override
  String get events_screen_speed_dial_open_create_event_text => 'Vytvořit';

  @override
  String events_screen_no_events_text(String version, Object username) {
    return '$username currently has no active events.';
  }

  @override
  String get events_screen_fab_create_event_text => 'Create';

  @override
  String event_box_number_of_kids_text(int number_of_kids) {
    return '$number_of_kids kids';
  }

  @override
  String get event_box_photos_link_text => 'Photos';

  @override
  String get event_box_sign_up_end_date_text => 'Sign-up ends on: ';

  @override
  String get event_box_event_multiple_days_start_text => 'From: ';

  @override
  String get event_box_event_multiple_days_end_text => 'To: ';

  @override
  String get event_box_event_single_day_text => 'When: ';

  @override
  String get calendar_screen_title => 'Calendar';

  @override
  String get calendar_screen_speed_dial_open_create_event_text => 'Vytvořit';

  @override
  String get calendar_screen_event_expansion_tile_future_title => 'Upcoming';

  @override
  String get calendar_screen_event_expansion_tile_live_title => 'Sign up';

  @override
  String get calendar_screen_event_expansion_tile_past_title => 'Past';

  @override
  String get calendar_screen_event_expansion_tile_draft_title => 'Drafts';

  @override
  String get settings_screen_title => 'Settings';

  @override
  String get settings_screen_change_signout_button_text => 'Sign out';

  @override
  String get settings_screen_change_delete_account_button_text =>
      'Delete account';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get loading => 'Loading...';
}
