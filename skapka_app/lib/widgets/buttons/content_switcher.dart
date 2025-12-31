import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class ContentSwitcher extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onChanged;

  const ContentSwitcher({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: CustomSlidingSegmentedControl<int>(
        initialValue: selectedIndex,
        children: {
          for (int i = 0; i < items.length; i++)
            i: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
              child: Text(
                items[i],
                style: AppTextTheme.titleSmall(context).copyWith(
                  color: i == selectedIndex
                      ? context.colors.text.normalReversed
                      : context.colors.primary.normal,
                ),
              ),
            ),
        },
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: SmoothRectangleBorder(
            side: BorderSide(color: context.colors.primary.normal, width: 1),
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.medium,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        thumbDecoration: ShapeDecoration(
          color: context.colors.primary.normal,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.small,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
          shadows: [
            BoxShadow(
              color: context.colors.shadow.shadow10,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        onValueChanged: (value) => onChanged(value),
        padding: AppSpacing.xSmall,
      ),
    );
  }
}
