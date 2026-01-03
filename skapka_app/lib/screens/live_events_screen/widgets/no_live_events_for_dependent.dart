import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class NoLiveEventsForDependent extends StatelessWidget {
  final String dependentName;
  const NoLiveEventsForDependent({required this.dependentName, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.localizations.live_events_screen_no_live_events_view_title,
          style: AppTextTheme.titleMedium(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.small),
        Text(
          context.localizations.live_events_screen_no_live_events_view_subtitle(
            dependentName,
          ),
          style: AppTextTheme.bodyMedium(
            context,
          ).copyWith(color: context.colors.text.muted),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
