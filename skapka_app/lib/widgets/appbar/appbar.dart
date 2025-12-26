import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class Appbar extends StatelessWidget {
  final bool showBackChevron;
  final bool showScreenName;
  final bool showSettingsIcon;
  final String? screenName;
  const Appbar({
    required this.showBackChevron,
    required this.showScreenName,
    required this.showSettingsIcon,
    this.screenName = 'screenName',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.primary.light,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackChevron)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset(
                'assets/icons/chevron-left.svg',
                width: AppSizes.iconSizeMedium,
                height: AppSizes.iconSizeMedium,
                colorFilter: ColorFilter.mode(
                  context.colors.text.normalLight,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            const SizedBox(width: AppSizes.iconSizeMedium),
          if (showScreenName)
            Text(
              screenName!,
              style: AppTextTheme.displayMedium(
                context,
              ).copyWith(color: context.colors.text.normalLight),
            )
          else
            const SizedBox.shrink(),
          if (showSettingsIcon)
            GestureDetector(
              onTap: () {
                // Navigate to settings screen TODO
              },
              child: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: AppSizes.iconSizeMedium,
                height: AppSizes.iconSizeMedium,
                colorFilter: ColorFilter.mode(
                  context.colors.text.normalLight,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            const SizedBox(width: AppSizes.iconSizeMedium),
        ],
      ),
    );
  }
}
