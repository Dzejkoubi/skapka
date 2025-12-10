import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';

class AppShadow {
  // Inner shadows
  static BoxShadow innerXSmall = BoxShadow(
    color: AppColorTheme.shadow.shadow8,
    blurRadius: 4,
    spreadRadius: -2,
    offset: const Offset(1, 1),
  );

  static BoxShadow innerSmall = BoxShadow(
    color: AppColorTheme.shadow.shadow20,
    blurRadius: 8,
    spreadRadius: -2,
    offset: const Offset(1, 1),
  );

  static BoxShadow innerMedium = BoxShadow(
    color: AppColorTheme.shadow.shadow18,
    blurRadius: 8,
    spreadRadius: -1,
    offset: const Offset(2, 2),
  );

  // Outer shadows
  static BoxShadow outerXSmall = BoxShadow(
    color: AppColorTheme.shadow.shadow8,
    blurRadius: 8,
    spreadRadius: -1,
    offset: const Offset(1, 1),
  );

  static BoxShadow outerSmall = BoxShadow(
    color: AppColorTheme.shadow.shadow10,
    blurRadius: 8,
    spreadRadius: 0,
    offset: const Offset(1, 1),
  );

  static BoxShadow outerMedium = BoxShadow(
    color: AppColorTheme.shadow.shadow12,
    blurRadius: 8,
    spreadRadius: 0,
    offset: const Offset(2, 2),
  );

  static BoxShadow outerLarge = BoxShadow(
    color: AppColorTheme.shadow.shadow14,
    blurRadius: 32,
    spreadRadius: 0,
    offset: const Offset(3, 3),
  );

  static BoxShadow outerXLarge = BoxShadow(
    color: AppColorTheme.shadow.shadow16,
    blurRadius: 32,
    spreadRadius: 2,
    offset: const Offset(4, 4),
  );
}
