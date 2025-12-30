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
  String get navbar_dependents => 'Osoby';

  @override
  String get navbar_events => 'Výpravy';

  @override
  String get navbar_calendar => 'Kalendář';

  @override
  String get navbar_info => 'Informace';

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
  String get login_screen_login_error_email_not_confirmed =>
      'E-mailová adresa není potvrzena. Zkontroluj prosím svou schránku.';

  @override
  String get login_screen_login_error_email_empty =>
      'Nezapomněl/a si na email?';

  @override
  String get login_screen_login_error_email_invalid =>
      'Pozor, takhle přece nevypadá e-mail.';

  @override
  String get login_screen_login_success => 'Přihlášení proběhlo úspěšně!';

  @override
  String get login_screen_login_error_generic =>
      'Něco se nepovedlo. Zkus to prosím znovu.';

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

  @override
  String get register_screen_2_registration_success =>
      'Registrace proběhla úspěšně!';

  @override
  String get register_screen_2_registration_error_email_used =>
      'Tento e-mail je již použit. Zkus se přihlásit nebo použij jiný e-mail.';

  @override
  String get register_screen_2_registration_error_rate_limit =>
      'Příliš mnoho pokusů. Zkus to prosím později.';

  @override
  String get register_screen_2_registration_error_weak_password =>
      'Heslo je příliš slabé.';

  @override
  String get register_screen_2_registration_error_generic =>
      'Registrace se nezdařila. Zkus to prosím znovu.';

  @override
  String get account_not_approved_screen_title => 'Účet ještě nebyl schválen';

  @override
  String account_not_approved_screen_text(String name_surname) {
    return 'Administrátor musí tvůj účet${name_surname}nejdřív schválit, než se budeš moct přihlásit. Jakmile to udělá, přijde ti e-mail.';
  }

  @override
  String get account_not_approved_screen_notify_administrator_button_text =>
      'Upozornit administrátora';

  @override
  String get account_not_approved_screen_notify_administrator_dialog_title =>
      'Upozornit administrátora';

  @override
  String
  get account_not_approved_screen_notify_administrator_dialog_description =>
      'Tento krok upozorní administrátora emailem. Lze poslat jednou za den.';

  @override
  String
  get account_not_approved_screen_notify_administrator_dialog_primary_button_text =>
      'Poslat upozornění';

  @override
  String
  get account_not_approved_screen_notify_administrator_button_error_dialog =>
      'Upozornění lze poslat jen jednou za 24 hodin. Zkus to později.';

  @override
  String get account_not_approved_screen_notify_success =>
      'Administrátor byl upozorněn.';

  @override
  String get account_not_approved_screen_notify_error =>
      'Nepodařilo se upozornit administrátora. Zkus to prosím později.';

  @override
  String get account_not_approved_screen_logout_button_text => 'Odhlásit se';

  @override
  String get account_not_approved_screen_logout_dialog_title => 'Odhlásit se';

  @override
  String get account_not_approved_screen_logout_dialog_description =>
      'Opravdu se chceš odhlásit ze svého účtu?';

  @override
  String get account_not_approved_screen_logout_dialog_primary_button_text =>
      'Odhlásit se';

  @override
  String get account_not_approved_screen_logout_success =>
      'Odhlášení proběhlo úspěšně.';

  @override
  String get account_not_approved_screen_logout_error =>
      'Odhlášení se nezdařilo. Zkus to prosím znovu.';

  @override
  String get account_not_approved_screen_delete_account_button_text =>
      'Smazat účet';

  @override
  String get account_not_approved_screen_delete_account_dialog_title =>
      'Smazat účet';

  @override
  String get account_not_approved_screen_delete_account_dialog_description =>
      'Opravdu chceš smazat svůj účet? Tuto akci nelze vrátit zpět.';

  @override
  String
  get account_not_approved_screen_delete_account_dialog_primary_button_text =>
      'Smazat účet';

  @override
  String get account_not_approved_screen_delete_success =>
      'Tvůj účet byl smazán.';

  @override
  String get account_not_approved_screen_delete_error =>
      'Smazání účtu se nezdařilo. Zkus to prosím později.';

  @override
  String get events_screen_title => 'Výpravy';

  @override
  String events_screen_no_events_text(String version, Object username) {
    return '$username aktuálně nemá žádnou aktivní výpravu.';
  }

  @override
  String event_box_number_of_kids_text(int number_of_kids) {
    return '$number_of_kids dětí';
  }

  @override
  String get event_box_photos_link_text => 'Fotky';

  @override
  String get event_box_sign_up_start_date_text => 'Přihlašování od: ';

  @override
  String get event_box_sign_up_end_date_text => 'Přihlašování do: ';

  @override
  String get event_box_event_multiple_days_start_text => 'Od: ';

  @override
  String get event_box_event_multiple_days_end_text => 'Do: ';

  @override
  String get event_box_event_single_day_text => 'Kdy: ';

  @override
  String get calendar_screen_title => 'Kalendář';

  @override
  String get calendar_screen_speed_dial_add_google_calendar =>
      'Google kalendář';

  @override
  String get calendar_screen_event_expansion_tile_no_events_title =>
      'Ticho po pěšině...';

  @override
  String get calendar_screen_event_expansion_tile_future_title =>
      'Nadcházející';

  @override
  String get calendar_screen_event_expansion_tile_future_no_events_subtitle =>
      'Zdá se, že nejsou žádné nadcházející výpravy.';

  @override
  String get calendar_screen_event_expansion_tile_live_title => 'Přihlašování';

  @override
  String get calendar_screen_event_expansion_tile_live_no_events_subtitle =>
      'Zdá se, že nejsou žádné výpravy k přihlášení.';

  @override
  String get calendar_screen_event_expansion_tile_past_title => 'Proběhlé';

  @override
  String get calendar_screen_event_expansion_tile_past_no_events_subtitle =>
      'Zdá se, že nejsou žádné proběhlé výpravy.';

  @override
  String get calendar_screen_event_expansion_tile_draft_title => 'Koncepty';

  @override
  String get calendar_screen_event_expansion_tile_draft_no_events_subtitle =>
      'Zdá se, že nejsou žádné koncepty.';

  @override
  String get create_event_screen_title => 'Vytvořit výpravu';

  @override
  String get create_event_screen_speed_dial_save_event_text => 'Uložit';

  @override
  String get create_event_screen_save_event_dialog_title =>
      'Uložit jako koncept';

  @override
  String get create_event_screen_save_event_dialog_description =>
      'Chceš uložit tuto výpravu jako koncept? Výprava se zveřejní až po kliknutí na tlačítko zveřejnit. Můžeš ji upravit později.';

  @override
  String get create_event_screen_save_event_dialog_primary_button_text =>
      'Uložit jako koncept';

  @override
  String get create_event_screen_speed_dial_publish_event_text => 'Zveřejnit';

  @override
  String get create_event_screen_publish_event_dialog_title =>
      'Zveřejnit výpravu';

  @override
  String get create_event_screen_publish_event_dialog_description =>
      'Opravdu chceš zveřejnit tuto výpravu? Výprava se přidá do kalendáře a až nadejde čas přihlašování, budou se moct pozvaní účastníci přihlašovat.';

  @override
  String get create_event_screen_publish_event_dialog_primary_button_text =>
      'Zveřejnit';

  @override
  String get create_event_screen_speed_dial_unpublish_event_text =>
      'Zrušit zveřejnění';

  @override
  String get create_event_screen_unpublish_event_dialog_title =>
      'Zrušit zveřejnění výpravy';

  @override
  String get create_event_screen_unpublish_event_dialog_description =>
      'Opravdu chceš zrušit zveřejnění této výpravy? Účastníci se nebudou moct dál přihlašovat a výprava se odstraní z kalendáře.';

  @override
  String get create_event_screen_unpublish_event_dialog_primary_button_text =>
      'Zrušit zveřejnění';

  @override
  String get create_event_screen_speed_dial_delete_event_text => 'Smazat';

  @override
  String get create_event_screen_delete_event_dialog_title => 'Smazat výpravu';

  @override
  String get create_event_screen_delete_event_dialog_description =>
      'Opravdu chceš smazat tuto výpravu? Tuto akci nelze vrátit zpět.';

  @override
  String get create_event_screen_delete_event_dialog_primary_button_text =>
      'Smazat';

  @override
  String get create_event_screen_go_back_without_saving_dialog_title =>
      'Zahodit změny';

  @override
  String get create_event_screen_go_back_without_saving_dialog_description =>
      'Opravdu chceš odejít bez uložení změn? Veškeré neuložené změny budou ztraceny.';

  @override
  String
  get create_event_screen_go_back_without_saving_dialog_primary_button_text =>
      'Zahodit';

  @override
  String
  get create_event_screen_go_back_without_saving_dialog_secondary_button_text =>
      'Zpět';

  @override
  String get create_event_screen_event_name_hint => 'Název výpravy';

  @override
  String get create_event_screen_event_sign_up_from => 'Přihlašování od';

  @override
  String get create_event_screen_event_sign_up_to => 'Přihlašování do';

  @override
  String get create_event_screen_event_from_hint => 'Od';

  @override
  String get create_event_screen_event_to_hint => 'Do';

  @override
  String get create_event_screen_select_participants_text => 'Vybrat účastníky';

  @override
  String get create_event_screen_total_participants_text =>
      'Celkový počet účastníků';

  @override
  String get create_event_screen_troops => 'Oddíly';

  @override
  String get create_event_screen_18_leaders => 'Vedoucí/18+';

  @override
  String get create_event_screen_instructions_text => 'Pokyny';

  @override
  String get create_event_screen_meeting_place_text => 'Místo srazu';

  @override
  String get create_event_screen_meeting_place_address_text => 'Adresa';

  @override
  String get settings_screen_title => 'Nastavení';

  @override
  String get settings_screen_change_signout_button_text => 'Odhlásit se';

  @override
  String get settings_screen_change_delete_account_button_text => 'Smazat účet';

  @override
  String get yes => 'Ano';

  @override
  String get no => 'Ne';

  @override
  String get cancel => 'Zrušit';

  @override
  String get loading => 'Načítání...';

  @override
  String get back => 'Zpět';

  @override
  String get common_copied_to_clipboard => 'Zkopírováno do schránky';

  @override
  String get create => 'Vytvořit';
}
