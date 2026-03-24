import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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

  /// Authenticates a user via native Apple Sign-In on iOS or macOS.
  /// Requests email and full name, obtains an ID token with nonce, and signs in with Supabase.
  /// Updates user metadata with name information on first sign-in.
  /// Throws AuthException if authentication fails or if no ID token is found.
  Future<AuthResponse> signInWithApple() async {
    final rawNonce = supabaseClient.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
        'Could not find ID Token from generated credential.',
      );
    }

    final authResponse = await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );

    // Apple only provides the user's full name on the first sign-in
    // Save it to user metadata if available
    if (credential.givenName != null || credential.familyName != null) {
      final nameParts = <String>[];
      if (credential.givenName != null) nameParts.add(credential.givenName!);
      if (credential.familyName != null) nameParts.add(credential.familyName!);

      final fullName = nameParts.join(' ');

      await supabaseClient.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': fullName,
            'given_name': credential.givenName,
            'family_name': credential.familyName,
          },
        ),
      );
    }

    return authResponse;
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
