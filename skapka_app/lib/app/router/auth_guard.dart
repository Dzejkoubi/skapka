import 'package:auto_route/auto_route.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Check if the user has an active session
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // User is authenticated, proceed to the requested route
      resolver.next(true);
    } else {
      // User is NOT authenticated, redirect to Welcome screen
      resolver.redirectUntil(const WelcomeRoute());
    }
  }
}
