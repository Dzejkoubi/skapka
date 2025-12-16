import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class CustomForm extends StatefulWidget {
  final bool isActive;
  final TextEditingController controller;
  final String labelText;
  final bool showSuffixIcon;
  final String? suffixIconAsset;
  final VoidCallback? onSuffixPressed;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final int? characterLimit;
  final String? errorText;
  const CustomForm({
    super.key,
    this.isActive = true,
    required this.controller,
    required this.labelText,
    this.showSuffixIcon = true,
    this.suffixIconAsset = 'assets/icons/x.svg',
    this.onSuffixPressed,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.characterLimit,
    this.errorText,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    final isDisabled = !widget.isActive;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: TextField(
          enabled: widget.isActive,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          cursorColor: hasError
              ? context.colors.error.normal
              : context.colors.primary.dark,
          maxLength: widget.characterLimit,
          style: _getTextStyle(isDisabled),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSpacing.small,
              horizontal: AppSpacing.medium,
            ),
            labelText: widget.labelText,
            labelStyle: _getLabelStyle(isDisabled, _isFocused, hasError),
            floatingLabelStyle: _getFloatingLabelStyle(_isFocused, hasError),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIcon: _buildSuffixIcon(),
            counterText: '',
            filled: true,
            fillColor: context.colors.background.mediumLight,
            errorText: widget.errorText,
            errorStyle: AppTextTheme.bodySmall(
              context,
            ).copyWith(color: context.colors.error.normal),
            hintFadeDuration: Duration(milliseconds: 150),
            // State 1: Enabled but empty (not active/filled)
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: BorderSide(
                color: hasError
                    ? context.colors.error.normal
                    : context.colors.background.medium,
                width: 1,
              ),
            ),
            // State 3: Selected/Focused (keyboard up, writing inside)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: BorderSide(
                color: hasError
                    ? context.colors.error.normal
                    : context.colors.primary.normal,
                width: 2,
              ),
            ),
            // State 5: Disabled (cannot write)
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: BorderSide(
                color: context.colors.background.bgMediumDark,
                width: 1,
              ),
            ),
            // State 4: Error (not focused)
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: BorderSide(
                color: context.colors.error.normal,
                width: 1,
              ),
            ),
            // State 4: Error (focused)
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              borderSide: BorderSide(
                color: context.colors.error.normal,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Get text style based on state
  TextStyle _getTextStyle(bool isDisabled) {
    return AppTextTheme.bodyMedium(context).copyWith(
      color: isDisabled
          ? context.colors.text.muted
          : context.colors.text.normal,
    );
  }

  // Get label style based on state
  TextStyle _getLabelStyle(bool isDisabled, bool isFocused, bool hasError) {
    Color labelColor;

    if (isDisabled) {
      // State 5: Disabled
      labelColor = context.colors.text.muted;
    } else if (hasError && !isFocused) {
      // State 4: Error
      labelColor = context.colors.error.normal;
    } else if (isFocused) {
      // State 3: Focused
      labelColor = context.colors.primary.normal;
    } else {
      // States 1 & 2: Enabled
      labelColor = context.colors.text.muted;
    }

    return AppTextTheme.bodyMedium(context).copyWith(color: labelColor);
  }

  // Get floating label style (when label is above field)
  TextStyle _getFloatingLabelStyle(bool isFocused, bool hasError) {
    Color labelColor;

    if (hasError) {
      // State 4: Error
      labelColor = context.colors.error.normal;
    } else if (isFocused) {
      // State 3: Focused
      labelColor = context.colors.primary.normal;
    } else {
      // States 1 & 2: Not focused
      labelColor = context.colors.text.muted;
    }

    return AppTextTheme.bodySmall(context).copyWith(
      color: labelColor,
      backgroundColor: context.colors.background.mediumLight,
    );
  }

  _buildSuffixIcon() {
    if (widget.showSuffixIcon && widget.controller.text.isNotEmpty) {
      return GestureDetector(
        onTap: widget.onSuffixPressed,
        child: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.medium),
          child: SvgPicture.asset(
            widget.suffixIconAsset!,
            width: AppSizes.iconSizeXSmall,
            height: AppSizes.iconSizeXSmall,
            colorFilter: ColorFilter.mode(
              context.colors.text.muted,
              BlendMode.srcIn,
            ),
          ),
        ),
      );
    } else {
      return null;
    }
  }
}
