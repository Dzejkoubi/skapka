// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/foundation.dart' as _i21;
import 'package:flutter/material.dart' as _i19;
import 'package:skapka_app/models/event_model.dart' as _i20;
import 'package:skapka_app/screens/account_not_approved_screen/account_not_approved_screen.dart'
    as _i1;
import 'package:skapka_app/screens/auth_gate/auth_gate.dart' as _i2;
import 'package:skapka_app/screens/calendar_screen/calendar_screen.dart' as _i4;
import 'package:skapka_app/screens/create_event_screen.dart/create_event_screen.dart'
    as _i5;
import 'package:skapka_app/screens/dependents_screen/dependents_screen.dart'
    as _i6;
import 'package:skapka_app/screens/event_details_screen/event_details_screen.dart'
    as _i7;
import 'package:skapka_app/screens/events_screen/events_screen.dart' as _i8;
import 'package:skapka_app/screens/information_screen/information_screen.dart'
    as _i9;
import 'package:skapka_app/screens/login_screen/login_screen.dart' as _i11;
import 'package:skapka_app/screens/navbar_dashboard/navbar_dashboard.dart'
    as _i12;
import 'package:skapka_app/screens/register_screen/register_screen_first.dart'
    as _i13;
import 'package:skapka_app/screens/register_screen/register_screen_second.dart'
    as _i14;
import 'package:skapka_app/screens/settings_screen/settings_screen.dart'
    as _i15;
import 'package:skapka_app/screens/theme_showcase_screens/button_theme_showcase.dart'
    as _i3;
import 'package:skapka_app/screens/theme_showcase_screens/large_dialog_showcase.dart'
    as _i10;
import 'package:skapka_app/screens/theme_showcase_screens/squircle_showcase.dart'
    as _i16;
import 'package:skapka_app/screens/welcome_screen/welcome_screen.dart' as _i17;

/// generated route for
/// [_i1.AccountNotApprovedScreen]
class AccountNotApprovedRoute extends _i18.PageRouteInfo<void> {
  const AccountNotApprovedRoute({List<_i18.PageRouteInfo>? children})
    : super(AccountNotApprovedRoute.name, initialChildren: children);

  static const String name = 'AccountNotApprovedRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountNotApprovedScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthGate]
class AuthGate extends _i18.PageRouteInfo<void> {
  const AuthGate({List<_i18.PageRouteInfo>? children})
    : super(AuthGate.name, initialChildren: children);

  static const String name = 'AuthGate';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthGate();
    },
  );
}

/// generated route for
/// [_i3.ButtonThemeShowcaseScreen]
class ButtonThemeShowcaseRoute extends _i18.PageRouteInfo<void> {
  const ButtonThemeShowcaseRoute({List<_i18.PageRouteInfo>? children})
    : super(ButtonThemeShowcaseRoute.name, initialChildren: children);

  static const String name = 'ButtonThemeShowcaseRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.ButtonThemeShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i4.CalendarScreen]
class CalendarRoute extends _i18.PageRouteInfo<void> {
  const CalendarRoute({List<_i18.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.CalendarScreen();
    },
  );
}

/// generated route for
/// [_i5.CreateEventScreen]
class CreateEventRoute extends _i18.PageRouteInfo<void> {
  const CreateEventRoute({List<_i18.PageRouteInfo>? children})
    : super(CreateEventRoute.name, initialChildren: children);

  static const String name = 'CreateEventRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.CreateEventScreen();
    },
  );
}

/// generated route for
/// [_i6.DependentsScreen]
class DependentsRoute extends _i18.PageRouteInfo<void> {
  const DependentsRoute({List<_i18.PageRouteInfo>? children})
    : super(DependentsRoute.name, initialChildren: children);

  static const String name = 'DependentsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.DependentsScreen();
    },
  );
}

/// generated route for
/// [_i7.EventDetailsScreen]
class EventDetailsRoute extends _i18.PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({
    _i19.Key? key,
    required _i20.EventModel event,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         EventDetailsRoute.name,
         args: EventDetailsRouteArgs(key: key, event: event),
         initialChildren: children,
       );

  static const String name = 'EventDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventDetailsRouteArgs>();
      return _i7.EventDetailsScreen(key: args.key, event: args.event);
    },
  );
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({this.key, required this.event});

  final _i19.Key? key;

  final _i20.EventModel event;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{key: $key, event: $event}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventDetailsRouteArgs) return false;
    return key == other.key && event == other.event;
  }

  @override
  int get hashCode => key.hashCode ^ event.hashCode;
}

/// generated route for
/// [_i8.EventsScreen]
class EventsRoute extends _i18.PageRouteInfo<void> {
  const EventsRoute({List<_i18.PageRouteInfo>? children})
    : super(EventsRoute.name, initialChildren: children);

  static const String name = 'EventsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.EventsScreen();
    },
  );
}

/// generated route for
/// [_i9.InformationScreen]
class InformationRoute extends _i18.PageRouteInfo<void> {
  const InformationRoute({List<_i18.PageRouteInfo>? children})
    : super(InformationRoute.name, initialChildren: children);

  static const String name = 'InformationRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.InformationScreen();
    },
  );
}

/// generated route for
/// [_i10.LargeDialogShowcaseScreen]
class LargeDialogShowcaseRoute extends _i18.PageRouteInfo<void> {
  const LargeDialogShowcaseRoute({List<_i18.PageRouteInfo>? children})
    : super(LargeDialogShowcaseRoute.name, initialChildren: children);

  static const String name = 'LargeDialogShowcaseRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.LargeDialogShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i11.LoginScreen();
    },
  );
}

/// generated route for
/// [_i12.NavbarDashboard]
class NavbarDashboard extends _i18.PageRouteInfo<void> {
  const NavbarDashboard({List<_i18.PageRouteInfo>? children})
    : super(NavbarDashboard.name, initialChildren: children);

  static const String name = 'NavbarDashboard';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.NavbarDashboard();
    },
  );
}

/// generated route for
/// [_i13.RegisterScreenFirst]
class RegisterRouteFirst extends _i18.PageRouteInfo<void> {
  const RegisterRouteFirst({List<_i18.PageRouteInfo>? children})
    : super(RegisterRouteFirst.name, initialChildren: children);

  static const String name = 'RegisterRouteFirst';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.RegisterScreenFirst();
    },
  );
}

/// generated route for
/// [_i14.RegisterScreenSecond]
class RegisterRouteSecond extends _i18.PageRouteInfo<RegisterRouteSecondArgs> {
  RegisterRouteSecond({
    _i21.Key? key,
    required String email,
    required String name,
    required String surname,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         RegisterRouteSecond.name,
         args: RegisterRouteSecondArgs(
           key: key,
           email: email,
           name: name,
           surname: surname,
         ),
         initialChildren: children,
       );

  static const String name = 'RegisterRouteSecond';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteSecondArgs>();
      return _i14.RegisterScreenSecond(
        key: args.key,
        email: args.email,
        name: args.name,
        surname: args.surname,
      );
    },
  );
}

class RegisterRouteSecondArgs {
  const RegisterRouteSecondArgs({
    this.key,
    required this.email,
    required this.name,
    required this.surname,
  });

  final _i21.Key? key;

  final String email;

  final String name;

  final String surname;

  @override
  String toString() {
    return 'RegisterRouteSecondArgs{key: $key, email: $email, name: $name, surname: $surname}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteSecondArgs) return false;
    return key == other.key &&
        email == other.email &&
        name == other.name &&
        surname == other.surname;
  }

  @override
  int get hashCode =>
      key.hashCode ^ email.hashCode ^ name.hashCode ^ surname.hashCode;
}

/// generated route for
/// [_i15.SettingsScreen]
class SettingsRoute extends _i18.PageRouteInfo<void> {
  const SettingsRoute({List<_i18.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i15.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i16.SquircleShowcaseScreen]
class SquircleShowcaseRoute extends _i18.PageRouteInfo<void> {
  const SquircleShowcaseRoute({List<_i18.PageRouteInfo>? children})
    : super(SquircleShowcaseRoute.name, initialChildren: children);

  static const String name = 'SquircleShowcaseRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.SquircleShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i17.WelcomeScreen]
class WelcomeRoute extends _i18.PageRouteInfo<void> {
  const WelcomeRoute({List<_i18.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.WelcomeScreen();
    },
  );
}
