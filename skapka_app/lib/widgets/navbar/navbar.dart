import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/concave_clipper.dart';
import 'package:skapka_app/widgets/navbar/navbar_item.dart';

class Navbar extends StatelessWidget {
  final List<CustomNavBarItemInfo> items;
  final int activeIndex;
  final Function(int index)? onItemSelected;

  static const double bottomRadius = 36.0;
  static const double barHeight = 96.0;

  const Navbar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipPath(
                  clipper: ConcaveClipper(topRight: bottomRadius),
                  child: Container(
                    height: bottomRadius,
                    width: bottomRadius,
                    color: context.colors.primary.normal,
                  ),
                ),
                Expanded(child: Container(color: Colors.transparent)),
                ClipPath(
                  clipper: ConcaveClipper(topLeft: bottomRadius),
                  child: Container(
                    height: bottomRadius,
                    width: bottomRadius,
                    color: context.colors.primary.normal,
                  ),
                ),
              ],
            ),
            Container(
              color: context.colors.primary.normal,
              height: barHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int index = 0; index < 2; index++)
                          NavbarItem(
                            index: index,
                            navBarItemInfo: items[index],
                            isActive: index == activeIndex,
                            onTap: () => onItemSelected?.call(index),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int index = 2; index < items.length; index++)
                          NavbarItem(
                            index: index,
                            navBarItemInfo: items[index],
                            isActive: index == activeIndex,
                            onTap: () => onItemSelected?.call(index),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onDoubleTap: () => Gaimon.heavy(),
            child: SvgPicture.asset(
              height: 76,
              'assets/images/logos/scout-logo-white-without-text.svg',
            ),
          ),
        ),
      ],
    );
  }
}
