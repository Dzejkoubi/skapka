import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';

class AppDecorations {
  static ShapeDecoration primaryContainer(
    BuildContext context, {
    Color? borderColor,
  }) {
    return ShapeDecoration(
      color: context.colors.background.light,
      shape: SmoothRectangleBorder(
        side: BorderSide(
          color: borderColor ?? context.colors.background.medium,
          width: 1.0,
        ),
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppRadius.medium,
          cornerSmoothing: AppRadius.smoothNormal,
        ),
      ),
    );
  }

  static ShapeDecoration secondaryContainer(
    BuildContext context, {
    Color? borderColor,
  }) {
    return ShapeDecoration(
      color: context.colors.background.lightX,
      shape: SmoothRectangleBorder(
        side: BorderSide(
          color: borderColor ?? context.colors.background.mediumLight,
          width: 1.0,
        ),
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppRadius.medium,
          cornerSmoothing: AppRadius.smoothNormal,
        ),
      ),
    );
  }
}
