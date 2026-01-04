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
  String get category_common => '--- COMMON ---';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get loading => 'Loading...';

  @override
  String get back => 'Back';

  @override
  String get common_copied_to_clipboard => 'Copied to clipboard 📋';

  @override
  String get create => 'Create';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get load_more => 'Load more';

  @override
  String get error => 'Error';

  @override
  String get generic_error => 'Something went wrong. Please try again.';

  @override
  String get something_is_missing_title_1 => 'Quiet on the front... 🤫';

  @override
  String get something_is_missing_title_2 => 'Nothing to see here... 🤷‍♂️';

  @override
  String get something_is_missing_title_3 => 'It\'s a ghost town... 👻';

  @override
  String get something_is_missing_title_4 => 'Empty as a desert... 🏜️';

  @override
  String get something_is_missing_title_5 => 'Crickets... 🦗';

  @override
  String get something_is_missing_title_6 => 'Tumbleweeds... 🌵';

  @override
  String get something_is_missing_title_7 => 'Not a soul in sight... �';

  @override
  String get something_is_missing_title_8 => 'All quiet... 🎖️';

  @override
  String get something_is_missing_title_9 => 'The void... 🌌';

  @override
  String get something_is_missing_title_10 => 'Clean slate... 🧼';

  @override
  String get category_navigation => '--- NAVIGATION ---';

  @override
  String get navbar_dependents => 'Dependents';

  @override
  String get navbar_events => 'Events';

  @override
  String get navbar_calendar => 'Calendar';

  @override
  String get navbar_info => 'Information';

  @override
  String get category_welcome_screen => '--- WELCOME SCREEN ---';

  @override
  String get welcome_screen_title => 'Welcome to\nSkapka 👋';

  @override
  String get welcome_screen_login_button_text => 'Log in';

  @override
  String get welcome_screen_register_button_text => 'Register';

  @override
  String get welcome_screen_songbook_button_text => 'Songbook';

  @override
  String get category_login_screen => '--- LOGIN SCREEN ---';

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
  String get login_screen_login_success => 'Login successful! 🎉';

  @override
  String get login_screen_login_error_generic =>
      'Something went wrong. Please try again.';

  @override
  String get category_register_screen => '--- REGISTER SCREEN ---';

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
      'Registration successful! 🎊';

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
  String get category_account_not_approved_screen =>
      '--- ACCOUNT NOT APPROVED SCREEN ---';

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
      'Administrator has been notified. 📧';

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
      'Your account has been deleted. 👋';

  @override
  String get account_not_approved_screen_delete_error =>
      'Failed to delete account. Please try again later.';

  @override
  String get category_events_screen => '--- EVENTS SCREEN ---';

  @override
  String get events_screen_title => 'Events';

  @override
  String events_screen_no_events_text(String version, Object username) {
    return '$username currently has no active events.';
  }

  @override
  String get category_event_box_widget => '--- EVENT BOX WIDGET ---';

  @override
  String event_box_number_of_kids_text(int number_of_kids) {
    return '$number_of_kids kids';
  }

  @override
  String get event_box_photos_link_text => 'Photos';

  @override
  String get event_box_sign_up_start_date_text => 'Sign-up starts on: ';

  @override
  String get event_box_sign_up_end_date_text => 'Sign-up ends on: ';

  @override
  String get event_box_event_multiple_days_start_text => 'From: ';

  @override
  String get event_box_event_multiple_days_end_text => 'To: ';

  @override
  String get event_box_event_single_day_text => 'When: ';

  @override
  String get event_box_target_patrols_text => 'Patrols: ';

  @override
  String get event_box_open_error_event_not_live =>
      'Cannot open event details for an event that is not live.';

  @override
  String get category_calendar_screen => '--- CALENDAR SCREEN ---';

  @override
  String get calendar_screen_title => 'Calendar';

  @override
  String get calendar_screen_speed_dial_add_google_calendar =>
      'Google Calendar';

  @override
  String get calendar_screen_event_expansion_tile_future_title => 'Upcoming';

  @override
  String get calendar_screen_event_expansion_tile_future_no_events_subtitle =>
      'It seems there are no upcoming events.';

  @override
  String get calendar_screen_event_expansion_tile_live_title => 'Current';

  @override
  String get calendar_screen_event_expansion_tile_live_no_events_subtitle =>
      'It seems there are no current events.';

  @override
  String get calendar_screen_event_expansion_tile_past_title => 'Past';

  @override
  String get calendar_screen_event_expansion_tile_past_no_events_subtitle =>
      'It seems there are no past events.';

  @override
  String get calendar_screen_event_expansion_tile_draft_title => 'Drafts';

  @override
  String get calendar_screen_event_expansion_tile_draft_no_events_subtitle =>
      'It seems there are no draft events.';

  @override
  String get category_create_edit_event_screen =>
      '--- CREATE/EDIT EVENT SCREEN ---';

  @override
  String get create_edit_event_screen_title_create => 'Create event';

  @override
  String get create_edit_event_screen_title_edit => 'Edit event';

  @override
  String get create_edit_event_screen_save_event_dialog_title =>
      'Save as Draft';

  @override
  String get create_edit_event_screen_save_event_dialog_description =>
      'Do you want to save this event as a draft? The event will be published only after clicking the publish button. You can edit it later.';

  @override
  String get create_edit_event_screen_save_event_dialog_primary_button_text =>
      'Save as Draft';

  @override
  String get create_edit_event_screen_save_changes_dialog_title =>
      'Save Changes';

  @override
  String get create_edit_event_screen_save_changes_dialog_description =>
      'Are you sure you want to save changes to this event?';

  @override
  String get create_edit_event_screen_speed_dial_publish_event_text =>
      'Publish';

  @override
  String get create_edit_event_screen_publish_event_dialog_title =>
      'Publish Event';

  @override
  String get create_edit_event_screen_publish_event_dialog_description =>
      'Are you sure you want to publish this event? It will be visible to all participants.';

  @override
  String
  get create_edit_event_screen_publish_event_dialog_primary_button_text =>
      'Publish';

  @override
  String get create_edit_event_screen_speed_dial_unpublish_event_text =>
      'Unpublish';

  @override
  String get create_edit_event_screen_unpublish_event_dialog_title =>
      'Unpublish Event';

  @override
  String get create_edit_event_screen_unpublish_event_dialog_description =>
      'Are you sure you want to unpublish this event? It will be hidden from all participants.';

  @override
  String
  get create_edit_event_screen_unpublish_event_dialog_primary_button_text =>
      'Unpublish';

  @override
  String get create_edit_event_screen_speed_dial_delete_event_text =>
      'Delete Event';

  @override
  String get create_edit_event_screen_delete_event_dialog_title =>
      'Delete Event';

  @override
  String get create_edit_event_screen_delete_event_dialog_description =>
      'Are you sure you want to delete this event? This action cannot be undone.';

  @override
  String get create_edit_event_screen_delete_event_dialog_primary_button_text =>
      'Delete';

  @override
  String
  get create_edit_event_screen_delete_event_error_past_event_admin_only =>
      'Only administrators can delete or unpublish past events.';

  @override
  String get create_edit_event_screen_delete_event_error_event_not_created =>
      'Cannot delete an event that has not been created yet.';

  @override
  String get create_edit_event_screen_delete_event_error_not_rights =>
      'You do not have permission to delete events.';

  @override
  String get create_edit_event_screen_delete_event_error_generic =>
      'Deleting the event failed. Please try again.';

  @override
  String get create_edit_event_screen_delete_event_success =>
      'Event was successfully deleted🥳.';

  @override
  String get create_edit_event_screen_go_back_without_saving_dialog_title =>
      'Discard Changes';

  @override
  String
  get create_edit_event_screen_go_back_without_saving_dialog_description =>
      'Are you sure you want to go back without saving changes? All unsaved changes will be lost.';

  @override
  String
  get create_edit_event_screen_go_back_without_saving_dialog_primary_button_text =>
      'Discard';

  @override
  String get create_edit_event_screen_event_title_hint => 'Event Title';

  @override
  String get create_edit_event_screen_event_title_error_empty =>
      'Event title cannot be empty.';

  @override
  String get create_edit_event_screen_event_title_error_too_long =>
      'Event title cannot exceed 50 characters.';

  @override
  String get create_edit_event_screen_event_sign_up_from => 'Sign-up from';

  @override
  String get create_edit_event_screen_event_sign_up_to => 'Sign-up to';

  @override
  String get create_edit_event_screen_event_from_hint => 'From';

  @override
  String get create_edit_event_screen_event_to_hint => 'To';

  @override
  String get create_edit_event_screen_select_participants_text =>
      'Select Participants';

  @override
  String get create_edit_participants_screen_title => 'Select Participants';

  @override
  String get create_edit_participants_screen_leaders => 'Leaders';

  @override
  String get create_edit_participants_screen_kids => 'Kids';

  @override
  String get create_edit_participants_screen_select_all => 'Select All';

  @override
  String get create_edit_participants_screen_dial_print => 'Print List';

  @override
  String get create_edit_participants_screen_dial_limit => 'Participant Limit';

  @override
  String get create_edit_event_screen_total_participants_text =>
      'Invited Participants';

  @override
  String get create_edit_event_screen_total_signed_up_participants_text =>
      'Signed Up Participants';

  @override
  String get create_edit_event_screen_signed_up_leaders => 'Signed up leaders';

  @override
  String get create_edit_event_screen_invited_leaders => 'Invited leaders';

  @override
  String get create_edit_event_screen_signed_up_18_plus => 'Signed up 18+';

  @override
  String get create_edit_event_screen_invited_18_plus => 'Invited 18+';

  @override
  String get create_edit_event_screen_troops => 'Troops';

  @override
  String get create_edit_event_screen_instructions_text => 'Instructions';

  @override
  String get create_edit_instructions_screen_title => 'Event Instructions';

  @override
  String get create_edit_event_screen_meeting_place_text => 'Meeting Place';

  @override
  String get create_edit_event_screen_meeting_place_description =>
      'Address or name that the user can search for in maps. If you do not fill it in, the meeting place will not be displayed.';

  @override
  String get create_edit_event_screen_photo_album_link_text =>
      'Photo Album Link';

  @override
  String get create_edit_event_screen_photo_album_link_description =>
      'Link to the shared photo album from the event. If you do not fill it in, the photo album link will not be displayed.';

  @override
  String get create_edit_event_screen_validation_error_title_empty =>
      'Please enter an event title.';

  @override
  String get create_edit_event_screen_validation_error_dates_empty =>
      'Please fill in all date fields.';

  @override
  String get create_edit_event_screen_validation_error_signup_start_after_end =>
      'Sign-up start must be before sign-up end.';

  @override
  String get create_edit_event_screen_validation_error_signup_end_after_start =>
      'Sign-up must end before the event starts.';

  @override
  String get create_edit_event_screen_validation_error_start_after_end =>
      'Event start must be before event end.';

  @override
  String get create_edit_event_screen_creating_event_progress_text =>
      'Creating event...';

  @override
  String get create_edit_event_screen_editing_event_progress_text =>
      'Editing event...';

  @override
  String get create_edit_event_screen_deleting_event_progress_text =>
      'Deleting event...';

  @override
  String get create_edit_event_screen_creating_event_success =>
      'Event was successfully created🥳.';

  @override
  String get create_edit_event_screen_creating_event_error_generic =>
      'Failed to create event. Please try again.';

  @override
  String get create_edit_event_screen_save_success =>
      'Event was successfully saved🥳.';

  @override
  String get create_edit_event_screen_save_error_generic =>
      'Failed to save event. Please try again.';

  @override
  String get category_live_events_screen => '--- LIVE EVENTS ---';

  @override
  String get live_events_screen_no_dependents_view_subtitle =>
      'It seems that you currently have no persons who could sign up for events.';

  @override
  String live_events_screen_no_live_events_view_subtitle(
    String dependent_name,
  ) {
    return 'Person $dependent_name currently has no events to sign up for.';
  }

  @override
  String get live_events_screen_change_dependent_status_dialog_title =>
      'Change Participation Status';

  @override
  String live_events_screen_change_dependent_status_dialog_description(
    String dependent_name,
    String event_name,
  ) {
    return 'Change participation status of person $dependent_name for event $event_name.';
  }

  @override
  String get live_events_screen_change_dependent_status_dialog_no_response =>
      'No Response';

  @override
  String get live_events_screen_change_dependent_status_dialog_signed_up =>
      'Sign Up';

  @override
  String get live_events_screen_change_dependent_status_dialog_excused =>
      'Excuse';

  @override
  String get live_events_screen_change_dependent_status_dialog_loading =>
      'Changing participation status...';

  @override
  String get live_events_screen_change_dependent_status_dialog_error =>
      'Failed to change participation status. Please try again.';

  @override
  String live_events_screen_change_dependent_status_dialog_success(
    String dependent_name,
    String new_status,
  ) {
    return 'The status of $dependent_name was successfully changed to $new_status.';
  }

  @override
  String get live_events_screen_cannot_change_status_past_signup_deadline =>
      'Cannot change participation status for an event after the signup deadline has passed.';

  @override
  String get category_settings_screen => '--- SETTINGS SCREEN ---';

  @override
  String get settings_screen_title => 'Settings';

  @override
  String get settings_screen_change_signout_button_text => 'Sign Out';

  @override
  String get settings_screen_change_delete_account_button_text =>
      'Delete Account';
}
