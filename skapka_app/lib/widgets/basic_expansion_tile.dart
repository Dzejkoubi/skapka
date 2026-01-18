import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:figma_squircle/figma_squircle.dart';

class BasicExpansionTile extends StatelessWidget {
  final Widget child;
  final Color? customBorderColor;
  final String title;
  final CrossAxisAlignment expandedCrossAxisAlignment;
  const BasicExpansionTile({
    this.customBorderColor,
    required this.child,
    required this.title,
    this.expandedCrossAxisAlignment = CrossAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final border = SmoothRectangleBorder(
      side: BorderSide(
        color: customBorderColor ?? context.colors.background.medium,
        width: 1.5,
      ),
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.medium,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        expandedCrossAxisAlignment: expandedCrossAxisAlignment,
        shape: border,
        collapsedShape: border,
        backgroundColor: context.colors.background.light,
        collapsedBackgroundColor: context.colors.background.light,
        title: Row(
          children: [Text(title, style: AppTextTheme.titleMedium(context))],
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.small,
        ),
        children: [child],
      ),
    );
  }
}
