import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

enum LargeDialogType { basic, positive, negative }

class LargeDialog extends StatelessWidget {
  final LargeDialogType type;
  final String title;
  final String description;
  final String primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  const LargeDialog({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getDialogConfig(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
      child: Stack(
        children: [
          // Bottom container - border color (larger)
          Container(
            decoration: ShapeDecoration(
              color: config.borderColor,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: AppRadius.xLarge,
                  cornerSmoothing: AppRadius.smoothNormal,
                ),
              ),
            ),
            padding: const EdgeInsets.all(2), // Border width
            child: Container(
              // Top container - background color (smaller, creates border effect)
              decoration: ShapeDecoration(
                color: config.backgroundColor,
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
                  // Icon
                  if (type != LargeDialogType.basic)
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(config.svgIconPath!),
                          SvgPicture.asset(
                            type == LargeDialogType.positive
                                ? 'assets/icons/check.svg'
                                : 'assets/icons/x.svg',
                            width: AppSizes.iconSizeXLarge,
                            height: AppSizes.iconSizeXLarge,
                            colorFilter: ColorFilter.mode(
                              config.contentColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppSpacing.large),

                  // Title
                  Text(
                    title,
                    style: AppTextTheme.titleMedium(
                      context,
                    ).copyWith(color: config.contentColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.small),

                  // Description
                  Text(
                    description,
                    style: AppTextTheme.bodySmall(
                      context,
                    ).copyWith(color: config.contentColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.large),

                  // Secondary button text (if exists)
                  if (secondaryButtonText != null) ...[
                    MainButton.text(
                      text: secondaryButtonText!,
                      onPressed: onSecondaryPressed,
                      variant: config.buttonVariant,
                    ),
                    const SizedBox(height: AppSpacing.small),
                  ],

                  // Primary button
                  MainButton.filled(
                    text: primaryButtonText,
                    onPressed: onPrimaryPressed,
                    variant: config.buttonVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _DialogConfig _getDialogConfig(BuildContext context) {
    switch (type) {
      case LargeDialogType.basic:
        return _DialogConfig(
          borderColor: context.colors.secondary.normal,
          backgroundColor: context.colors.secondary.normal,
          contentColor: context.colors.text.normalLight,
          buttonVariant: ButtonStylesVariants.white,
          svgIconPath: null,
        );
      case LargeDialogType.positive:
        return _DialogConfig(
          borderColor: context.colors.success.normal,
          backgroundColor: context.colors.background.light,
          contentColor: context.colors.text.normal,
          buttonVariant: ButtonStylesVariants.success,
          svgIconPath: 'assets/images/shapes/circle-shape-1.svg',
        );
      case LargeDialogType.negative:
        return _DialogConfig(
          borderColor: context.colors.error.normal,
          backgroundColor: context.colors.background.light,
          contentColor: context.colors.text.normal,
          buttonVariant: ButtonStylesVariants.destructive,
          svgIconPath: 'assets/images/shapes/circle-shape-2.svg',
        );
    }
  }
}

class _DialogConfig {
  final Color borderColor;
  final Color backgroundColor;
  final Color contentColor;
  final String? svgIconPath;
  final ButtonStylesVariants buttonVariant;

  _DialogConfig({
    required this.borderColor,
    required this.backgroundColor,
    required this.contentColor,
    required this.svgIconPath,
    required this.buttonVariant,
  });
}
