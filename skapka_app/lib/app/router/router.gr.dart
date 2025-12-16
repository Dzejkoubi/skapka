// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:skapka_app/screens/login_screen/login_screen.dart' as _i2;
import 'package:skapka_app/screens/register_screen/register_screen_first.dart'
    as _i3;
import 'package:skapka_app/screens/register_screen/register_screen_second.dart'
    as _i4;
import 'package:skapka_app/screens/theme_showcase_screens/button_theme_showcase.dart'
    as _i1;
import 'package:skapka_app/screens/welcome_screen/welcome_screen.dart' as _i5;

/// generated route for
/// [_i1.ButtonThemeShowcaseScreen]
class ButtonThemeShowcaseRoute extends _i6.PageRouteInfo<void> {
  const ButtonThemeShowcaseRoute({List<_i6.PageRouteInfo>? children})
    : super(ButtonThemeShowcaseRoute.name, initialChildren: children);

  static const String name = 'ButtonThemeShowcaseRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.ButtonThemeShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.RegisterScreenFirst]
class RegisterRouteFirst extends _i6.PageRouteInfo<void> {
  const RegisterRouteFirst({List<_i6.PageRouteInfo>? children})
    : super(RegisterRouteFirst.name, initialChildren: children);

  static const String name = 'RegisterRouteFirst';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.RegisterScreenFirst();
    },
  );
}

/// generated route for
/// [_i4.RegisterScreenSecond]
class RegisterRouteSecond extends _i6.PageRouteInfo<void> {
  const RegisterRouteSecond({List<_i6.PageRouteInfo>? children})
    : super(RegisterRouteSecond.name, initialChildren: children);

  static const String name = 'RegisterRouteSecond';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.RegisterScreenSecond();
    },
  );
}

/// generated route for
/// [_i5.WelcomeScreen]
class WelcomeRoute extends _i6.PageRouteInfo<void> {
  const WelcomeRoute({List<_i6.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.WelcomeScreen();
    },
  );
}
