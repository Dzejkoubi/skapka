import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

enum BottomDialogType { basic, positive, negative }

class BottomDialog extends StatelessWidget {
  final BottomDialogType type;
  final String description;

  const BottomDialog({
    super.key,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getDialogConfig(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.medium),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.large,
          vertical: AppSpacing.medium,
        ),
        decoration: ShapeDecoration(
          gradient: config.backgroundGradient,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.large,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        child: Text(
          description,
          style: AppTextTheme.bodyMedium(
            context,
          ).copyWith(color: config.textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _DialogConfig _getDialogConfig(BuildContext context) {
    switch (type) {
      case BottomDialogType.basic:
        return _DialogConfig(
          backgroundGradient: AppGradients.secondaryPrimaryGradient(context),
          textColor: context.colors.text.normalLight,
        );
      case BottomDialogType.positive:
        return _DialogConfig(
          backgroundGradient: AppGradients.successGradient(context),
          textColor: context.colors.text.normalLight,
        );
      case BottomDialogType.negative:
        return _DialogConfig(
          backgroundGradient: AppGradients.errorGradient(context),
          textColor: context.colors.text.normalLight,
        );
    }
  }

  /// Show bottom dialog as a snackbar
  static void show(
    BuildContext context, {
    required BottomDialogType type,
    required String description,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Dismiss any existing snackbars with animation
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Small delay to allow fade out animation
    Future.delayed(const Duration(milliseconds: 100), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: BottomDialog(type: type, description: description),
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          dismissDirection: DismissDirection.down,
          animation: CurvedAnimation(
            parent: const AlwaysStoppedAnimation(0),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });
  }
}

class _DialogConfig {
  final Gradient backgroundGradient;
  final Color textColor;

  _DialogConfig({required this.backgroundGradient, required this.textColor});
}
