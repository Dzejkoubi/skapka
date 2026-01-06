import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';

class AppGradients {
  static Gradient greyGradient(BuildContext context) => LinearGradient(
    colors: [context.colors.gradient.grey0, context.colors.gradient.grey100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient primaryGradient(BuildContext context) => LinearGradient(
    colors: [context.colors.primary.light, context.colors.primary.dark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient successGradient(BuildContext context) => LinearGradient(
    colors: [context.colors.success.dark, context.colors.success.light],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient errorGradient(BuildContext context) => LinearGradient(
    colors: [context.colors.error.dark, context.colors.error.light],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
