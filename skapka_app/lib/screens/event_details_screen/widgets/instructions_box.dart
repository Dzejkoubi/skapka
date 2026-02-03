import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';

class InstructionsBox extends StatelessWidget {
  const InstructionsBox({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.medium,
      children: [
        Text(
          textAlign: TextAlign.center,
          AppLocalizations.of(
            context,
          )!.create_edit_event_screen_instructions_text,
          style: AppTextTheme.titleLarge(context),
        ),
        Container(
          decoration: AppDecorations.primaryContainer(context),
          padding: EdgeInsets.all(AppSpacing.small),
          width: double.infinity,
          child: MarkdownBody(
            data: event.instructions!,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h1: AppTextTheme.titleMedium(context),
              h2: AppTextTheme.titleSmall(context),
              h3: AppTextTheme.bodyLargeBold(context),
              p: AppTextTheme.bodyMedium(context),
              strong: AppTextTheme.bodyMediumBold(context),
              listBullet: AppTextTheme.bodyMedium(context),
              horizontalRuleDecoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.colors.background.medium,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
