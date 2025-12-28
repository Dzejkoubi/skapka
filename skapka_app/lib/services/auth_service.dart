import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Get current session
  Session? get currentSession => _supabaseClient.auth.currentSession;

  // Get current user
  User? get currentUser => _supabaseClient.auth.currentUser;

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
    Map<String, dynamic>? data,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
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
    // Example: await _supabaseClient.functions.invoke('delete-user');
    // Or if you have a specific RPC:
    // await _supabaseClient.rpc('delete_user_account');

    // For safety, we often just sign out if no backend logic is ready yet.
    await signOut();
  }

  Future<bool> isLoggedAccountApproved() async {
    if (currentUser != null) {
      final userId = currentUser!.id;
      final response = await _supabaseClient.functions.invoke(
        'is_account_approved',
        body: {'account_id': userId},
      );
      if (response.data != null && response.data is Map<String, dynamic>) {
        return response.data['is_approved'] as bool;
      } else {
        return false;
      }
    }
    return false;
  }

  // Listen to auth state changes
  Stream<AuthState> get onAuthStateChange =>
      _supabaseClient.auth.onAuthStateChange;
}
