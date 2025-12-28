import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/concave_clipper.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackChevron;
  final bool backChevronCanPop;
  final bool showSettingsIcon;
  final String? screenName;

  static const double bottomRadius = 36.0;
  static const double topBarHeight = 64.0;

  const Appbar({
    required this.showBackChevron,
    required this.showSettingsIcon,
    this.backChevronCanPop = true,
    this.screenName = 'screenName',
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(topBarHeight + bottomRadius);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: topBarHeight,
          color: context.colors.primary.normal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBackChevron)
                GestureDetector(
                  onTap: () {
                    if (backChevronCanPop && Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
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
              if (screenName != null)
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
        ),
        Row(
          children: [
            ClipPath(
              clipper: ConcaveClipper(bottomRight: bottomRadius),
              child: Container(
                height: bottomRadius,
                width: bottomRadius,
                color: context.colors.primary.normal,
              ),
            ),
            Expanded(child: Container(color: Colors.transparent)),
            ClipPath(
              clipper: ConcaveClipper(bottomLeft: bottomRadius),
              child: Container(
                height: bottomRadius,
                width: bottomRadius,
                color: context.colors.primary.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
