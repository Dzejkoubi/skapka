import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/providers/account_provider.dart';

class LeaderGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;
    if (context == null) {
      resolver.next(false);
      return;
    }

    final accountProvider = Provider.of<AccountProvider>(
      context,
      listen: false,
    );

    final bool isLeader = accountProvider.rights >= 2;
    if (isLeader) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      resolver.next(false);
    }
  }
}
