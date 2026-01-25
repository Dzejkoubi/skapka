import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

@RoutePage()
class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              context.localizations.category_info_screen_title,
              style: AppTextTheme.titleLarge(context),
            ),
            Text(
              textAlign: TextAlign.center,
              context.localizations.category_info_screen_subtitle,
              style: AppTextTheme.bodyMedium(context),
            ),
          ],
        ),
      ),
    );
  }
}
