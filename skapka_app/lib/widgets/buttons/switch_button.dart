import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';

class SwitchButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchButton({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.secondaryContainer(context),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SwitchOption(
            isSelected: value,
            iconAsset: 'assets/icons/check.svg',
            activeBackgroundColor: context.colors.success.normal,
            activeIconColor: context.colors.text.normalDark,
            onTap: () => onChanged(true),
          ),
          const SizedBox(width: 4),
          _SwitchOption(
            isSelected: !value,
            iconAsset: 'assets/icons/x.svg',
            activeBackgroundColor: context.colors.error.normal,
            activeIconColor: context.colors.text.normalLight,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

class _SwitchOption extends StatelessWidget {
  final bool isSelected;
  final String iconAsset;
  final Color activeBackgroundColor;
  final Color activeIconColor;
  final VoidCallback onTap;

  const _SwitchOption({
    required this.isSelected,
    required this.iconAsset,
    required this.activeBackgroundColor,
    required this.activeIconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.small),
        decoration: ShapeDecoration(
          color: isSelected ? activeBackgroundColor : Colors.transparent,
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
            isSelected ? activeIconColor : context.colors.text.normal,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
