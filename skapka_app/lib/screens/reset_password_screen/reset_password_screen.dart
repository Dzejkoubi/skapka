import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/utils/password_validator.dart';
import 'package:skapka_app/utils/two_passwords_validator.dart';
import 'package:skapka_app/widgets/appbar/go_back_bar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_floating_logo.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  /// Whether this screen was opened as a fresh entry from a deep link captured
  /// in `main.dart` (true) versus pushed on top of an existing screen (false).
  ///
  /// It only changes what "back" does: a pushed instance simply pops, while a
  /// deep-link entry has no screen beneath it, so it hands off to [AuthGate] —
  /// the wrapper that decides where the user belongs.
  final bool openedFromDeepLink;

  /// One-time recovery token parsed from the email link's `token_hash` query
  /// param. Passed through from the deep link so the recovery session can be
  /// verified (`verifyOtp`) before the new password is saved.
  final String? tokenHash;

  /// The OTP `type` from the email link (e.g. `recovery`).
  final String? type;

  const ResetPasswordScreen({
    super.key,
    this.openedFromDeepLink = false,
    this.tokenHash,
    this.type,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthService authService = AuthService();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;

  bool _isLoading = false;

  /// True while the recovery token is being verified (deep-link entry only).
  /// The password form stays hidden behind a loader until verification passes.
  bool _verifying = false;

  @override
  void initState() {
    super.initState();
    // A deep-link entry carries a one-time recovery token. Verify it after the
    // first frame: the args are on `widget` already, but _verifyOtp uses context
    // (localizations, dialogs), which is only safe once mounted and rendered.
    if (widget.openedFromDeepLink) {
      _verifying = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _verifyOtp(widget.tokenHash, widget.type);
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _verifyOtp(String? tokenHash, String? type) async {
    // Any failure here — missing token, expired or invalid link — means there's
    // no recovery session to set a password against. Treat them all the same:
    // a bad link. (gotrue returns `otp_expired` for both expired and invalid
    // tokens, so distinguishing them isn't reliable anyway.)
    var verified = false;
    try {
      if (tokenHash != null && type != null) {
        await authService.verifyOtp(tokenHash: tokenHash, type: type);
        verified = true;
      }
    } catch (e) {
      debugPrint('Recovery link verification failed: $e');
    }

    if (!mounted) return;

    if (verified) {
      // Token is valid — reveal the password form.
      setState(() => _verifying = false);
      return;
    }

    // Bad link: send the user to login and explain via a toast. BottomDialog
    // renders on the root navigator, so it survives the stack replace and shows
    // on arrival at the login screen, where they can request a fresh link.
    BottomDialog.show(
      context,
      type: BottomDialogType.negative,
      description:
          context.localizations.reset_password_screen_error_invalid_link,
    );
    context.router.replaceAll([WelcomeRoute(), const LoginRoute()]);
  }

  /// Handles the back action: pop when pushed over another screen, otherwise
  /// redirect to the wrapper when this was a standalone deep-link entry.
  void _handleBack() {
    if (_isLoading) return;
    if (widget.openedFromDeepLink) {
      context.router.replaceAll([const AuthGate()]);
    } else {
      context.router.maybePop();
    }
  }

  void _handleSave() async {
    setState(() {
      _passwordError = validatePassword(
        _passwordController.text,
        context: context,
      );
      _confirmPasswordError = validateTwoPasswords(
        _passwordController.text,
        _confirmPasswordController.text,
        context: context,
      );
    });

    if (_passwordError != null || _confirmPasswordError != null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await authService.updatePassword(password: _passwordController.text);

      // Reset succeeded. Sign out the recovery session so the user logs in
      // fresh with the new password; ignore sign-out errors since the reset
      // itself is already done.
      try {
        await authService.signOut();
      } catch (e) {
        debugPrint('Sign-out after password reset failed (ignored): $e');
      }

      if (!mounted) return;
      BottomDialog.show(
        context,
        type: BottomDialogType.positive,
        description: context.localizations.reset_password_screen_success,
      );
      // Send the user back to log in with their new password. Welcome sits
      // beneath login so "back" returns to it as usual.
      context.router.replaceAll([WelcomeRoute(), const LoginRoute()]);
    } on AuthException catch (e) {
      debugPrint('AuthException during password reset: ${e.code} ${e.message}');
      if (!mounted) return;

      String errorMessage;
      if (e.code == 'weak_password') {
        errorMessage =
            context.localizations.reset_password_screen_error_weak_password;
      } else if (e.code == 'same_password') {
        errorMessage =
            context.localizations.reset_password_screen_error_same_password;
      } else {
        errorMessage =
            context.localizations.reset_password_screen_error_generic;
      }

      BottomDialog.show(
        context,
        type: BottomDialogType.negative,
        description: errorMessage,
      );
    } catch (e) {
      debugPrint('Unexpected error during password reset: $e');
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description:
              context.localizations.reset_password_screen_error_generic,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// Loading view shown while the recovery token is being verified.
  Widget _buildVerifying(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.large),
          GoBackBar(canPop: true, onBack: _handleBack),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LoadingFloatingLogo(),
                  SizedBox(height: AppSpacing.large),
                  Text(
                    context.localizations.reset_password_screen_verifying,
                    style: AppTextTheme.bodyMedium(
                      context,
                    ).copyWith(color: context.colors.text.normalDark),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Block the system back while saving, and intercept it for a deep-link
      // entry so it redirects to the wrapper instead of leaving the app.
      canPop: !_isLoading && !widget.openedFromDeepLink,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop || _isLoading) return;
        if (widget.openedFromDeepLink) {
          context.router.replaceAll([const AuthGate()]);
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.primary.light,
        body: _verifying
            ? _buildVerifying(context)
            : ScrollableOnKeyboardScreenWrapper(
                builder: (constraints) {
                  return Column(
                    children: [
                      SizedBox(height: AppSpacing.large),
                      GoBackBar(canPop: !_isLoading, onBack: _handleBack),
                      SizedBox(height: AppSpacing.xLarge),
                      // Title with decorative shape
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset('assets/images/shapes/shape-2.svg'),
                          Text(
                            context.localizations.reset_password_screen_title,
                            style: AppTextTheme.displayLarge(
                              context,
                            ).copyWith(color: context.colors.text.normalDark),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.medium),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.large,
                        ),
                        child: Text(
                          context.localizations.reset_password_screen_subtitle,
                          textAlign: TextAlign.center,
                          style: AppTextTheme.bodyMedium(
                            context,
                          ).copyWith(color: context.colors.text.normalDark),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.large,
                        ),
                        child: Flex(
                          direction: Axis.vertical,
                          spacing: AppSpacing.medium,
                          children: [
                            CustomForm(
                              controller: _passwordController,
                              labelText: AppLocalizations.of(
                                context,
                              )!.reset_password_screen_new_password_hint,
                              errorText: _passwordError,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.newPassword],
                              obscureText: true,
                              onSuffixPressed: () {
                                _passwordController.clear();
                                setState(() {
                                  _passwordError = null;
                                });
                              },
                              blueBackGroundColorMode: true,
                            ),
                            CustomForm(
                              controller: _confirmPasswordController,
                              labelText: AppLocalizations.of(
                                context,
                              )!.reset_password_screen_confirm_password_hint,
                              errorText: _confirmPasswordError,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.newPassword],
                              obscureText: true,
                              onSuffixPressed: () {
                                _confirmPasswordController.clear();
                                setState(() {
                                  _confirmPasswordError = null;
                                });
                              },
                              blueBackGroundColorMode: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.xxLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.huge,
                        ),
                        child: MainButton.filled(
                          variant: ButtonStylesVariants.white,
                          text: _isLoading
                              ? context.localizations.loading
                              : context
                                    .localizations
                                    .reset_password_screen_save_button_text,
                          onPressed: !_isLoading ? _handleSave : null,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.15),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
