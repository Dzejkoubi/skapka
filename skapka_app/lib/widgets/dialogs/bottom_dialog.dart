import 'package:delightful_toast/delight_toast.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_shadow.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

enum BottomDialogType { basic, positive, negative }

class BottomDialog {
  static bool _isToastShowing = false;
  static void show(
    BuildContext context, {
    required BottomDialogType type,
    required String description,
  }) {
    if (_isToastShowing) return;

    final config = _getDialogConfig(context, type);

    final rootContext = Navigator.of(
      context,
      rootNavigator: true,
    ).context; // Get root context to show toast above all other widgets

    _isToastShowing = true;

    Future.microtask(() {
      DelightToastBar? toast;

      toast = DelightToastBar(
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 8),
        builder: (context) => Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.large),
          decoration: ShapeDecoration(
            gradient: config.borderGradient,
            shadows: [AppShadow.outerSmall(context)],
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppRadius.large,
                cornerSmoothing: AppRadius.smoothNormal,
              ),
            ),
          ),
          padding: const EdgeInsets.all(2), // Border width
          child: Container(
            decoration: ShapeDecoration(
              color: config.backgroundColor,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.large - 2,
                  cornerSmoothing: AppRadius.smoothNormal,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.large,
              vertical: AppSpacing.medium,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: AppTextTheme.labelMedium(
                      context,
                    ).copyWith(color: config.textColor),
                  ),
                ),
                const SizedBox(width: AppSpacing.medium),
                GestureDetector(
                  onTap: () => toast?.remove(),
                  child: SvgPicture.asset(
                    'assets/icons/x.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      config.textColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      if (context.mounted) {
        toast.show(rootContext);
      }

      WidgetsBinding.instance.scheduleFrame();

      Future.delayed(const Duration(milliseconds: 2000), () {
        _isToastShowing = false;
      });
    });
  }

  static _DialogConfig _getDialogConfig(
    BuildContext context,
    BottomDialogType type,
  ) {
    switch (type) {
      case BottomDialogType.basic:
        return _DialogConfig(
          borderGradient: AppGradients.secondaryPrimaryGradient(context),
          textColor: context.colors.text.normalLight,
          backgroundColor: context.colors.secondary.normal,
        );
      case BottomDialogType.positive:
        return _DialogConfig(
          borderGradient: AppGradients.successGradient(context),
          textColor: context.colors.text.normalDark,
          backgroundColor: context.colors.success.normal,
        );
      case BottomDialogType.negative:
        return _DialogConfig(
          borderGradient: AppGradients.errorGradient(context),
          textColor: context.colors.text.normalLight,
          backgroundColor: context.colors.error.normal,
        );
    }
  }
}

class _DialogConfig {
  final Gradient borderGradient;
  final Color backgroundColor;
  final Color textColor;

  _DialogConfig({
    required this.borderGradient,
    required this.backgroundColor,
    required this.textColor,
  });
}
