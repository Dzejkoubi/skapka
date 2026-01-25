import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';

class ThreeStateButton extends StatelessWidget {
  static const int valueX = 0;
  static const int valueCheck = 1;
  static const int valueCrown = 2;

  final int value;
  final ValueChanged<int> onChanged;
  final bool isXEnabled;
  final bool isCheckEnabled;
  final bool isCrownEnabled;

  const ThreeStateButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.isXEnabled = true,
    this.isCheckEnabled = true,
    this.isCrownEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.secondaryContainer(context),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Check (1)
          _SwitchOption(
            isSelected: value == valueCheck,
            isEnabled: isCheckEnabled,
            iconAsset: 'assets/icons/check.svg',
            activeBackgroundColor: context.colors.success.normal,
            activeIconColor: context.colors.text.normalDark,
            onTap: () {
              if (value != valueCheck && isCheckEnabled) onChanged(valueCheck);
            },
          ),
          const SizedBox(width: 4),
          // X (0)
          _SwitchOption(
            isSelected: value == valueX,
            isEnabled: isXEnabled,
            iconAsset: 'assets/icons/x.svg',
            activeBackgroundColor: context.colors.error.normal,
            activeIconColor: context.colors.text.normalLight,
            onTap: () {
              if (value != valueX && isXEnabled) onChanged(valueX);
            },
          ),
          const SizedBox(width: 4),
          // Crown (2)
          _SwitchOption(
            isSelected: value == valueCrown,
            isEnabled: isCrownEnabled,
            iconAsset: 'assets/icons/crown.svg',
            activeBackgroundColor: context.colors.accent.normal,
            activeIconColor: context.colors.text.normalDark,
            onTap: () {
              if (value != valueCrown && isCrownEnabled) onChanged(valueCrown);
            },
          ),
        ],
      ),
    );
  }
}

class _SwitchOption extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final String iconAsset;
  final Color activeBackgroundColor;
  final Color activeIconColor;
  final VoidCallback onTap;

  const _SwitchOption({
    required this.isSelected,
    required this.isEnabled,
    required this.iconAsset,
    required this.activeBackgroundColor,
    required this.activeIconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.small),
        decoration: ShapeDecoration(
          color: isSelected && isEnabled
              ? activeBackgroundColor
              : Colors.transparent,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.medium,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        child: SvgPicture.asset(
          iconAsset,
          width: AppSizes.iconSizeSmall,
          height: AppSizes.iconSizeSmall,
          colorFilter: ColorFilter.mode(
            isEnabled
                ? (isSelected ? activeIconColor : context.colors.text.normal)
                : context.colors.text.muted,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
