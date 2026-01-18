import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final bool expands;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines,
    this.expands = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      expands: expands,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      onChanged: onChanged,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      cursorColor: context.colors.primary.dark,
      style: AppTextTheme.bodyMedium(context),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: AppRadius.large,
            cornerSmoothing: AppRadius.smoothNormal,
          ),
          borderSide: BorderSide(
            color: context.colors.background.medium,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: AppRadius.medium,
            cornerSmoothing: AppRadius.smoothNormal,
          ),
          borderSide: BorderSide(
            color: context.colors.primary.dark,
            width: 2.0,
          ),
        ),
        hintText: hintText,
        hintStyle: AppTextTheme.bodyMedium(
          context,
        ).copyWith(color: context.colors.text.muted),
      ),
    );
  }
}
