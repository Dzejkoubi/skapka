// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/foundation.dart' as _i12;
import 'package:skapka_app/screens/account_not_approved_screen/account_not_approved_screen.dart'
    as _i1;
import 'package:skapka_app/screens/auth_gate/auth_gate.dart' as _i2;
import 'package:skapka_app/screens/events_screen/events_screen.dart' as _i4;
import 'package:skapka_app/screens/login_screen/login_screen.dart' as _i6;
import 'package:skapka_app/screens/register_screen/register_screen_first.dart'
    as _i7;
import 'package:skapka_app/screens/register_screen/register_screen_second.dart'
    as _i8;
import 'package:skapka_app/screens/theme_showcase_screens/button_theme_showcase.dart'
    as _i3;
import 'package:skapka_app/screens/theme_showcase_screens/large_dialog_showcase.dart'
    as _i5;
import 'package:skapka_app/screens/theme_showcase_screens/squircle_showcase.dart'
    as _i9;
import 'package:skapka_app/screens/welcome_screen/welcome_screen.dart' as _i10;

/// generated route for
/// [_i1.AccountNotApprovedScreen]
class AccountNotApprovedRoute extends _i11.PageRouteInfo<void> {
  const AccountNotApprovedRoute({List<_i11.PageRouteInfo>? children})
    : super(AccountNotApprovedRoute.name, initialChildren: children);

  static const String name = 'AccountNotApprovedRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountNotApprovedScreen();
    },
  );
}

/// generated route for
/// [_i2.AuthGate]
class AuthGate extends _i11.PageRouteInfo<void> {
  const AuthGate({List<_i11.PageRouteInfo>? children})
    : super(AuthGate.name, initialChildren: children);

  static const String name = 'AuthGate';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthGate();
    },
  );
}

/// generated route for
/// [_i3.ButtonThemeShowcaseScreen]
class ButtonThemeShowcaseRoute extends _i11.PageRouteInfo<void> {
  const ButtonThemeShowcaseRoute({List<_i11.PageRouteInfo>? children})
    : super(ButtonThemeShowcaseRoute.name, initialChildren: children);

  static const String name = 'ButtonThemeShowcaseRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.ButtonThemeShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i4.EventsScreen]
class EventsRoute extends _i11.PageRouteInfo<void> {
  const EventsRoute({List<_i11.PageRouteInfo>? children})
    : super(EventsRoute.name, initialChildren: children);

  static const String name = 'EventsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.EventsScreen();
    },
  );
}

/// generated route for
/// [_i5.LargeDialogShowcaseScreen]
class LargeDialogShowcaseRoute extends _i11.PageRouteInfo<void> {
  const LargeDialogShowcaseRoute({List<_i11.PageRouteInfo>? children})
    : super(LargeDialogShowcaseRoute.name, initialChildren: children);

  static const String name = 'LargeDialogShowcaseRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.LargeDialogShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.RegisterScreenFirst]
class RegisterRouteFirst extends _i11.PageRouteInfo<void> {
  const RegisterRouteFirst({List<_i11.PageRouteInfo>? children})
    : super(RegisterRouteFirst.name, initialChildren: children);

  static const String name = 'RegisterRouteFirst';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.RegisterScreenFirst();
    },
  );
}

/// generated route for
/// [_i8.RegisterScreenSecond]
class RegisterRouteSecond extends _i11.PageRouteInfo<RegisterRouteSecondArgs> {
  RegisterRouteSecond({
    _i12.Key? key,
    required String email,
    required String name,
    required String surname,
    List<_i11.PageRouteInfo>? children,
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

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteSecondArgs>();
      return _i8.RegisterScreenSecond(
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

  final _i12.Key? key;

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
/// [_i9.SquircleShowcaseScreen]
class SquircleShowcaseRoute extends _i11.PageRouteInfo<void> {
  const SquircleShowcaseRoute({List<_i11.PageRouteInfo>? children})
    : super(SquircleShowcaseRoute.name, initialChildren: children);

  static const String name = 'SquircleShowcaseRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SquircleShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i10.WelcomeScreen]
class WelcomeRoute extends _i11.PageRouteInfo<void> {
  const WelcomeRoute({List<_i11.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.WelcomeScreen();
    },
  );
}
