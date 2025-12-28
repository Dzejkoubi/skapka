import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/navbar/navbar.dart';
import 'package:skapka_app/widgets/navbar/navbar_item.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class NavbarDashboard extends StatelessWidget {
  const NavbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomNavBarItemInfo> navbarRoutes = [
      CustomNavBarItemInfo(
        label: AppLocalizations.of(context)!.navbar_dependents,
        iconAsset: 'assets/icons/navbar/navbar-user-circle.svg',
        screenRoute: DependentsRoute(),
      ),
      CustomNavBarItemInfo(
        label: AppLocalizations.of(context)!.navbar_events,
        iconAsset: 'assets/icons/navbar/navbar-compass.svg',
        screenRoute: EventsRoute(),
      ),
      CustomNavBarItemInfo(
        label: AppLocalizations.of(context)!.navbar_calendar,
        iconAsset: 'assets/icons/navbar/navbar-calendar-month.svg',
        screenRoute: CalendarRoute(),
      ),
      CustomNavBarItemInfo(
        label: AppLocalizations.of(context)!.navbar_info,
        iconAsset: 'assets/icons/navbar/navbar-info-circle.svg',
        screenRoute: InformationRoute(),
      ),
    ];

    return AutoTabsRouter(
      routes: navbarRoutes
          .map((screen) => screen.screenRoute)
          .toList(), // Get the routes from the navbarRoutes list
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      duration: const Duration(milliseconds: 300),
      builder: (context, body) {
        final tabsRouter = AutoTabsRouter.of(context);

        return ScreenWrapper(
          appBar: Appbar(
            showBackChevron: false,
            showSettingsIcon: true,
            screenName: navbarRoutes[tabsRouter.activeIndex].label,
          ),
          body: body,
          bottomNavigationBar: Navbar(
            items: navbarRoutes,
            activeIndex: tabsRouter.activeIndex,
            onItemSelected: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
