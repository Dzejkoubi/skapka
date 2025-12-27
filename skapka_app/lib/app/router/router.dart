import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/guards/auth_guard.dart';
import 'package:skapka_app/app/router/guards/is_approved_account_guard.dart';
import 'package:skapka_app/app/router/router.gr.dart';
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
    AutoRoute(page: WelcomeRoute.page, initial: true, guards: [AuthGuard()]),

    AutoRoute(page: EventsRoute.page, guards: [IsApprovedAccountGuard()]),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRouteFirst.page),
    AutoRoute(page: RegisterRouteSecond.page),
    AutoRoute(page: AccountNotApprovedRoute.page),
    AutoRoute(page: ButtonThemeShowcaseRoute.page),
    AutoRoute(page: SquircleShowcaseRoute.page),
    AutoRoute(page: LargeDialogShowcaseRoute.page),
  ];
}
