import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:figma_squircle/figma_squircle.dart';

class BasicExpansionTile extends StatefulWidget {
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
  State<BasicExpansionTile> createState() => _BasicExpansionTileState();
}

class _BasicExpansionTileState extends State<BasicExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final border = SmoothRectangleBorder(
      side: BorderSide(
        color: widget.customBorderColor ?? context.colors.background.medium,
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
        onExpansionChanged: (value) {
          // If new state opened
          if (value == true && !_isExpanded) {
            Gaimon.soft();
          }
          // If new state closed
          else if (value == false && _isExpanded) {
            Gaimon.rigid();
          }
          setState(() {
            _isExpanded = value;
          });
        },
        expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
        shape: border,
        collapsedShape: border,
        backgroundColor: context.colors.background.light,
        collapsedBackgroundColor: context.colors.background.light,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(widget.title, style: AppTextTheme.titleMedium(context)),
            ],
          ),
        ),

        trailing: AnimatedRotation(
          turns: _isExpanded ? 0 : 0.5,
          duration: const Duration(milliseconds: 200),
          child: SvgPicture.asset(
            'assets/icons/chevron-up.svg',
            colorFilter: ColorFilter.mode(
              context.colors.text.normal,
              BlendMode.srcIn,
            ),
            width: AppSizes.iconSizeSmall,
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.small,
        ),
        children: [widget.child],
      ),
    );
  }
}
