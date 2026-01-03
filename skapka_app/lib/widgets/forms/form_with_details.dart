import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

class FormWithDetails extends StatelessWidget {
  final TextEditingController _textController;
  final String labelText;
  final String descriptionText;
  const FormWithDetails({
    super.key,
    required TextEditingController textController,
    required this.labelText,
    required this.descriptionText,
  }) : _textController = textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xSmall),
      child: Column(
        spacing: AppSpacing.medium,
        children: [
          CustomForm(
            controller: _textController,
            labelText: labelText,
            characterLimit: 50,
            showSuffixIcon: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xSmall),
            child: Text(
              descriptionText,
              style: AppTextTheme.bodySmall(
                context,
              ).copyWith(color: context.colors.text.muted),
            ),
          ),
        ],
      ),
    );
  }
}
