import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';

class GoBackBar extends StatelessWidget {
  final bool canPop;
  const GoBackBar({required this.canPop, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.primary.light,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (canPop)
            GestureDetector(
              onTap: () {
                if (canPop && Navigator.of(context).canPop()) {
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
            ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
