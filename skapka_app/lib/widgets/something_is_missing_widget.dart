import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class SomethingIsMissingWidget extends StatelessWidget {
  final String subtitle;
  const SomethingIsMissingWidget({required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    String getRandomTitle() {
      final titles = [
        context.localizations.something_is_missing_title_1,
        context.localizations.something_is_missing_title_2,
      ];
      titles.shuffle();
      return titles.first;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getRandomTitle(),
          style: AppTextTheme.titleMedium(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          subtitle,
          style: AppTextTheme.bodyMedium(
            context,
          ).copyWith(color: context.colors.text.muted),
          textAlign: TextAlign.center,
        ),
      ],
    );
    ;
  }
}
