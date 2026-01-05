import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In cs, this message translates to:
  /// **'Čeština'**
  String get language;

  /// No description provided for @category_common.
  ///
  /// In cs, this message translates to:
  /// **'--- SPOLEČNÉ ---'**
  String get category_common;

  /// No description provided for @yes.
  ///
  /// In cs, this message translates to:
  /// **'Ano'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In cs, this message translates to:
  /// **'Ne'**
  String get no;

  /// No description provided for @cancel.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit'**
  String get cancel;

  /// No description provided for @loading.
  ///
  /// In cs, this message translates to:
  /// **'Načítání...'**
  String get loading;

  /// No description provided for @back.
  ///
  /// In cs, this message translates to:
  /// **'Zpět'**
  String get back;

  /// No description provided for @common_copied_to_clipboard.
  ///
  /// In cs, this message translates to:
  /// **'Zkopírováno do schránky 📋'**
  String get common_copied_to_clipboard;

  /// No description provided for @create.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořit'**
  String get create;

  /// No description provided for @edit.
  ///
  /// In cs, this message translates to:
  /// **'Upravit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In cs, this message translates to:
  /// **'Uložit'**
  String get save;

  /// No description provided for @load_more.
  ///
  /// In cs, this message translates to:
  /// **'Načíst další'**
  String get load_more;

  /// No description provided for @error.
  ///
  /// In cs, this message translates to:
  /// **'Chyba'**
  String get error;

  /// No description provided for @generic_error.
  ///
  /// In cs, this message translates to:
  /// **'Něco se pokazilo. Zkus to prosím znovu.'**
  String get generic_error;

  /// No description provided for @something_is_missing_title_1.
  ///
  /// In cs, this message translates to:
  /// **'Ticho po pěšině... 🤫'**
  String get something_is_missing_title_1;

  /// No description provided for @something_is_missing_title_2.
  ///
  /// In cs, this message translates to:
  /// **'Kde nic, tu nic... 🤷‍♂️'**
  String get something_is_missing_title_2;

  /// No description provided for @something_is_missing_title_3.
  ///
  /// In cs, this message translates to:
  /// **'Tady chcípl pes... 🐕'**
  String get something_is_missing_title_3;

  /// No description provided for @something_is_missing_title_4.
  ///
  /// In cs, this message translates to:
  /// **'Pusto a prázdno... 🏜️'**
  String get something_is_missing_title_4;

  /// No description provided for @something_is_missing_title_5.
  ///
  /// In cs, this message translates to:
  /// **'Vymeteno... 🧹'**
  String get something_is_missing_title_5;

  /// No description provided for @something_is_missing_title_6.
  ///
  /// In cs, this message translates to:
  /// **'Ani noha... 👣'**
  String get something_is_missing_title_6;

  /// No description provided for @something_is_missing_title_7.
  ///
  /// In cs, this message translates to:
  /// **'Široko daleko ani živáčka... 🔭'**
  String get something_is_missing_title_7;

  /// No description provided for @something_is_missing_title_8.
  ///
  /// In cs, this message translates to:
  /// **'Tady lišky dávají dobrou noc... 🦊'**
  String get something_is_missing_title_8;

  /// No description provided for @something_is_missing_title_9.
  ///
  /// In cs, this message translates to:
  /// **'Pusto prázdno... 🕳️'**
  String get something_is_missing_title_9;

  /// No description provided for @something_is_missing_title_10.
  ///
  /// In cs, this message translates to:
  /// **'Zeje to tu prázdnotou... 💨'**
  String get something_is_missing_title_10;

  /// No description provided for @category_navigation.
  ///
  /// In cs, this message translates to:
  /// **'--- NAVIGACE ---'**
  String get category_navigation;

  /// No description provided for @navbar_dependents.
  ///
  /// In cs, this message translates to:
  /// **'Osoby'**
  String get navbar_dependents;

  /// No description provided for @navbar_events.
  ///
  /// In cs, this message translates to:
  /// **'Výpravy'**
  String get navbar_events;

  /// No description provided for @navbar_calendar.
  ///
  /// In cs, this message translates to:
  /// **'Kalendář'**
  String get navbar_calendar;

  /// No description provided for @navbar_info.
  ///
  /// In cs, this message translates to:
  /// **'Informace'**
  String get navbar_info;

  /// No description provided for @category_welcome_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- UVÍTACÍ OBRAZOVKA ---'**
  String get category_welcome_screen;

  /// No description provided for @welcome_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Vítej ve\nSkapce 👋'**
  String get welcome_screen_title;

  /// No description provided for @welcome_screen_login_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit se'**
  String get welcome_screen_login_button_text;

  /// No description provided for @welcome_screen_register_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Registrovat se'**
  String get welcome_screen_register_button_text;

  /// No description provided for @welcome_screen_songbook_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Zpěvník'**
  String get welcome_screen_songbook_button_text;

  /// No description provided for @category_login_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- PŘIHLÁŠENÍ ---'**
  String get category_login_screen;

  /// No description provided for @login_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení'**
  String get login_screen_title;

  /// No description provided for @login_screen_email_hint.
  ///
  /// In cs, this message translates to:
  /// **'E-mail'**
  String get login_screen_email_hint;

  /// No description provided for @login_screen_password_hint.
  ///
  /// In cs, this message translates to:
  /// **'Heslo'**
  String get login_screen_password_hint;

  /// No description provided for @login_screen_forgot_password_text.
  ///
  /// In cs, this message translates to:
  /// **'Zapomněl si heslo?'**
  String get login_screen_forgot_password_text;

  /// No description provided for @login_screen_login_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit se'**
  String get login_screen_login_button_text;

  /// No description provided for @login_screen_login_error_password_empty.
  ///
  /// In cs, this message translates to:
  /// **'Nezapomeň na heslo.'**
  String get login_screen_login_error_password_empty;

  /// No description provided for @login_screen_login_error_password_too_short.
  ///
  /// In cs, this message translates to:
  /// **'Heslo musí mít alespoň 8 znaků.'**
  String get login_screen_login_error_password_too_short;

  /// No description provided for @login_screen_login_error_invalid_credentials.
  ///
  /// In cs, this message translates to:
  /// **'Neplatné přihlašovací údaje.'**
  String get login_screen_login_error_invalid_credentials;

  /// No description provided for @login_screen_login_error_email_not_confirmed.
  ///
  /// In cs, this message translates to:
  /// **'E-mailová adresa není potvrzena. Zkontroluj prosím svou schránku.'**
  String get login_screen_login_error_email_not_confirmed;

  /// No description provided for @login_screen_login_error_email_empty.
  ///
  /// In cs, this message translates to:
  /// **'Nezapomněl/a si na email?'**
  String get login_screen_login_error_email_empty;

  /// No description provided for @login_screen_login_error_email_invalid.
  ///
  /// In cs, this message translates to:
  /// **'Pozor, takhle přece nevypadá e-mail.'**
  String get login_screen_login_error_email_invalid;

  /// No description provided for @login_screen_login_success.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení proběhlo úspěšně! 🎉'**
  String get login_screen_login_success;

  /// No description provided for @login_screen_login_error_generic.
  ///
  /// In cs, this message translates to:
  /// **'Něco se nepovedlo. Zkus to prosím znovu.'**
  String get login_screen_login_error_generic;

  /// No description provided for @category_register_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- REGISTRACE ---'**
  String get category_register_screen;

  /// No description provided for @register_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Registrace'**
  String get register_screen_title;

  /// No description provided for @register_screen_1_name_hint.
  ///
  /// In cs, this message translates to:
  /// **'Jméno'**
  String get register_screen_1_name_hint;

  /// No description provided for @register_screen_1_surname_hint.
  ///
  /// In cs, this message translates to:
  /// **'Příjmení'**
  String get register_screen_1_surname_hint;

  /// No description provided for @register_screen_1_email_hint.
  ///
  /// In cs, this message translates to:
  /// **'E-mail'**
  String get register_screen_1_email_hint;

  /// No description provided for @register_screen_1_next_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Další'**
  String get register_screen_1_next_button_text;

  /// No description provided for @register_screen_1_error_invalid_name.
  ///
  /// In cs, this message translates to:
  /// **'Jméno může obsahovat jen písmena a pomlčky.'**
  String get register_screen_1_error_invalid_name;

  /// No description provided for @register_screen_1_error_empty_name.
  ///
  /// In cs, this message translates to:
  /// **'Nemáš snad jméno?'**
  String get register_screen_1_error_empty_name;

  /// No description provided for @register_screen_1_error_invalid_surname.
  ///
  /// In cs, this message translates to:
  /// **'Příjmení může obsahovat jen písmena a pomlčky.'**
  String get register_screen_1_error_invalid_surname;

  /// No description provided for @register_screen_1_error_empty_surname.
  ///
  /// In cs, this message translates to:
  /// **'A co příjmení?'**
  String get register_screen_1_error_empty_surname;

  /// No description provided for @register_screen_1_error_email_empty.
  ///
  /// In cs, this message translates to:
  /// **'Nezapomněl/a si na email?'**
  String get register_screen_1_error_email_empty;

  /// No description provided for @register_screen_1_error_email_invalid.
  ///
  /// In cs, this message translates to:
  /// **'Pozor, takhle přece nevypadá e-mail.'**
  String get register_screen_1_error_email_invalid;

  /// No description provided for @register_screen_2_password_hint.
  ///
  /// In cs, this message translates to:
  /// **'Heslo'**
  String get register_screen_2_password_hint;

  /// No description provided for @register_screen_2_confirm_password_hint.
  ///
  /// In cs, this message translates to:
  /// **'Potvrď heslo'**
  String get register_screen_2_confirm_password_hint;

  /// No description provided for @register_screen_2_register_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Registrovat'**
  String get register_screen_2_register_button_text;

  /// No description provided for @register_screen_2_error_passwords_do_not_match.
  ///
  /// In cs, this message translates to:
  /// **'Hesla se neshodují.'**
  String get register_screen_2_error_passwords_do_not_match;

  /// No description provided for @register_screen_2_registration_success.
  ///
  /// In cs, this message translates to:
  /// **'Registrace proběhla úspěšně! 🎊'**
  String get register_screen_2_registration_success;

  /// No description provided for @register_screen_2_registration_error_email_used.
  ///
  /// In cs, this message translates to:
  /// **'Tento e-mail je již použit. Zkus se přihlásit nebo použij jiný e-mail.'**
  String get register_screen_2_registration_error_email_used;

  /// No description provided for @register_screen_2_registration_error_rate_limit.
  ///
  /// In cs, this message translates to:
  /// **'Příliš mnoho pokusů. Zkus to prosím později.'**
  String get register_screen_2_registration_error_rate_limit;

  /// No description provided for @register_screen_2_registration_error_weak_password.
  ///
  /// In cs, this message translates to:
  /// **'Heslo je příliš slabé.'**
  String get register_screen_2_registration_error_weak_password;

  /// No description provided for @register_screen_2_registration_error_generic.
  ///
  /// In cs, this message translates to:
  /// **'Registrace se nezdařila. Zkus to prosím znovu.'**
  String get register_screen_2_registration_error_generic;

  /// No description provided for @category_account_not_approved_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- OBRAZOVKA NESCHVÁLENÉHO ÚČTU ---'**
  String get category_account_not_approved_screen;

  /// No description provided for @account_not_approved_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Účet ještě nebyl schválen'**
  String get account_not_approved_screen_title;

  /// No description provided for @account_not_approved_screen_text.
  ///
  /// In cs, this message translates to:
  /// **'Administrátor musí tvůj účet{name_surname}nejdřív schválit, než se budeš moct přihlásit. Jakmile to udělá, přijde ti e-mail.'**
  String account_not_approved_screen_text(String name_surname);

  /// No description provided for @account_not_approved_screen_notify_administrator_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Upozornit administrátora'**
  String get account_not_approved_screen_notify_administrator_button_text;

  /// No description provided for @account_not_approved_screen_notify_administrator_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Upozornit administrátora'**
  String get account_not_approved_screen_notify_administrator_dialog_title;

  /// No description provided for @account_not_approved_screen_notify_administrator_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Tento krok upozorní administrátora emailem. Lze poslat jednou za den.'**
  String
  get account_not_approved_screen_notify_administrator_dialog_description;

  /// No description provided for @account_not_approved_screen_notify_administrator_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Poslat upozornění'**
  String
  get account_not_approved_screen_notify_administrator_dialog_primary_button_text;

  /// No description provided for @account_not_approved_screen_notify_administrator_button_error_dialog.
  ///
  /// In cs, this message translates to:
  /// **'Upozornění lze poslat jen jednou za 24 hodin. Zkus to později.'**
  String
  get account_not_approved_screen_notify_administrator_button_error_dialog;

  /// No description provided for @account_not_approved_screen_notify_success.
  ///
  /// In cs, this message translates to:
  /// **'Administrátor byl upozorněn. 📧'**
  String get account_not_approved_screen_notify_success;

  /// No description provided for @account_not_approved_screen_notify_error.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se upozornit administrátora. Zkus to prosím později.'**
  String get account_not_approved_screen_notify_error;

  /// No description provided for @account_not_approved_screen_logout_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get account_not_approved_screen_logout_button_text;

  /// No description provided for @account_not_approved_screen_logout_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get account_not_approved_screen_logout_dialog_title;

  /// No description provided for @account_not_approved_screen_logout_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu se chceš odhlásit ze svého účtu?'**
  String get account_not_approved_screen_logout_dialog_description;

  /// No description provided for @account_not_approved_screen_logout_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get account_not_approved_screen_logout_dialog_primary_button_text;

  /// No description provided for @account_not_approved_screen_logout_success.
  ///
  /// In cs, this message translates to:
  /// **'Odhlášení proběhlo úspěšně.'**
  String get account_not_approved_screen_logout_success;

  /// No description provided for @account_not_approved_screen_logout_error.
  ///
  /// In cs, this message translates to:
  /// **'Odhlášení se nezdařilo. Zkus to prosím znovu.'**
  String get account_not_approved_screen_logout_error;

  /// No description provided for @account_not_approved_screen_delete_account_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Smazat účet'**
  String get account_not_approved_screen_delete_account_button_text;

  /// No description provided for @account_not_approved_screen_delete_account_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Smazat účet'**
  String get account_not_approved_screen_delete_account_dialog_title;

  /// No description provided for @account_not_approved_screen_delete_account_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš smazat svůj účet? Tuto akci nelze vrátit zpět.'**
  String get account_not_approved_screen_delete_account_dialog_description;

  /// No description provided for @account_not_approved_screen_delete_account_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Smazat účet'**
  String
  get account_not_approved_screen_delete_account_dialog_primary_button_text;

  /// No description provided for @account_not_approved_screen_delete_success.
  ///
  /// In cs, this message translates to:
  /// **'Tvůj účet byl smazán. 👋'**
  String get account_not_approved_screen_delete_success;

  /// No description provided for @account_not_approved_screen_delete_error.
  ///
  /// In cs, this message translates to:
  /// **'Smazání účtu se nezdařilo. Zkus to prosím později.'**
  String get account_not_approved_screen_delete_error;

  /// No description provided for @category_events_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- VÝPRAVY ---'**
  String get category_events_screen;

  /// No description provided for @events_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Výpravy'**
  String get events_screen_title;

  /// No description provided for @events_screen_no_events_text.
  ///
  /// In cs, this message translates to:
  /// **'{username} aktuálně nemá žádnou aktivní výpravu.'**
  String events_screen_no_events_text(String version, Object username);

  /// No description provided for @category_event_box_widget.
  ///
  /// In cs, this message translates to:
  /// **'--- WIDGET VÝPRAVY ---'**
  String get category_event_box_widget;

  /// No description provided for @event_box_number_of_kids_text.
  ///
  /// In cs, this message translates to:
  /// **'{number_of_kids} dětí'**
  String event_box_number_of_kids_text(int number_of_kids);

  /// No description provided for @event_box_photos_link_text.
  ///
  /// In cs, this message translates to:
  /// **'Fotky'**
  String get event_box_photos_link_text;

  /// No description provided for @event_box_sign_up_start_date_text.
  ///
  /// In cs, this message translates to:
  /// **'Přihlašování od: '**
  String get event_box_sign_up_start_date_text;

  /// No description provided for @event_box_sign_up_end_date_text.
  ///
  /// In cs, this message translates to:
  /// **'Přihlašování do: '**
  String get event_box_sign_up_end_date_text;

  /// No description provided for @event_box_event_multiple_days_start_text.
  ///
  /// In cs, this message translates to:
  /// **'Od: '**
  String get event_box_event_multiple_days_start_text;

  /// No description provided for @event_box_event_multiple_days_end_text.
  ///
  /// In cs, this message translates to:
  /// **'Do: '**
  String get event_box_event_multiple_days_end_text;

  /// No description provided for @event_box_event_single_day_text.
  ///
  /// In cs, this message translates to:
  /// **'Kdy: '**
  String get event_box_event_single_day_text;

  /// No description provided for @event_box_target_patrols_text.
  ///
  /// In cs, this message translates to:
  /// **'Družinky: '**
  String get event_box_target_patrols_text;

  /// No description provided for @event_box_open_error_event_not_live.
  ///
  /// In cs, this message translates to:
  /// **'Nelze zobrazit detail výpravy, na kterou se nelze přihlašovat.'**
  String get event_box_open_error_event_not_live;

  /// No description provided for @category_calendar_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- KALENDÁŘ ---'**
  String get category_calendar_screen;

  /// No description provided for @calendar_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Kalendář'**
  String get calendar_screen_title;

  /// No description provided for @calendar_screen_speed_dial_add_google_calendar.
  ///
  /// In cs, this message translates to:
  /// **'Google kalendář'**
  String get calendar_screen_speed_dial_add_google_calendar;

  /// No description provided for @calendar_screen_event_expansion_tile_future_title.
  ///
  /// In cs, this message translates to:
  /// **'Nadcházející'**
  String get calendar_screen_event_expansion_tile_future_title;

  /// No description provided for @calendar_screen_event_expansion_tile_future_no_events_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zdá se, že nejsou žádné nadcházející výpravy.'**
  String get calendar_screen_event_expansion_tile_future_no_events_subtitle;

  /// No description provided for @calendar_screen_event_expansion_tile_live_title.
  ///
  /// In cs, this message translates to:
  /// **'Aktuální'**
  String get calendar_screen_event_expansion_tile_live_title;

  /// No description provided for @calendar_screen_event_expansion_tile_live_no_events_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zdá se, že nejsou žádné aktuální výpravy.'**
  String get calendar_screen_event_expansion_tile_live_no_events_subtitle;

  /// No description provided for @calendar_screen_event_expansion_tile_past_title.
  ///
  /// In cs, this message translates to:
  /// **'Proběhlé'**
  String get calendar_screen_event_expansion_tile_past_title;

  /// No description provided for @calendar_screen_event_expansion_tile_past_no_events_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zdá se, že nejsou žádné proběhlé výpravy.'**
  String get calendar_screen_event_expansion_tile_past_no_events_subtitle;

  /// No description provided for @calendar_screen_event_expansion_tile_draft_title.
  ///
  /// In cs, this message translates to:
  /// **'Koncepty'**
  String get calendar_screen_event_expansion_tile_draft_title;

  /// No description provided for @calendar_screen_event_expansion_tile_draft_no_events_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zdá se, že nejsou žádné koncepty.'**
  String get calendar_screen_event_expansion_tile_draft_no_events_subtitle;

  /// No description provided for @category_create_edit_event_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- VYTVOŘIT/UPRAVIT VÝPRAVU ---'**
  String get category_create_edit_event_screen;

  /// No description provided for @create_edit_event_screen_title_create.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořit výpravu'**
  String get create_edit_event_screen_title_create;

  /// No description provided for @create_edit_event_screen_title_edit.
  ///
  /// In cs, this message translates to:
  /// **'Upravit výpravu'**
  String get create_edit_event_screen_title_edit;

  /// No description provided for @create_edit_event_screen_save_event_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Uložit jako koncept'**
  String get create_edit_event_screen_save_event_dialog_title;

  /// No description provided for @create_edit_event_screen_save_event_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Chceš uložit tuto výpravu jako koncept? Výprava se zveřejní až po kliknutí na tlačítko zveřejnit. Můžeš ji upravit později.'**
  String get create_edit_event_screen_save_event_dialog_description;

  /// No description provided for @create_edit_event_screen_save_event_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Uložit jako koncept'**
  String get create_edit_event_screen_save_event_dialog_primary_button_text;

  /// No description provided for @create_edit_event_screen_save_changes_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Uložit změny'**
  String get create_edit_event_screen_save_changes_dialog_title;

  /// No description provided for @create_edit_event_screen_save_changes_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš uložit změny v této výpravě?'**
  String get create_edit_event_screen_save_changes_dialog_description;

  /// No description provided for @create_edit_event_screen_speed_dial_publish_event_text.
  ///
  /// In cs, this message translates to:
  /// **'Zveřejnit'**
  String get create_edit_event_screen_speed_dial_publish_event_text;

  /// No description provided for @create_edit_event_screen_publish_event_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Zveřejnit výpravu'**
  String get create_edit_event_screen_publish_event_dialog_title;

  /// No description provided for @create_edit_event_screen_publish_event_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš zveřejnit tuto výpravu? Výprava se přidá do kalendáře a až nadejde čas přihlašování, budou se moct pozvaní účastníci přihlašovat.'**
  String get create_edit_event_screen_publish_event_dialog_description;

  /// No description provided for @create_edit_event_screen_publish_event_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Zveřejnit'**
  String get create_edit_event_screen_publish_event_dialog_primary_button_text;

  /// No description provided for @create_edit_event_screen_speed_dial_unpublish_event_text.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit zveřejnění'**
  String get create_edit_event_screen_speed_dial_unpublish_event_text;

  /// No description provided for @create_edit_event_screen_unpublish_event_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit zveřejnění výpravy'**
  String get create_edit_event_screen_unpublish_event_dialog_title;

  /// No description provided for @create_edit_event_screen_unpublish_event_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš zrušit zveřejnění této výpravy? Účastníci se nebudou moct dál přihlašovat a výprava se odstraní z kalendáře.'**
  String get create_edit_event_screen_unpublish_event_dialog_description;

  /// No description provided for @create_edit_event_screen_unpublish_event_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit zveřejnění'**
  String
  get create_edit_event_screen_unpublish_event_dialog_primary_button_text;

  /// No description provided for @create_edit_event_screen_speed_dial_delete_event_text.
  ///
  /// In cs, this message translates to:
  /// **'Smazat'**
  String get create_edit_event_screen_speed_dial_delete_event_text;

  /// No description provided for @create_edit_event_screen_delete_event_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Smazat výpravu'**
  String get create_edit_event_screen_delete_event_dialog_title;

  /// No description provided for @create_edit_event_screen_delete_event_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš smazat tuto výpravu? Tuto akci nelze vrátit zpět.'**
  String get create_edit_event_screen_delete_event_dialog_description;

  /// No description provided for @create_edit_event_screen_delete_event_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Smazat'**
  String get create_edit_event_screen_delete_event_dialog_primary_button_text;

  /// No description provided for @create_edit_event_screen_delete_event_error_past_event_admin_only.
  ///
  /// In cs, this message translates to:
  /// **'Pouze administrátoři mohou mazat nebo zrušit publikování minulých výprav.'**
  String get create_edit_event_screen_delete_event_error_past_event_admin_only;

  /// No description provided for @create_edit_event_screen_delete_event_error_event_not_created.
  ///
  /// In cs, this message translates to:
  /// **'Nelze smazat výpravu, která ještě nebyla vytvořena.'**
  String get create_edit_event_screen_delete_event_error_event_not_created;

  /// No description provided for @create_edit_event_screen_delete_event_error_not_rights.
  ///
  /// In cs, this message translates to:
  /// **'Nemáš oprávnění mazat výpravy.'**
  String get create_edit_event_screen_delete_event_error_not_rights;

  /// No description provided for @create_edit_event_screen_delete_event_error_generic.
  ///
  /// In cs, this message translates to:
  /// **'Smazání výpravy se nezdařilo. Zkus to prosím znovu.'**
  String get create_edit_event_screen_delete_event_error_generic;

  /// No description provided for @create_edit_event_screen_delete_event_success.
  ///
  /// In cs, this message translates to:
  /// **'Výprava byla úspěšně smazána🥳.'**
  String get create_edit_event_screen_delete_event_success;

  /// No description provided for @create_edit_event_screen_go_back_without_saving_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Zahodit změny'**
  String get create_edit_event_screen_go_back_without_saving_dialog_title;

  /// No description provided for @create_edit_event_screen_go_back_without_saving_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chceš odejít bez uložení změn? Veškeré neuložené změny budou ztraceny.'**
  String get create_edit_event_screen_go_back_without_saving_dialog_description;

  /// No description provided for @create_edit_event_screen_go_back_without_saving_dialog_primary_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Zahodit'**
  String
  get create_edit_event_screen_go_back_without_saving_dialog_primary_button_text;

  /// No description provided for @create_edit_event_screen_event_title_hint.
  ///
  /// In cs, this message translates to:
  /// **'Název výpravy'**
  String get create_edit_event_screen_event_title_hint;

  /// No description provided for @create_edit_event_screen_event_title_error_empty.
  ///
  /// In cs, this message translates to:
  /// **'Název výpravy nemůže být prázdný.'**
  String get create_edit_event_screen_event_title_error_empty;

  /// No description provided for @create_edit_event_screen_event_title_error_too_long.
  ///
  /// In cs, this message translates to:
  /// **'Název výpravy nemůže přesáhnout 50 znaků.'**
  String get create_edit_event_screen_event_title_error_too_long;

  /// No description provided for @create_edit_event_screen_event_sign_up_from.
  ///
  /// In cs, this message translates to:
  /// **'Přihlašování od'**
  String get create_edit_event_screen_event_sign_up_from;

  /// No description provided for @create_edit_event_screen_event_sign_up_to.
  ///
  /// In cs, this message translates to:
  /// **'Přihlašování do'**
  String get create_edit_event_screen_event_sign_up_to;

  /// No description provided for @create_edit_event_screen_event_from_hint.
  ///
  /// In cs, this message translates to:
  /// **'Od'**
  String get create_edit_event_screen_event_from_hint;

  /// No description provided for @create_edit_event_screen_event_to_hint.
  ///
  /// In cs, this message translates to:
  /// **'Do'**
  String get create_edit_event_screen_event_to_hint;

  /// No description provided for @create_edit_event_screen_select_participants_text.
  ///
  /// In cs, this message translates to:
  /// **'Vybrat účastníky'**
  String get create_edit_event_screen_select_participants_text;

  /// No description provided for @create_edit_participants_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Vybrat účastníky'**
  String get create_edit_participants_screen_title;

  /// No description provided for @create_edit_participants_screen_leaders.
  ///
  /// In cs, this message translates to:
  /// **'Vedoucí'**
  String get create_edit_participants_screen_leaders;

  /// No description provided for @create_edit_participants_screen_kids.
  ///
  /// In cs, this message translates to:
  /// **'Děti'**
  String get create_edit_participants_screen_kids;

  /// No description provided for @create_edit_participants_screen_select_all.
  ///
  /// In cs, this message translates to:
  /// **'Vybrat všechny'**
  String get create_edit_participants_screen_select_all;

  /// No description provided for @create_edit_participants_screen_dial_print.
  ///
  /// In cs, this message translates to:
  /// **'Vytisknout seznam'**
  String get create_edit_participants_screen_dial_print;

  /// No description provided for @create_edit_participants_screen_dial_limit.
  ///
  /// In cs, this message translates to:
  /// **'Limit účastníků'**
  String get create_edit_participants_screen_dial_limit;

  /// No description provided for @create_edit_event_screen_total_participants_text.
  ///
  /// In cs, this message translates to:
  /// **'Pozvaní účastníci'**
  String get create_edit_event_screen_total_participants_text;

  /// No description provided for @create_edit_event_screen_total_signed_up_participants_text.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení účastníci'**
  String get create_edit_event_screen_total_signed_up_participants_text;

  /// No description provided for @create_edit_event_screen_signed_up_leaders.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení vedoucí'**
  String get create_edit_event_screen_signed_up_leaders;

  /// No description provided for @create_edit_event_screen_invited_leaders.
  ///
  /// In cs, this message translates to:
  /// **'Pozvaní vedoucí'**
  String get create_edit_event_screen_invited_leaders;

  /// No description provided for @create_edit_event_screen_signed_up_18_plus.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení 18+'**
  String get create_edit_event_screen_signed_up_18_plus;

  /// No description provided for @create_edit_event_screen_invited_18_plus.
  ///
  /// In cs, this message translates to:
  /// **'Pozvaní 18+'**
  String get create_edit_event_screen_invited_18_plus;

  /// No description provided for @create_edit_event_screen_troops.
  ///
  /// In cs, this message translates to:
  /// **'Družinky'**
  String get create_edit_event_screen_troops;

  /// No description provided for @create_edit_event_screen_instructions_text.
  ///
  /// In cs, this message translates to:
  /// **'Pokyny'**
  String get create_edit_event_screen_instructions_text;

  /// No description provided for @create_edit_instructions_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Pokyny výpravy'**
  String get create_edit_instructions_screen_title;

  /// No description provided for @create_edit_event_screen_instructions_hint.
  ///
  /// In cs, this message translates to:
  /// **'Sem napiš pokyny (Markdown podporován)...'**
  String get create_edit_event_screen_instructions_hint;

  /// No description provided for @create_edit_event_screen_meeting_place_text.
  ///
  /// In cs, this message translates to:
  /// **'Místo srazu'**
  String get create_edit_event_screen_meeting_place_text;

  /// No description provided for @create_edit_event_screen_meeting_place_description.
  ///
  /// In cs, this message translates to:
  /// **'Adresa či jméno, které může uživatel vyhledat v mapách. Pokud nevyplníš, místo srazu nebude zobrazeno.'**
  String get create_edit_event_screen_meeting_place_description;

  /// No description provided for @create_edit_event_screen_photo_album_link_text.
  ///
  /// In cs, this message translates to:
  /// **'Odkaz na fotoalbum'**
  String get create_edit_event_screen_photo_album_link_text;

  /// No description provided for @create_edit_event_screen_photo_album_link_description.
  ///
  /// In cs, this message translates to:
  /// **'Odkaz na sdílenené fotoalbum z výpravy. Pokud nevyplníš, odkaz na fotoalbum nebude zobrazen.'**
  String get create_edit_event_screen_photo_album_link_description;

  /// No description provided for @create_edit_event_screen_validation_error_title_empty.
  ///
  /// In cs, this message translates to:
  /// **'Prosím zadej název výpravy.'**
  String get create_edit_event_screen_validation_error_title_empty;

  /// No description provided for @create_edit_event_screen_validation_error_dates_empty.
  ///
  /// In cs, this message translates to:
  /// **'Prosím vyplň všechna data.'**
  String get create_edit_event_screen_validation_error_dates_empty;

  /// No description provided for @create_edit_event_screen_validation_error_signup_start_after_end.
  ///
  /// In cs, this message translates to:
  /// **'Začátek přihlašování musí být před koncem přihlašování.'**
  String get create_edit_event_screen_validation_error_signup_start_after_end;

  /// No description provided for @create_edit_event_screen_validation_error_signup_end_after_start.
  ///
  /// In cs, this message translates to:
  /// **'Konec přihlašování musí být před začátkem výpravy.'**
  String get create_edit_event_screen_validation_error_signup_end_after_start;

  /// No description provided for @create_edit_event_screen_validation_error_start_after_end.
  ///
  /// In cs, this message translates to:
  /// **'Začátek výpravy musí být před koncem výpravy.'**
  String get create_edit_event_screen_validation_error_start_after_end;

  /// No description provided for @create_edit_event_screen_creating_event_progress_text.
  ///
  /// In cs, this message translates to:
  /// **'Vytvářím výpravu...'**
  String get create_edit_event_screen_creating_event_progress_text;

  /// No description provided for @create_edit_event_screen_editing_event_progress_text.
  ///
  /// In cs, this message translates to:
  /// **'Upravuji výpravu...'**
  String get create_edit_event_screen_editing_event_progress_text;

  /// No description provided for @create_edit_event_screen_deleting_event_progress_text.
  ///
  /// In cs, this message translates to:
  /// **'Mažu výprava...'**
  String get create_edit_event_screen_deleting_event_progress_text;

  /// No description provided for @create_edit_event_screen_creating_event_success.
  ///
  /// In cs, this message translates to:
  /// **'Výprava byla úspěšně vytvořena🥳.'**
  String get create_edit_event_screen_creating_event_success;

  /// No description provided for @create_edit_event_screen_creating_event_error_generic.
  ///
  /// In cs, this message translates to:
  /// **'Vytvoření výpravy se nezdařilo. Zkus to prosím znovu.'**
  String get create_edit_event_screen_creating_event_error_generic;

  /// No description provided for @create_edit_event_screen_save_success.
  ///
  /// In cs, this message translates to:
  /// **'Výprava byla úspěšně uložena🥳.'**
  String get create_edit_event_screen_save_success;

  /// No description provided for @create_edit_event_screen_save_error_generic.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se uložit výpravu. Zkus to prosím znovu.'**
  String get create_edit_event_screen_save_error_generic;

  /// No description provided for @category_live_events_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- PŘIHLAŠOVACÍ VÝPRAVY ---'**
  String get category_live_events_screen;

  /// No description provided for @live_events_screen_no_dependents_view_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zdá se, že momentálně nemáš žádné osoby, které by se mohly přihlašovat na výpravy.'**
  String get live_events_screen_no_dependents_view_subtitle;

  /// No description provided for @live_events_screen_no_live_events_view_subtitle.
  ///
  /// In cs, this message translates to:
  /// **'Osoba {dependent_name} momentálně nemá žádné výpravy k přihlášení.'**
  String live_events_screen_no_live_events_view_subtitle(String dependent_name);

  /// No description provided for @live_events_screen_change_dependent_status_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Změnit stav účasti'**
  String get live_events_screen_change_dependent_status_dialog_title;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Změnit stav účasti osoby {dependent_name} na výpravě {event_name}.'**
  String live_events_screen_change_dependent_status_dialog_description(
    String dependent_name,
    String event_name,
  );

  /// No description provided for @live_events_screen_change_dependent_status_dialog_no_response.
  ///
  /// In cs, this message translates to:
  /// **'Bez odpovědi'**
  String get live_events_screen_change_dependent_status_dialog_no_response;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_signed_up.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit'**
  String get live_events_screen_change_dependent_status_dialog_signed_up;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_excused.
  ///
  /// In cs, this message translates to:
  /// **'Omluvit'**
  String get live_events_screen_change_dependent_status_dialog_excused;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_loading.
  ///
  /// In cs, this message translates to:
  /// **'Probíhá změna stavu účasti...'**
  String get live_events_screen_change_dependent_status_dialog_loading;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_error.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se změnit stav účasti. Zkus to prosím znovu.'**
  String get live_events_screen_change_dependent_status_dialog_error;

  /// No description provided for @live_events_screen_change_dependent_status_dialog_success.
  ///
  /// In cs, this message translates to:
  /// **'Stav osoby {dependent_name} byl úspěšně změněn na {new_status}.'**
  String live_events_screen_change_dependent_status_dialog_success(
    String dependent_name,
    String new_status,
  );

  /// No description provided for @live_events_screen_cannot_change_status_past_signup_deadline.
  ///
  /// In cs, this message translates to:
  /// **'Nelze změnit stav přihlášení na výpravu po vypršení datumu přihlašování.'**
  String get live_events_screen_cannot_change_status_past_signup_deadline;

  /// No description provided for @category_dependents_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- DEPENDENTS SCREEN ---'**
  String get category_dependents_screen;

  /// No description provided for @dependents_screen_add_dependent_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Přidat'**
  String get dependents_screen_add_dependent_button_text;

  /// No description provided for @dependents_screen_dependent_nickname.
  ///
  /// In cs, this message translates to:
  /// **'Přezdívka'**
  String get dependents_screen_dependent_nickname;

  /// No description provided for @dependents_screen_dependent_patrol.
  ///
  /// In cs, this message translates to:
  /// **'Družina'**
  String get dependents_screen_dependent_patrol;

  /// No description provided for @dependents_screen_dependent_this_school_year_event_attendance.
  ///
  /// In cs, this message translates to:
  /// **'Účast na výpravách v tomto školním roce'**
  String get dependents_screen_dependent_this_school_year_event_attendance;

  /// No description provided for @dependents_screen_dependent_notes.
  ///
  /// In cs, this message translates to:
  /// **'Upravit detaily'**
  String get dependents_screen_dependent_notes;

  /// No description provided for @dependents_screen_dependent_description.
  ///
  /// In cs, this message translates to:
  /// **'Pokud chceš, můžeš sem napsat něco o osobě {name_surname}. Detaily uvidí pouze administrátoři a vedoucí. Pomůže to při organizaci výprav.'**
  String dependents_screen_dependent_description(Object name_surname);

  /// No description provided for @dependents_screen_depents_details_has_gluten_allergy.
  ///
  /// In cs, this message translates to:
  /// **'Má alergii na lepek'**
  String get dependents_screen_depents_details_has_gluten_allergy;

  /// No description provided for @dependents_screen_depents_details_has_lactose_intolerance.
  ///
  /// In cs, this message translates to:
  /// **'Má alergii na laktózu'**
  String get dependents_screen_depents_details_has_lactose_intolerance;

  /// No description provided for @dependents_screen_depents_details_has_nut_allergy.
  ///
  /// In cs, this message translates to:
  /// **'Má alergii na ořechy'**
  String get dependents_screen_depents_details_has_nut_allergy;

  /// No description provided for @dependents_screen_depents_details_is_claustrophobic.
  ///
  /// In cs, this message translates to:
  /// **'Má klaustrofobii'**
  String get dependents_screen_depents_details_is_claustrophobic;

  /// No description provided for @dependents_screen_depents_details_has_epilepsy.
  ///
  /// In cs, this message translates to:
  /// **'Má epilepsii'**
  String get dependents_screen_depents_details_has_epilepsy;

  /// No description provided for @dependents_screen_depents_details_has_asthma.
  ///
  /// In cs, this message translates to:
  /// **'Má astma'**
  String get dependents_screen_depents_details_has_asthma;

  /// No description provided for @dependents_screen_depents_details_is_swimmer.
  ///
  /// In cs, this message translates to:
  /// **'Je plavec'**
  String get dependents_screen_depents_details_is_swimmer;

  /// No description provided for @dependents_screen_depents_details_other_notes.
  ///
  /// In cs, this message translates to:
  /// **'Něco jiného'**
  String get dependents_screen_depents_details_other_notes;

  /// No description provided for @dependents_screen_depents_details_other_notes_description.
  ///
  /// In cs, this message translates to:
  /// **'Zde prosím napiš cokoliv co bychom ještě měli vědět. '**
  String get dependents_screen_depents_details_other_notes_description;

  /// No description provided for @dependents_screen_save_success.
  ///
  /// In cs, this message translates to:
  /// **'Detaily byly úspěšně uloženy 💾.'**
  String get dependents_screen_save_success;

  /// No description provided for @dependents_screen_unsaved_changes_dialog_title.
  ///
  /// In cs, this message translates to:
  /// **'Uložit změny?'**
  String get dependents_screen_unsaved_changes_dialog_title;

  /// No description provided for @dependents_screen_unsaved_changes_dialog_description.
  ///
  /// In cs, this message translates to:
  /// **'Máš neuložené změny. Chceš je před odchodem uložit?'**
  String get dependents_screen_unsaved_changes_dialog_description;

  /// No description provided for @dependents_screen_unsaved_changes_dialog_save.
  ///
  /// In cs, this message translates to:
  /// **'Uložit'**
  String get dependents_screen_unsaved_changes_dialog_save;

  /// No description provided for @dependents_screen_unsaved_changes_dialog_discard.
  ///
  /// In cs, this message translates to:
  /// **'Zahodit'**
  String get dependents_screen_unsaved_changes_dialog_discard;

  /// No description provided for @category_settings_screen.
  ///
  /// In cs, this message translates to:
  /// **'--- NASTAVENÍ ---'**
  String get category_settings_screen;

  /// No description provided for @settings_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Nastavení'**
  String get settings_screen_title;

  /// No description provided for @settings_screen_change_signout_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get settings_screen_change_signout_button_text;

  /// No description provided for @settings_screen_change_delete_account_button_text.
  ///
  /// In cs, this message translates to:
  /// **'Smazat účet'**
  String get settings_screen_change_delete_account_button_text;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['cs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
