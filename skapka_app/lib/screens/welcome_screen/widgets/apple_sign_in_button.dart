import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MainButton.filled(
      variant: ButtonStylesVariants.white,
      type: ButtonType.icon,
      iconAsset: "assets/icons/brand-apple.svg",
      onPressed: onPressed,
      text: "",
      tintIcon: false,
    );
  }
}
