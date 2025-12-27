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

  /// No description provided for @welcome_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Vítej ve\nSkapce'**
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

  /// No description provided for @account_not_approved_screen_title.
  ///
  /// In cs, this message translates to:
  /// **'Účet ještě nebyl schválen'**
  String get account_not_approved_screen_title;

  /// No description provided for @account_not_approved_screen_text.
  ///
  /// In cs, this message translates to:
  /// **'Administrátor musí tvůj účet nejdřív schválit, než se budeš moct přihlásit. Jakmile to udělá, přijde ti e-mail.'**
  String get account_not_approved_screen_text;

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

  /// No description provided for @events_screen_fab_create_event_text.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořit'**
  String get events_screen_fab_create_event_text;

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
