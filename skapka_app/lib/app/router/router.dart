import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/router.gr.dart';
// To generate the router file, run:
// flutter pub run build_runner build
// or for continuous generation:
// flutter pub run build_runner watch

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: false),
    AutoRoute(page: ButtonThemeShowcaseRoute.page, initial: true),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
