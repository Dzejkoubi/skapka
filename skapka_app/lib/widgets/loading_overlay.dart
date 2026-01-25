import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';

class LoadingOverlay extends StatelessWidget {
  final String? loadingText;
  const LoadingOverlay({this.loadingText, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: context.colors.shadow.shadow50,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LoadingRotatingLogo(),
              if (loadingText != null && loadingText!.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: AppSpacing.medium),
                    Text(
                      loadingText ?? '',
                      style: AppTextTheme.titleSmall(
                        context,
                      ).copyWith(color: context.colors.text.normalLight),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
