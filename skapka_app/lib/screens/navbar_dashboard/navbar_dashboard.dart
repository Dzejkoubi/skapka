import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/navbar/navbar.dart';
import 'package:skapka_app/widgets/navbar/navbar_item.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/wrappers/widgets/custom_floating_action_button_location.dart';

@RoutePage()
class NavbarDashboard extends StatefulWidget {
  const NavbarDashboard({super.key});

  @override
  State<NavbarDashboard> createState() => _NavbarDashboardState();
}

class _NavbarDashboardState extends State<NavbarDashboard> {
  @override
  void initState() {
    super.initState();
    _initFcm();
  }

  Future<void> _initFcm() async {
    final messaging = FirebaseMessaging.instance;

    // Request permission — shows system dialog on iOS and Android 13+
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    // Skip APNS token on simulators and web - they do not have one.
    if (defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb) {
      final isSimulator = await _isIOSSimulator();
      if (!isSimulator) {
        String? apnsToken;
        for (var i = 0; i < 5; i++) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken != null) break;
          await Future.delayed(const Duration(seconds: 1));
        }
        if (apnsToken == null) {
          debugPrint(
            'Failed to get APNS token after multiple attempts. Notifications may not work on this device.',
          );
          return;
        }
      }
    }

    // Get token and save to Supabase
    await _saveToken(await messaging.getToken());

    // Handle token rotation
    messaging.onTokenRefresh.listen(_saveToken);

    // Foreground — app is open when notification arrives
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground FCM: ${message.notification?.title}');
    });

    // Background tap — user tapped notification while app was backgrounded
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message.data);
    });

    // Terminated tap — user tapped notification that launched the app from closed state
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage.data);
    }
  }

  Future<bool> _isIOSSimulator() async {
    // dart:io Platform.environment contains SIMULATOR_DEVICE_NAME when running on a simulator
    return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');
  }

  Future<void> _saveToken(String? token) async {
    print('trying to save FCM token: $token');
    if (token == null) {
      debugPrint('FCM: token is null, skipping save');
      return;
    }
    try {
      await SupabaseService().saveFcmToken(token);
    } catch (e) {
      debugPrint('FCM: failed to save token — $e');
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    debugPrint('Notification data: $data');
    final path = data['path'] as String?;
    debugPrint('Notification path: "$path"');
    if (path == null || path.isEmpty) return;

    // Routes with complex Dart-object parameters can't be resolved from a URL.
    // Map them explicitly; everything else uses navigateNamed.
    if (path == '/event/create') {
      context.router.push(CreateEditEventRoute());
    } else {
      debugPrint('Navigating to: "$path"');
      context.router.navigatePath(path);
    }
  }

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
              label: context.localizations.navbar_dependents,
              iconAsset: 'assets/icons/navbar/navbar-user-circle.svg',
              screenRoute: DependentsRoute(),
              speedDialChildren: null,
            ),
            CustomNavBarItemInfo(
              label: context.localizations.navbar_events,
              iconAsset: 'assets/icons/navbar/navbar-compass.svg',
              screenRoute: LiveEventsRoute(),
              speedDialChildren: accountProvider.rights >= 2
                  ? [
                      SpeedDialChild(
                        labelWidget: MainButton.filled(
                          text: context.localizations.create,
                          onPressed: () {
                            dialOpenNotifier.value = false;
                            context.router.push(
                              CreateEditEventRoute(
                                event: null,
                                eventTimeType: null,
                              ),
                            );
                          },
                        ),
                      ),
                    ]
                  : null,
            ),
            CustomNavBarItemInfo(
              label: context.localizations.navbar_calendar,
              iconAsset: 'assets/icons/navbar/navbar-calendar-month.svg',
              screenRoute: CalendarRoute(),
              speedDialChildren: [
                if (isUserLeader(context))
                  SpeedDialChild(
                    labelWidget: MainButton.filled(
                      text: context.localizations.create,
                      onPressed: () {
                        dialOpenNotifier.value = false;
                        context.router.push(
                          CreateEditEventRoute(
                            event: null,
                            eventTimeType: null,
                          ),
                        );
                      },
                    ),
                  ),
                // SpeedDialChild(
                //   labelWidget: MainButton.outlined(
                //     text: AppLocalizations.of(
                //       context,
                //     )!.calendar_screen_speed_dial_add_google_calendar,
                //     onPressed: () {
                //       debugPrint('Add Google Calendar');
                //     },
                //   ),
                // ),
              ],
            ),
            CustomNavBarItemInfo(
              label: context.localizations.navbar_info,
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
