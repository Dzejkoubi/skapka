import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';

class AppTextTheme {
  static const String fontFamilyTheMixC5 = 'TheMixC5';
  static const String fontFamilyNunito = 'Nunito';

  // Display
  static TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );
  static TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );
  static TextStyle displaySmall = TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );

  // Title
  static TextStyle titleLarge = TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );
  static TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );
  static TextStyle titleSmall = TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0,
    height: 1.32,
    color: AppColorTheme.text.normal,
  );

  // Body
  static TextStyle bodyLarge = TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );

  // Body bold
  static TextStyle bodyLargeBold = TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle bodyMediumBold = TextStyle(
    fontSize: 16,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle bodySmallBold = TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );

  // Label
  static TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );
  static TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );

  // CTA
  static TextStyle cta = TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColorTheme.text.normal,
  );

  static TextStyle navbar = TextStyle(
    fontSize: 12,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColorTheme.text.normalLight,
  );
}
