import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';

class ParticipantRow extends StatelessWidget {
  final DependentModel dependent;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const ParticipantRow({
    super.key,
    required this.dependent,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxSmall),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            activeColor: context.colors.primary.normal,
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: AppRadius.xxSmall,
                cornerSmoothing: AppRadius.smoothNormal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${dependent.name} ${dependent.surname}',
              style: AppTextTheme.bodyMedium(context),
            ),
          ),
          if (dependent.is18plus)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.small),
              child: SvgPicture.asset(
                'assets/icons/rating-18-plus-yellow-fill.svg',
                width: AppSizes.iconSizeSmall,
                height: AppSizes.iconSizeSmall,
              ),
            ),
          if (dependent.isArchived ?? false)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.small),
              child: SvgPicture.asset(
                'assets/icons/archive-red-fill.svg',
                width: AppSizes.iconSizeSmall,
                height: AppSizes.iconSizeSmall,
              ),
            ),
        ],
      ),
    );
  }
}
