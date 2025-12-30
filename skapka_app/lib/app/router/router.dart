import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/guards/leader_guard.dart';
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
    AutoRoute(page: AuthGate.page, initial: true),

    AutoRoute(
      page: NavbarDashboard.page,
      children: [
        CustomRoute(page: DependentsRoute.page),
        CustomRoute(page: EventsRoute.page),
        CustomRoute(page: CalendarRoute.page, initial: true),
        CustomRoute(page: InformationRoute.page),
      ],
    ),

    AutoRoute(page: SettingsRoute.page),

    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: EventsRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRouteFirst.page),
    AutoRoute(page: RegisterRouteSecond.page),
    AutoRoute(page: AccountNotApprovedRoute.page),

    AutoRoute(page: CreateEditEventRoute.page, guards: [LeaderGuard()]),

    AutoRoute(
      page: CreateEditEventInstructionsRoute.page,
      guards: [LeaderGuard()],
      fullscreenDialog: true,
    ),

    AutoRoute(
      page: CreateEditEventParticipantsRoute.page,
      guards: [LeaderGuard()],
      fullscreenDialog: true,
    ),

    AutoRoute(page: ButtonThemeShowcaseRoute.page),
    AutoRoute(page: SquircleShowcaseRoute.page),
    AutoRoute(page: LargeDialogShowcaseRoute.page),
  ];
}
