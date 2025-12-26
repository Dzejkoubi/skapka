import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/router/auth_guard.dart';
// To generate the router file, run:
// flutter pub run build_runner build
// or for continuous generation:
// flutter pub run build_runner watch

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    // 1. Set EventsRoute as initial, but guarded
    AutoRoute(
      page: EventsRoute.page,
      initial: true,
      guards: [AuthGuard()], // Add the guard here
    ),

    // 2. Public routes (no guard needed)
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRouteFirst.page),
    AutoRoute(page: RegisterRouteSecond.page),
    AutoRoute(page: AccountNotApprovedRoute.page),

    // ... other routes
    AutoRoute(page: ButtonThemeShowcaseRoute.page),
    AutoRoute(page: SquircleShowcaseRoute.page),
    AutoRoute(page: LargeDialogShowcaseRoute.page),
  ];
}
