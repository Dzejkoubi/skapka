import 'package:supabase_flutter/supabase_flutter.dart';

class SignInOutService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<String?> signIn(String email, String password) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return e.toString();
    }
  }
}
