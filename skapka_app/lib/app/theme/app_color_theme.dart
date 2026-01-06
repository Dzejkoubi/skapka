import 'package:flutter/material.dart';

/// Background color category
class BackgroundColorCategory {
  final Color bgDark;
  final Color bgMediumDark;
  final Color medium;
  final Color mediumLight;
  final Color light;
  final Color lightX;

  const BackgroundColorCategory({
    required this.bgDark,
    required this.bgMediumDark,
    required this.medium,
    required this.mediumLight,
    required this.light,
    required this.lightX,
  });
}

/// Text color category
class TextColorCategory {
  final Color normalLight;
  final Color normalDark;
  final Color normal;
  final Color normalReversed;
  final Color mutedLight;
  final Color mutedDark;
  final Color muted;
  final Color mutedReversed;

  const TextColorCategory({
    required this.normalLight,
    required this.normalDark,
    required this.normal,
    required this.normalReversed,
    required this.mutedLight,
    required this.mutedDark,
    required this.muted,
    required this.mutedReversed,
  });
}

/// Primary color category
class PrimaryColorCategory {
  final Color dark;
  final Color dark50;
  final Color normal;
  final Color light;
  final Color light20;

  const PrimaryColorCategory({
    required this.dark,
    required this.dark50,
    required this.normal,
    required this.light,
    required this.light20,
  });
}

/// Secondary color category
class SecondaryColorCategory {
  final Color dark;
  final Color normal;
  final Color light;

  const SecondaryColorCategory({
    required this.dark,
    required this.normal,
    required this.light,
  });
}

/// Success color category
class SuccessColorCategory {
  final Color dark;
  final Color dark5;
  final Color normal;
  final Color normal5;
  final Color light;
  final Color light5;

  const SuccessColorCategory({
    required this.dark,
    required this.dark5,
    required this.normal,
    required this.normal5,
    required this.light,
    required this.light5,
  });
}

/// Error color category
class ErrorColorCategory {
  final Color dark;
  final Color dark5;
  final Color normal;
  final Color normal5;
  final Color light;
  final Color light5;

  const ErrorColorCategory({
    required this.dark,
    required this.dark5,
    required this.normal,
    required this.normal5,
    required this.light,
    required this.light5,
  });
}

/// Accent color category
class AccentColorCategory {
  final Color normal;

  const AccentColorCategory({required this.normal});
}

/// Shadow color category
class ShadowColorCategory {
  final Color shadow8;
  final Color shadow10;
  final Color shadow12;
  final Color shadow14;
  final Color shadow16;
  final Color shadow18;
  final Color shadow20;
  final Color shadow50;

  const ShadowColorCategory({
    required this.shadow8,
    required this.shadow10,
    required this.shadow12,
    required this.shadow14,
    required this.shadow16,
    required this.shadow18,
    required this.shadow20,
    required this.shadow50,
  });
}

/// Gradient color category
class GradientColorCategory {
  final Color grey0;
  final Color grey100;

  const GradientColorCategory({required this.grey0, required this.grey100});
}

/// Blur color category
class BlurColorCategory {
  final Color buttonReleased;
  final Color buttonPressed;

  const BlurColorCategory({
    required this.buttonReleased,
    required this.buttonPressed,
  });
}

/// Main theme class containing all color definitions for light and dark modes
class _AppColorTheme {
  final BackgroundColorCategory background;
  final TextColorCategory text;
  final PrimaryColorCategory primary;
  final SecondaryColorCategory secondary;
  final SuccessColorCategory success;
  final ErrorColorCategory error;
  final AccentColorCategory accent;
  final ShadowColorCategory shadow;
  final GradientColorCategory gradient;
  final BlurColorCategory blur;

  const _AppColorTheme({
    required this.background,
    required this.text,
    required this.primary,
    required this.secondary,
    required this.success,
    required this.error,
    required this.accent,
    required this.shadow,
    required this.gradient,
    required this.blur,
  });
}

/// Theme definitions
class _AppColorThemes {
  /// Light theme colors
  static const light = _AppColorTheme(
    background: BackgroundColorCategory(
      bgDark: Color(0xFFCCCCCC),
      bgMediumDark: Color(0xFFD9D9D9),
      medium: Color(0xFFE6E6E6),
      mediumLight: Color(0xFFF2F2F2),
      light: Color(0xFFFAFAFA),
      lightX: Color(0xFFFFFFFF),
    ),
    text: TextColorCategory(
      normalLight: Color(0xFFFCFCFC),
      normalDark: Color(0xFF0D0D0D),
      normal: Color(0xFF0D0D0D), // Uses normalDark in light theme
      normalReversed: Color(0xFFFCFCFC), // Uses normalLight in light theme
      mutedLight: Color(0xFFB3B3B3),
      mutedDark: Color(0xFF666666),
      muted: Color(0xFF666666), // Uses mutedDark in light theme
      mutedReversed: Color(0xFFB3B3B3), // Uses mutedLight in light theme
    ),
    primary: PrimaryColorCategory(
      dark: Color(0xFF204F88),
      dark50: Color(0x80204F88),
      normal: Color(0xFF255C9E),
      light: Color(0xFF2A67B2),
      light20: Color(0x332A67B2),
    ),
    secondary: SecondaryColorCategory(
      dark: Color(0xFF204F88),
      normal: Color(0xFF255C9E),
      light: Color(0xFF2A67B2),
    ),
    success: SuccessColorCategory(
      dark: Color(0xFF6D8F29),
      dark5: Color(0x0D6D8F29),
      normal: Color(0xFF7DA42F),
      normal5: Color(0x0D7DA42F),
      light: Color(0xFF8BB634),
      light5: Color(0x0D8BB634),
    ),
    error: ErrorColorCategory(
      dark: Color(0xFFA13626),
      dark5: Color(0x0DA13626),
      normal: Color(0xFFB03B29),
      normal5: Color(0x0DB03B29),
      light: Color(0xFFC6432F),
      light5: Color(0x0DC6432F),
    ),
    accent: AccentColorCategory(normal: Color(0xFFF9B200)),
    shadow: ShadowColorCategory(
      shadow8: Color(0x14000000), // 8% opacity black
      shadow10: Color(0x1A000000), // 10% opacity black
      shadow12: Color(0x1F000000), // 12% opacity black
      shadow14: Color(0x24000000), // 14% opacity black
      shadow16: Color(0x29000000), // 16% opacity black
      shadow18: Color(0x2E000000), // 18% opacity black
      shadow20: Color(0x33000000), // 20% opacity black
      shadow50: Color(0x80000000), // 50% opacity black
    ),
    gradient: GradientColorCategory(
      grey0: Color(0x00FCFCFC), // 0% opacity white
      grey100: Color(0xFFFCFCFC), // 100% opacity grey
    ),
    blur: BlurColorCategory(
      buttonReleased: Color(0x4DA1A1A1), // 30% opacity
      buttonPressed: Color(0x4D404040), // 30% opacity
    ),
  );

  /// Dark theme colors
  static const dark = _AppColorTheme(
    background: BackgroundColorCategory(
      bgDark: Color(0xFF333333),
      bgMediumDark: Color(0xFF4D4D4D),
      medium: Color(0xFF666666),
      mediumLight: Color(0xFF808080),
      light: Color(0xFF1A1A1A),
      lightX: Color(0xFF262626),
    ),
    text: TextColorCategory(
      normalLight: Color(0xFFFCFCFC),
      normalDark: Color(0xFF0D0D0D),
      normal: Color(0xFFFCFCFC), // Uses normalLight in dark theme
      normalReversed: Color(0xFF0D0D0D), // Uses normalDark in dark theme
      mutedLight: Color(0xFFB3B3B3),
      mutedDark: Color(0xFF666666),
      muted: Color(0xFFB3B3B3), // Uses mutedLight in dark theme
      mutedReversed: Color(0xFF666666), // Uses mutedDark in dark theme
    ),
    primary: PrimaryColorCategory(
      dark: Color(0xFF183C67),
      dark50: Color(0x80183C67),
      normal: Color(0xFF1D487C),
      light: Color(0xFF225490),
      light20: Color(0x33225490),
    ),
    secondary: SecondaryColorCategory(
      dark: Color(0xFF0A1829),
      normal: Color(0xFF133053),
      light: Color(0xFF3178CE),
    ),
    success: SuccessColorCategory(
      dark: Color(0xFF6D8F29),
      dark5: Color(0x0D6D8F29),
      normal: Color(0xFF7DA42F),
      normal5: Color(0x0D7DA42F),
      light: Color(0xFF8BB634),
      light5: Color(0x0D8BB634),
    ),
    error: ErrorColorCategory(
      dark: Color(0xFFA13626),
      dark5: Color(0x0DA13626),
      normal: Color(0xFFB03B29),
      normal5: Color(0x0DB03B29),
      light: Color(0xFFC6432F),
      light5: Color(0x0DC6432F),
    ),
    accent: AccentColorCategory(normal: Color(0xFFE5A400)),
    shadow: ShadowColorCategory(
      shadow8: Color(0x14FFFFFF), // 8% opacity white
      shadow10: Color(0x1AFFFFFF), // 10% opacity white
      shadow12: Color(0x1FFFFFFF), // 12% opacity white
      shadow14: Color(0x24FFFFFF), // 14% opacity white
      shadow16: Color(0x29FFFFFF), // 16% opacity white
      shadow18: Color(0x2EFFFFFF), // 18% opacity white
      shadow20: Color(0x33FFFFFF), // 20% opacity white
      shadow50: Color(0x80000000), // 50% opacity black
    ),
    gradient: GradientColorCategory(
      grey0: Color(0x00262626), // 0% opacity white
      grey100: Color(0xFF262626), // 100% opacity grey (same in both themes)
    ),
    blur: BlurColorCategory(
      buttonReleased: Color(0x4D404040), // 30% opacity dark grey
      buttonPressed: Color(
        0x4D404040,
      ), // 30% opacity dark grey (same in dark theme)
    ),
  );
}

/// Global accessor for app colors that automatically adapts to theme
class AppColorTheme {
  static _AppColorTheme? _currentTheme;

  /// Initialize with a theme mode
  static void init(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    _currentTheme = brightness == Brightness.light
        ? _AppColorThemes.light
        : _AppColorThemes.dark;
  }

  /// Update current theme
  static void updateTheme(Brightness brightness) {
    _currentTheme = brightness == Brightness.dark
        ? _AppColorThemes.dark
        : _AppColorThemes.light;
  }

  /// Get current theme colors
  static _AppColorTheme get _theme {
    return _currentTheme ?? _AppColorThemes.light;
  }

  /// Background colors - automatically uses current theme
  static BackgroundColorCategory get background => _theme.background;

  /// Text colors - automatically uses current theme
  static TextColorCategory get text => _theme.text;

  /// Primary colors - automatically uses current theme
  static PrimaryColorCategory get primary => _theme.primary;

  /// Secondary colors - automatically uses current theme
  static SecondaryColorCategory get secondary => _theme.secondary;

  /// Success colors - automatically uses current theme
  static SuccessColorCategory get success => _theme.success;

  /// Error colors - automatically uses current theme
  static ErrorColorCategory get error => _theme.error;

  /// Accent colors - automatically uses current theme
  static AccentColorCategory get accent => _theme.accent;

  /// Shadow colors - automatically uses current theme
  static ShadowColorCategory get shadow => _theme.shadow;

  /// Gradient colors - automatically uses current theme
  static GradientColorCategory get gradient => _theme.gradient;

  /// Blur colors - automatically uses current theme
  static BlurColorCategory get blur => _theme.blur;
}

/// Extension to easily access and update colors from BuildContext
extension AppColorThemeExtension on BuildContext {
  /// Get colors (ensures theme is synced)
  _AppColorTheme get colors {
    final brightness = Theme.of(this).brightness;
    AppColorTheme.updateTheme(brightness);
    return AppColorTheme._theme;
  }
}
