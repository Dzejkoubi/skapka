import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/guards/admin_guard.dart';
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
    // Initial route
    AutoRoute(page: AuthGate.page, initial: true),
    // Onboarding and auth routes
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: LiveEventsRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRouteFirst.page),
    AutoRoute(page: RegisterRouteSecond.page),
    AutoRoute(page: AccountNotApprovedRoute.page),

    // Main app routes with bottom navbar and settings
    AutoRoute(
      page: NavbarDashboard.page,
      children: [
        CustomRoute(page: DependentsRoute.page),
        CustomRoute(page: LiveEventsRoute.page, initial: true),
        CustomRoute(page: CalendarRoute.page),
        CustomRoute(page: InformationRoute.page),
      ],
    ),
    AutoRoute(page: SettingsRoute.page),

    // Dependent related routes
    AutoRoute(page: EditDependentDetailsRoute.page, fullscreenDialog: true),

    // Event related routes
    AutoRoute(page: EventDetailsRoute.page),
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

    // Development and showcase routes
    AutoRoute(page: AdminPanelRoute.page, guards: [AdminGuard()]),
    AutoRoute(page: SendNotificationRoute.page, guards: [LeaderGuard()]),
    // AutoRoute(page: ButtonThemeShowcaseRoute.page),
    // AutoRoute(page: SquircleShowcaseRoute.page),
    // AutoRoute(page: LargeDialogShowcaseRoute.page),

    // Admin panel screens
    AutoRoute(page: ApproveAccountsRoute.page, guards: [AdminGuard()]),
    AutoRoute(page: EditAccountRightsRoute.page, guards: [AdminGuard()]),
    AutoRoute(page: EditLeadersRoute.page, guards: [AdminGuard()]),
    AutoRoute(page: SetPatrolLeaderRoute.page, guards: [AdminGuard()]),
    AutoRoute(page: ConnectAccountDependentsRoute.page, guards: [AdminGuard()]),
  ];
}
