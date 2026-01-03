import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/utils/is_user_leader.dart';

class LeaderGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    if (context == null) {
      resolver.next(false);
      return;
    }

    if (isUserLeader(context)) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      resolver.next(false);
    }
  }
}
