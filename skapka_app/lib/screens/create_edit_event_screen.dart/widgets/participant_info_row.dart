import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class ParticipantInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isScrollable;

  const ParticipantInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isScrollable)
          Text(
            '$label:',
            style: AppTextTheme.bodyMedium(
              context,
            ).copyWith(color: context.colors.text.muted),
          )
        else
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                '$label:',
                style: AppTextTheme.bodyMedium(
                  context,
                ).copyWith(color: context.colors.text.muted),
              ),
            ),
          ),
        const SizedBox(width: AppSpacing.medium),
        if (isScrollable)
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(value, style: AppTextTheme.bodyMedium(context)),
            ),
          )
        else
          Text(value, style: AppTextTheme.bodyMedium(context)),
      ],
    );
  }
}
