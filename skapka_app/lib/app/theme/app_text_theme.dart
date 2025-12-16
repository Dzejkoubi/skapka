import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';

class AppTextTheme {
  static const String fontFamilyTheMixC5 = 'TheMixC5';
  static const String fontFamilyNunito = 'Nunito';

  // Helper method to get text color dynamically from context
  static Color _getTextColor(BuildContext context) =>
      context.colors.text.normal;

  // Display - now using methods that take context
  static TextStyle displayLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 40,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  static TextStyle displayMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  static TextStyle displaySmall(BuildContext context) => TextStyle(
    fontFamily: fontFamilyTheMixC5,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  // Title
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0,
    height: 1.32,
    color: _getTextColor(context),
  );

  // Body
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: 16,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  // Body bold
  static TextStyle bodyLargeBold(BuildContext context) => TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle bodyMediumBold(BuildContext context) => TextStyle(
    fontSize: 16,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle bodySmallBold(BuildContext context) => TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.4,
    color: _getTextColor(context),
  );

  // Label
  static TextStyle labelLarge(BuildContext context) => TextStyle(
    fontSize: 14,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
    fontSize: 12,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontSize: 10,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: _getTextColor(context),
  );

  // CTA
  static TextStyle cta(BuildContext context) => TextStyle(
    fontSize: 20,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
    height: 1.4,
    color: _getTextColor(context),
  );

  static TextStyle navbar(BuildContext context) => TextStyle(
    fontSize: 12,
    fontFamily: fontFamilyNunito,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.4,
    color: context.colors.text.normalLight,
  );
}
