import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

enum BottomDialogType { basic, positive, negative }

class BottomDialog {
  static void show(
    BuildContext context, {
    required BottomDialogType type,
    required String description,
  }) {
    final config = _getDialogConfig(context, type);

    DelightToastBar(
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: config.backgroundGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ToastCard(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            description,
            style: AppTextTheme.bodyMedium(
              context,
            ).copyWith(color: config.textColor, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ).show(context);
  }

  static _DialogConfig _getDialogConfig(
    BuildContext context,
    BottomDialogType type,
  ) {
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
}

class _DialogConfig {
  final Gradient backgroundGradient;
  final Color textColor;

  _DialogConfig({required this.backgroundGradient, required this.textColor});
}
