import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

/// Configuration for a single input field inside a [LargeInputDialog].
class LargeInputDialogField {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool showSuffixIcon;

  /// Optional validator. Return an error string to block submission and show it
  /// under the field, or `null` when the value is valid.
  final String? Function(String? value)? validator;

  const LargeInputDialogField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.obscureText = false,
    this.showSuffixIcon = true,
    this.validator,
  });
}

/// A reusable input dialog styled like the basic [LargeDialog]: a primary
/// (blue) gradient border, blue background with light content, a centered title
/// and description, one or more input fields and primary / secondary buttons.
///
/// All texts are passed in as parameters; each input field carries its own
/// [TextEditingController].
class LargeInputDialog extends StatefulWidget {
  final String title;
  final String description;
  final List<LargeInputDialogField> fields;
  final String primaryButtonText;
  final String secondaryButtonText;

  /// Called when the primary button is pressed and all validators pass. While
  /// the returned future runs, the buttons and fields show a loading state.
  final Future<void> Function() onPrimaryPressed;

  /// Called when the secondary button is pressed. Defaults to popping the dialog.
  final VoidCallback? onSecondaryPressed;

  /// Whether the dialog shows the close (X) button.
  final bool canPop;

  const LargeInputDialog({
    super.key,
    required this.title,
    required this.description,
    required this.fields,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.canPop = true,
  });

  @override
  State<LargeInputDialog> createState() => _LargeInputDialogState();
}

class _LargeInputDialogState extends State<LargeInputDialog> {
  late List<String?> _errors;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _errors = List<String?>.filled(widget.fields.length, null);
    Gaimon.selection();
  }

  /// Validates all fields and calls the primary button callback if valid.
  Future<void> _handlePrimary() async {
    var hasError = false;
    final errors = <String?>[];
    for (final field in widget.fields) {
      final error = field.validator?.call(field.controller.text);
      errors.add(error);
      if (error != null) hasError = true;
    }
    setState(() => _errors = errors);
    if (hasError) return;

    setState(() => _isLoading = true);
    try {
      await widget.onPrimaryPressed();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _clearError(int index) {
    if (_errors[index] == null) return;
    setState(() => _errors[index] = null);
  }

  @override
  Widget build(BuildContext context) {
    final borderGradient = AppGradients.primaryGradient(context);
    final backgroundColor = context.colors.primary.normal;
    final contentColor = context.colors.text.normalLight;

    return PopScope(
      canPop: !_isLoading,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
        child: Stack(
          children: [
            // Bottom container - border gradient (larger)
            Container(
              decoration: ShapeDecoration(
                gradient: borderGradient,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: AppRadius.xLarge,
                    cornerSmoothing: AppRadius.smoothNormal,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(2), // Border width
              child: Container(
                // Top container - background color (creates the border effect)
                decoration: ShapeDecoration(
                  color: backgroundColor,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: AppRadius.xLarge - 2,
                      cornerSmoothing: AppRadius.smoothNormal,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppSpacing.large),

                    // Title
                    Text(
                      widget.title,
                      style: AppTextTheme.titleMedium(
                        context,
                      ).copyWith(color: contentColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.small),

                    // Description
                    Text(
                      widget.description,
                      style: AppTextTheme.bodySmall(
                        context,
                      ).copyWith(color: contentColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.large),

                    // Input fields
                    for (var i = 0; i < widget.fields.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.medium),
                      CustomForm(
                        controller: widget.fields[i].controller,
                        labelText: widget.fields[i].labelText,
                        keyboardType: widget.fields[i].keyboardType,
                        autofillHints: widget.fields[i].autofillHints,
                        obscureText: widget.fields[i].obscureText,
                        showSuffixIcon: widget.fields[i].showSuffixIcon,
                        isActive: !_isLoading,
                        errorText: _errors[i],
                        blueBackGroundColorMode: true,
                        onSuffixPressed: () {
                          widget.fields[i].controller.clear();
                          _clearError(i);
                        },
                      ),
                    ],
                    const SizedBox(height: AppSpacing.large),

                    // Secondary button
                    MainButton.text(
                      text: widget.secondaryButtonText,
                      variant: ButtonStylesVariants.white,
                      onPressed: _isLoading
                          ? null
                          : (widget.onSecondaryPressed ??
                                () => Navigator.of(context).pop()),
                    ),
                    const SizedBox(height: AppSpacing.small),

                    // Primary button
                    MainButton.filled(
                      text: _isLoading
                          ? context.localizations.loading
                          : widget.primaryButtonText,
                      variant: ButtonStylesVariants.white,
                      onPressed: _isLoading ? null : _handlePrimary,
                    ),
                  ],
                ),
              ),
            ),

            if (widget.canPop && !_isLoading)
              Positioned(
                top: 16.0,
                right: 16.0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    'assets/icons/x.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      contentColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
