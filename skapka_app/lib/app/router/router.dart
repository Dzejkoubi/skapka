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
    AutoRoute(page: AuthGate.page, initial: true, path: '/'),
    // Onboarding and auth routes
    AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: RegisterRouteFirst.page, path: '/register/step1'),
    AutoRoute(page: RegisterRouteSecond.page, path: '/register/step2'),
    AutoRoute(
      page: AccountNotApprovedRoute.page,
      path: '/account-not-approved',
    ),
    // Path matches the password-reset email link so an installed app can
    // intercept it as a universal/app link.
    AutoRoute(page: ResetPasswordRoute.page, path: '/app/reset-password'),

    // Main app routes with bottom navbar and settings
    AutoRoute(
      page: NavbarDashboard.page,
      path: '/dashboard',
      children: [
        CustomRoute(page: DependentsRoute.page, path: 'dependents'),
        CustomRoute(page: LiveEventsRoute.page, initial: true, path: 'events'),
        CustomRoute(page: CalendarRoute.page, path: 'calendar'),
        CustomRoute(page: InformationRoute.page, path: 'information'),
      ],
    ),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),

    // Dependent related routes
    AutoRoute(
      page: EditDependentDetailsRoute.page,
      fullscreenDialog: true,
      path: '/dependent/edit/:dependentId',
    ),

    // Event related routes
    AutoRoute(page: EventDetailsRoute.page, path: '/event/:eventId'),
    AutoRoute(
      page: CreateEditEventRoute.page,
      guards: [LeaderGuard()],
      path: '/event/create',
    ),
    AutoRoute(
      page: CreateEditEventInstructionsRoute.page,
      guards: [LeaderGuard()],
      fullscreenDialog: true,
      path: '/event/:eventId/instructions',
    ),
    AutoRoute(
      page: CreateEditEventParticipantsRoute.page,
      guards: [LeaderGuard()],
      fullscreenDialog: true,
      path: '/event/:eventId/participants',
    ),

    // Development and showcase routes
    AutoRoute(
      page: AdminPanelRoute.page,
      guards: [AdminGuard()],
      path: '/admin',
    ),
    AutoRoute(
      page: SendNotificationRoute.page,
      guards: [LeaderGuard()],
      path: '/send-notification',
    ),
    // AutoRoute(page: ButtonThemeShowcaseRoute.page),
    // AutoRoute(page: SquircleShowcaseRoute.page),
    // AutoRoute(page: LargeDialogShowcaseRoute.page),

    // Admin panel screens
    AutoRoute(
      page: ApproveAccountsRoute.page,
      guards: [AdminGuard()],
      path: '/admin/approve-accounts',
    ),
    AutoRoute(
      page: EditAccountRightsRoute.page,
      guards: [AdminGuard()],
      path: '/admin/edit-account-rights',
    ),
    AutoRoute(
      page: EditLeadersRoute.page,
      guards: [AdminGuard()],
      path: '/admin/edit-leaders',
    ),
    AutoRoute(
      page: SetPatrolLeaderRoute.page,
      guards: [AdminGuard()],
      path: '/admin/set-patrol-leader',
    ),
    AutoRoute(
      page: ConnectAccountsDependentsRoute.page,
      guards: [AdminGuard()],
      path: '/admin/connect-accounts-dependents',
    ),
    AutoRoute(
      page: AddDependentsToAccountRoute.page,
      guards: [AdminGuard()],
      path: '/admin/add-dependents/:accountId',
    ),
  ];
}
