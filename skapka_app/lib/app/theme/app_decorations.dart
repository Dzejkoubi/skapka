import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';

class AppDecorations {
  static ShapeDecoration primaryContainer(BuildContext context) {
    return ShapeDecoration(
      shape: SmoothRectangleBorder(
        side: BorderSide(color: context.colors.background.medium, width: 1.0),
        borderRadius: SmoothBorderRadius(
          cornerRadius: AppRadius.medium,
          cornerSmoothing: AppRadius.smoothNormal,
        ),
      ),
    );
  }
}
