import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  SupabaseClient get supabaseClient => _supabaseClient;

  // Get current session
  Session? get currentSession => _supabaseClient.auth.currentSession;

  // Get current user
  User? get currentUser => _supabaseClient.auth.currentUser;

  // Listen to auth state changes
  Stream<AuthState> get onAuthStateChange =>
      _supabaseClient.auth.onAuthStateChange;

  // Sign In
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign Up (Register)
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signUp(email: email, password: password);
  }

  // Sign Out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Delete Account
  // Note: This usually requires a secure environment or an Edge Function
  // if you want to delete the user from the auth schema entirely,
  // but you can call a function or use the admin api if enabled.
  // For now, we'll assume a Supabase Edge Function or RPC is used,
  // or we just sign them out if self-deletion isn't enabled directly in client SDK.
  Future<void> deleteAccount() async {
    final userId = currentUser?.id;
    if (userId != null) {
      await _supabaseClient.functions.invoke(
        'delete_account',
        body: {'account_id': userId},
      );
    }
    await signOut();
  }
}
