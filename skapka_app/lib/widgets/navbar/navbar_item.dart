import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class CustomNavBarItemInfo {
  final String label;
  final String iconAsset;
  final PageRouteInfo screenRoute;
  final List<SpeedDialChild>? speedDialChildren;
  CustomNavBarItemInfo({
    required this.label,
    required this.iconAsset,
    required this.screenRoute,
    this.speedDialChildren,
  });
}

class NavbarItem extends StatelessWidget {
  final CustomNavBarItemInfo navBarItemInfo;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const NavbarItem({
    super.key,
    required this.navBarItemInfo,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color targetColor = isActive
        ? context.colors.accent.normal
        : context.colors.text.normalLight;

    return GestureDetector(
      onTap: () {
        onTap();
        Gaimon.soft();
      },
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder<Color?>(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        tween: ColorTween(end: targetColor),
        builder: (context, color, child) {
          return AnimatedScale(
            scale: isActive ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  height: AppSizes.iconSizeSmall,
                  navBarItemInfo.iconAsset,
                  colorFilter: ColorFilter.mode(
                    color ?? targetColor,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxSmall),
                Text(
                  navBarItemInfo.label,
                  style: AppTextTheme.navbar(
                    context,
                  ).copyWith(color: color ?? targetColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
