import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' hide IconAlignment;
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_radius.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SignInWithAppleButton(
      style: SignInWithAppleButtonStyle.white,
      height: 48,
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.small,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
      text: context.localizations.welcome_screen_sign_in_with_apple_button_text,
      onPressed: onPressed,
    );
  }
}
