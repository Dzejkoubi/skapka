import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/navbar/navbar.dart';
import 'package:skapka_app/widgets/navbar/navbar_item.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/wrappers/widgets/custom_floating_action_button_location.dart';

@RoutePage()
class NavbarDashboard extends StatelessWidget {
  const NavbarDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountProvider accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Builder(
        builder: (context) {
          final dialOpenNotifier = context.watch<ValueNotifier<bool>>();

          final List<CustomNavBarItemInfo> navbarRoutes = [
            CustomNavBarItemInfo(
              label: AppLocalizations.of(context)!.navbar_dependents,
              iconAsset: 'assets/icons/navbar/navbar-user-circle.svg',
              screenRoute: DependentsRoute(),
              speedDialChildren: null,
            ),
            CustomNavBarItemInfo(
              label: AppLocalizations.of(context)!.navbar_events,
              iconAsset: 'assets/icons/navbar/navbar-compass.svg',
              screenRoute: EventsRoute(),
              speedDialChildren: accountProvider.rights >= 2
                  ? [
                      SpeedDialChild(
                        labelWidget: MainButton.filled(
                          text: AppLocalizations.of(context)!.create,
                          onPressed: () {
                            dialOpenNotifier.value = false;
                            context.router.push(CreateEventRoute());
                          },
                        ),
                      ),
                    ]
                  : null,
            ),
            CustomNavBarItemInfo(
              label: AppLocalizations.of(context)!.navbar_calendar,
              iconAsset: 'assets/icons/navbar/navbar-calendar-month.svg',
              screenRoute: CalendarRoute(),
              speedDialChildren: [
                if (isUserLeader(context))
                  SpeedDialChild(
                    labelWidget: MainButton.filled(
                      text: AppLocalizations.of(context)!.create,
                      onPressed: () {
                        dialOpenNotifier.value = false;
                        context.router.push(CreateEventRoute());
                      },
                    ),
                  ),
                SpeedDialChild(
                  labelWidget: MainButton.outlined(
                    text: AppLocalizations.of(
                      context,
                    )!.calendar_screen_speed_dial_add_google_calendar,
                    onPressed: () {
                      if (kDebugMode) {
                        print(
                          'Add Google Calendar',
                        ); // TODO: implement add Google Calendar
                      }
                    },
                  ),
                ),
              ],
            ),
            CustomNavBarItemInfo(
              label: AppLocalizations.of(context)!.navbar_info,
              iconAsset: 'assets/icons/navbar/navbar-info-circle.svg',
              screenRoute: InformationRoute(),
              speedDialChildren: null,
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
                speedDialChildren:
                    navbarRoutes[tabsRouter.activeIndex].speedDialChildren,
                floatingActionButtonLocation:
                    const CustomFloatingActionButtonLocation(
                      right: 32.0,
                      bottom: 128.0,
                    ),
                fabKey: tabsRouter.activeIndex,
                openCloseDial: dialOpenNotifier,
              );
            },
          );
        },
      ),
    );
  }
}
