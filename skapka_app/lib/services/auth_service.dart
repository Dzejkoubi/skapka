import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  SupabaseClient get supabaseClient => _supabaseClient;

  /// Returns the current authentication session, or null if not authenticated.
  Session? get currentSession => _supabaseClient.auth.currentSession;

  /// Returns the currently authenticated user, or null if not authenticated.
  User? get currentUser => _supabaseClient.auth.currentUser;

  /// Stream that emits whenever the authentication state changes.
  Stream<AuthState> get onAuthStateChange =>
      _supabaseClient.auth.onAuthStateChange;

  /// Authenticates a user with email and password via Supabase.
  ///
  /// [email] - The user's email address.
  /// [password] - The user's password.
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Creates a new user account with email and password via Supabase.
  ///
  /// [email] - The user's email address.
  /// [password] - The user's password.
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signUp(email: email, password: password);
  }

  /// Authenticates a user via native Google Sign-In on mobile platforms.
  /// Requests email and profile scopes, obtains an ID token, and signs in with Supabase.
  /// Throws AuthException if authentication fails or if no ID token is found.
  Future<void> nativeGoogleSignIn() async {
    final webClientId = dotenv.env['WEB_CLIENT_ID'];
    final iosClientId = dotenv.env['IOS_CLIENT_ID'];
    final scopes = ['email', 'profile'];

    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      serverClientId: webClientId,
      clientId: iosClientId,
    );

    // Try cached credentials first (works silently on Android, only for returning users on iOS)
    // Fall back to full sign-in dialog if no cached credentials found
    GoogleSignInAccount? googleUser = await googleSignIn
        .attemptLightweightAuthentication();

    // Always shows account picker since cache is cleared
    await googleSignIn.signOut();

    googleUser ??= await googleSignIn.authenticate();

    // Get authorization with required scopes
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);

    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }

    await _supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
  }

  /// Signs out the currently authenticated user from Supabase.
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.signOut();
    await _supabaseClient.auth.signOut();
  }

  /// Deletes the currently authenticated user account via a Supabase edge function.
  /// Also signs out the user afterward.
  /// Does nothing if no user is authenticated.
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
