import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class CustomNavBarItemInfo {
  final String label;
  final String iconAsset;
  final PageRouteInfo screenRoute;
  CustomNavBarItemInfo({
    required this.label,
    required this.iconAsset,
    required this.screenRoute,
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
    Color contentColor = isActive
        ? context.colors.accent.normal
        : context.colors.text.normalLight;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              navBarItemInfo.iconAsset,
              colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
            ),
            const SizedBox(height: AppSpacing.xxSmall),
            Text(
              navBarItemInfo.label,
              style: AppTextTheme.navbar(context).copyWith(color: contentColor),
            ),
          ],
        ),
      ),
    );
  }
}
