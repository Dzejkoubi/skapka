import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_shadow.dart';

/// Button Theme System
///
/// This system separates button styling into two orthogonal concerns:
///
/// 1. **ButtonStyleTypes** (Structure): Determines if button has background, border, or neither
///    - filled: Has background + shadow, no border
///    - outlined: Has border, no background
///    - text: No background or border
///
/// 2. **ButtonStylesVariants** (Colors): Determines the color scheme
///    - normal: Blue colors
///    - white: White background/border
///    - success: Green colors
///    - destructive: Red colors
///
/// Key behavior: Filled buttons always have white text (or dark for white variant),
/// while outlined and text buttons have colored text matching their variant.
///
/// Usage examples:
/// ```dart
/// // Create a theme
/// var theme = MainButtonTheme(
///   styleType: ButtonStyleTypes.filled,
///   styleVariant: ButtonStylesVariants.destructive,
/// );
///
///
/// // Get colors and properties
/// Color bgColor = theme.getBackgroundColor(ButtonState.released);
/// Color textColor = theme.getTextColor(ButtonState.pressed);
/// bool hasBg = theme.hasBackground(ButtonState.released);
/// ```

// Style type of the button
enum ButtonStyleTypes { filled, outlined, text }

// Style variants of usage of the button
enum ButtonStylesVariants { normal, white, success, destructive }

// State of the button - changes when the user interacts with it
enum ButtonState { released, pressed, disabled }

// Abstract class that defines the style configuration for each button style type
// This determines the STRUCTURE (background/border/shadow)
abstract class MainButtonStyleTypeConfig {
  bool hasBackground(ButtonState state);
  bool hasBorder(ButtonState state);
  List<BoxShadow>? getBoxShadow(ButtonState state, BuildContext context);
  double opacity(ButtonState state);

  // Factory constructor - creates the right style class based on enum
  factory MainButtonStyleTypeConfig(ButtonStyleTypes styleType) {
    switch (styleType) {
      case ButtonStyleTypes.outlined:
        return OutlinedButtonStyleConfig();
      case ButtonStyleTypes.text:
        return TextButtonStyleConfig();
      case ButtonStyleTypes.filled:
        return FilledButtonStyleConfig();
    }
  }
}

// Abstract class that defines the color configuration for each button variant
// This determines the COLORS based on the variant and style type
abstract class MainButtonStyleVariantConfig {
  // Get colors based on button type (filled needs different text color)
  Color getBackgroundColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  );
  Color getBorderColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  );
  Color getTextColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  );
  Color getIconColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  );

  // Factory constructor - creates the right variant class based on enum
  factory MainButtonStyleVariantConfig(ButtonStylesVariants styleVariant) {
    switch (styleVariant) {
      case ButtonStylesVariants.normal:
        return NormalButtonStyleVariantConfig();
      case ButtonStylesVariants.white:
        return WhiteButtonStyleVariantConfig();
      case ButtonStylesVariants.success:
        return SuccessButtonStyleVariantConfig();
      case ButtonStylesVariants.destructive:
        return DestructiveButtonStyleVariantConfig();
    }
  }
}

// ============================================================================
// STYLE TYPE IMPLEMENTATIONS (Structure: background/border/shadow)
// ============================================================================

class FilledButtonStyleConfig implements MainButtonStyleTypeConfig {
  @override
  bool hasBackground(ButtonState state) => true;

  @override
  bool hasBorder(ButtonState state) => false;

  @override
  List<BoxShadow>? getBoxShadow(ButtonState state, BuildContext context) {
    if (state == ButtonState.disabled) return null;
    if (state == ButtonState.pressed) return [AppShadow.innerXSmall(context)];
    return [AppShadow.outerXSmall(context)];
  }

  @override
  double opacity(ButtonState state) {
    if (state == ButtonState.disabled) return 50.0;
    return 100.0;
  }
}

class OutlinedButtonStyleConfig implements MainButtonStyleTypeConfig {
  @override
  bool hasBackground(ButtonState state) => false;

  @override
  bool hasBorder(ButtonState state) => true;

  @override
  List<BoxShadow>? getBoxShadow(ButtonState state, BuildContext context) =>
      null;

  @override
  double opacity(ButtonState state) {
    if (state == ButtonState.disabled) return 50.0;
    return 100.0;
  }
}

class TextButtonStyleConfig implements MainButtonStyleTypeConfig {
  @override
  bool hasBackground(ButtonState state) => false;

  @override
  bool hasBorder(ButtonState state) => false;

  @override
  List<BoxShadow>? getBoxShadow(ButtonState state, BuildContext context) =>
      null;
  @override
  double opacity(ButtonState state) {
    if (state == ButtonState.disabled) return 50.0;
    return 100.0;
  }
}

// ============================================================================
// STYLE VARIANT IMPLEMENTATIONS (Colors based on variant and type)
// ============================================================================

class NormalButtonStyleVariantConfig implements MainButtonStyleVariantConfig {
  @override
  Color getBackgroundColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.primary.dark;
    return context.colors.primary.light; // released
  }

  @override
  Color getBorderColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.medium;
    }
    if (state == ButtonState.pressed) return context.colors.primary.dark;
    return context.colors.primary.light;
  }

  @override
  Color getTextColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    // Filled buttons have white text, others have colored text
    if (styleType == ButtonStyleTypes.filled) {
      return state == ButtonState.disabled
          ? context.colors.text.muted
          : context.colors.text.normalLight;
    } else {
      // Outlined and text buttons
      if (state == ButtonState.disabled) return context.colors.text.muted;
      if (state == ButtonState.pressed) return context.colors.primary.dark;
      return context.colors.primary.light;
    }
  }

  @override
  Color getIconColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    // Same logic as text color
    return getTextColor(state, styleType, context);
  }
}

class WhiteButtonStyleVariantConfig implements MainButtonStyleVariantConfig {
  @override
  Color getBackgroundColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.text.mutedLight;
    return context.colors.text.normalLight;
  }

  @override
  Color getBorderColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.text.mutedLight;
    }
    if (state == ButtonState.pressed) return context.colors.text.mutedLight;
    return context.colors.background.lightX;
  }

  @override
  Color getTextColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (styleType == ButtonStyleTypes.filled) {
      // Filled white button has dark text
      return state == ButtonState.disabled
          ? context.colors.text.muted
          : context.colors.primary.light;
    } else {
      // Outlined and text white buttons
      if (state == ButtonState.disabled) return context.colors.text.mutedLight;
      if (state == ButtonState.pressed) return context.colors.text.mutedLight;
      return context.colors.text.normalLight;
    }
  }

  @override
  Color getIconColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    return getTextColor(state, styleType, context);
  }
}

class SuccessButtonStyleVariantConfig implements MainButtonStyleVariantConfig {
  @override
  Color getBackgroundColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.success.dark;
    return context.colors.success.normal;
  }

  @override
  Color getBorderColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.success.dark;
    return context.colors.success.normal;
  }

  @override
  Color getTextColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (styleType == ButtonStyleTypes.filled) {
      return state == ButtonState.disabled
          ? context.colors.text.muted
          : context.colors.text.normalLight;
    } else {
      if (state == ButtonState.disabled) return context.colors.text.muted;
      if (state == ButtonState.pressed) return context.colors.success.dark;
      return context.colors.success.normal;
    }
  }

  @override
  Color getIconColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    return getTextColor(state, styleType, context);
  }
}

class DestructiveButtonStyleVariantConfig
    implements MainButtonStyleVariantConfig {
  @override
  Color getBackgroundColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.error.dark;
    return context.colors.error.normal;
  }

  @override
  Color getBorderColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (state == ButtonState.disabled) {
      return context.colors.background.bgMediumDark;
    }
    if (state == ButtonState.pressed) return context.colors.error.dark;
    return context.colors.error.normal;
  }

  @override
  Color getTextColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    if (styleType == ButtonStyleTypes.filled) {
      return state == ButtonState.disabled
          ? context.colors.text.muted
          : context.colors.text.normalLight;
    } else {
      if (state == ButtonState.disabled) return context.colors.text.muted;
      if (state == ButtonState.pressed) return context.colors.error.dark;
      return context.colors.error.normal;
    }
  }

  @override
  Color getIconColor(
    ButtonState state,
    ButtonStyleTypes styleType,
    BuildContext context,
  ) {
    return getTextColor(state, styleType, context);
  }
}

// ============================================================================
// MAIN BUTTON THEME - Combines type and variant configurations
// ============================================================================

class MainButtonTheme {
  final ButtonStyleTypes styleType;
  final ButtonStylesVariants styleVariant;
  final BuildContext context;

  late final MainButtonStyleTypeConfig _typeConfig;
  late final MainButtonStyleVariantConfig _variantConfig;

  MainButtonTheme({
    required this.styleType,
    required this.styleVariant,
    required this.context,
  }) {
    _typeConfig = MainButtonStyleTypeConfig(styleType);
    _variantConfig = MainButtonStyleVariantConfig(styleVariant);
  }

  // Structure methods (from type config)
  bool hasBackground(ButtonState state) => _typeConfig.hasBackground(state);
  bool hasBorder(ButtonState state) => _typeConfig.hasBorder(state);
  List<BoxShadow>? getBoxShadow(ButtonState state) =>
      _typeConfig.getBoxShadow(state, context);
  double getOpacity(ButtonState state) => _typeConfig.opacity(state) / 100.0;

  // Color methods (from variant config) - now using context
  Color getBackgroundColor(ButtonState state) =>
      _variantConfig.getBackgroundColor(state, styleType, context);

  Color getBorderColor(ButtonState state) =>
      _variantConfig.getBorderColor(state, styleType, context);

  Color getTextColor(ButtonState state) =>
      _variantConfig.getTextColor(state, styleType, context);

  Color getIconColor(ButtonState state) =>
      _variantConfig.getIconColor(state, styleType, context);
}
