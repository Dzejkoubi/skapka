import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/widgets/navbar/navbar_item.dart';

class Navbar extends StatelessWidget {
  final List<CustomNavBarItemInfo> items;
  final int activeIndex;
  final Function(int index)? onItemSelected;

  const Navbar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colors.primary.normal,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => NavbarItem(
                index: index,
                navBarItemInfo: items[index],
                isActive: index == activeIndex,
                onTap: () => onItemSelected?.call(index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
