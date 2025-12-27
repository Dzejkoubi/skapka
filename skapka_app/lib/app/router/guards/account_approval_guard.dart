import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/services/auth_service.dart';

class AccountApprovalGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Check if the user has an active session
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedAccountConfirmed();

    if (isLoggedIn == true) {
      // User is authenticated, proceed to the requested route
      resolver.next(true);
    } else {
      // User is NOT approved, redirect to AccountNotApproved screen
      resolver.redirectUntil(const AccountNotApprovedRoute());
    }
  }
}
