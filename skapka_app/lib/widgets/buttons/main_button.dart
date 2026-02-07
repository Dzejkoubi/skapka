import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';

// Type of the button - defines if it has text, icon or both
enum ButtonType { text, icon, textIcon }

class MainButton extends StatefulWidget {
  final ButtonStyleTypes style;
  final ButtonStylesVariants variant;
  final ButtonState state;
  final ButtonType type;
  final String text;
  final VoidCallback? onPressed;
  final String? iconAsset;

  const MainButton({
    super.key,
    required this.style,
    required this.variant,
    this.state = ButtonState.released,
    this.type = ButtonType.text,
    required this.text,
    this.onPressed,
    this.iconAsset,
  });

  // Convenience factory constructors for common button types
  factory MainButton.filled({
    required String text,
    required VoidCallback? onPressed,
    ButtonStylesVariants variant = ButtonStylesVariants.normal,
    ButtonType type = ButtonType.text,
    String? iconAsset,
  }) {
    return MainButton(
      style: ButtonStyleTypes.filled,
      variant: variant,
      text: text,
      onPressed: onPressed,
      type: type,
      iconAsset: iconAsset,
    );
  }

  factory MainButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    ButtonStylesVariants variant = ButtonStylesVariants.normal,
    ButtonType type = ButtonType.text,
    String? iconAsset,
  }) {
    return MainButton(
      style: ButtonStyleTypes.outlined,
      variant: variant,
      text: text,
      onPressed: onPressed,
      type: type,
      iconAsset: iconAsset,
    );
  }

  factory MainButton.text({
    required String text,
    required VoidCallback? onPressed,
    ButtonStylesVariants variant = ButtonStylesVariants.normal,
    ButtonType type = ButtonType.text,
    String? iconAsset,
  }) {
    return MainButton(
      style: ButtonStyleTypes.text,
      variant: variant,
      text: text,
      onPressed: onPressed,
      type: type,
      iconAsset: iconAsset,
    );
  }

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  late ButtonState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.state;
  }

  @override
  void didUpdateWidget(MainButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _currentState = widget.state;
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (_currentState != ButtonState.disabled) {
      Gaimon.soft();
      setState(() {
        _currentState = ButtonState.pressed;
      });
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_currentState != ButtonState.disabled) {
      setState(() {
        _currentState = ButtonState.released;
      });
    }
  }

  void _handleTapCancel() {
    if (_currentState != ButtonState.disabled) {
      setState(() {
        _currentState = ButtonState.released;
      });
    }
  }

  void _handleTap() {
    if (_currentState != ButtonState.disabled && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create theme with context for dynamic colors
    final theme = MainButtonTheme(
      styleType: widget.style,
      styleVariant: widget.variant,
      context: context,
    );

    // Icon-only buttons get smaller padding
    final isIconOnly = widget.type == ButtonType.icon;
    final horizontalPadding = isIconOnly
        ? AppSpacing.xSmall
        : AppSpacing.medium;
    final verticalPadding = isIconOnly ? AppSpacing.xSmall : AppSpacing.small;

    final buttonContainer = AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      opacity: theme.getOpacity(_currentState),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: ShapeDecoration(
          color: theme.hasBackground(_currentState)
              ? theme.getBackgroundColor(_currentState)
              : Colors.transparent,
          shape: SmoothRectangleBorder(
            side: theme.hasBorder(_currentState)
                ? BorderSide(
                    color: theme.getBorderColor(_currentState),
                    width: 1,
                  )
                : BorderSide.none,
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.small,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
          shadows: theme.getBoxShadow(_currentState),
        ),
        child: _buildButtonContent(theme),
      ),
    );

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: buttonContainer,
    );
  }

  Widget _buildButtonContent(MainButtonTheme theme) {
    final textColor = theme.getTextColor(_currentState);

    switch (widget.type) {
      case ButtonType.text:
        return Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            style: AppTextTheme.cta(context).copyWith(color: textColor),
            child: Text(widget.text),
          ),
        );

      case ButtonType.icon:
        if (widget.iconAsset == null) {
          throw Exception('iconAsset must be provided for ButtonType.icon');
        }
        return Center(
          child: TweenAnimationBuilder<Color?>(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            tween: ColorTween(end: textColor),
            builder: (context, color, child) {
              return SvgPicture.asset(
                widget.iconAsset!,
                width: AppSizes.iconSizeSmall,
                height: AppSizes.iconSizeSmall,
                colorFilter: ColorFilter.mode(
                  color ?? textColor,
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        );

      case ButtonType.textIcon:
        if (widget.iconAsset == null) {
          throw Exception('iconAsset must be provided for ButtonType.textIcon');
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              tween: ColorTween(end: textColor),
              builder: (context, color, child) {
                return SvgPicture.asset(
                  widget.iconAsset!,
                  width: AppSizes.iconSizeSmall,
                  height: AppSizes.iconSizeSmall,
                  colorFilter: ColorFilter.mode(
                    color ?? textColor,
                    BlendMode.srcIn,
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              style: AppTextTheme.cta(context).copyWith(color: textColor),
              child: Text(widget.text),
            ),
          ],
        );
    }
  }
}
