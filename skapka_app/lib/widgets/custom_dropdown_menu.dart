import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final T? initialSelection;
  final void Function(T?)? onSelected;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? leadingIcon;
  final Widget? label;
  final double? width;
  final EdgeInsets? expandedInsets;

  const CustomDropdownMenu({
    required this.dropdownMenuEntries,
    this.initialSelection,
    this.onSelected,
    this.hintText,
    this.controller,
    this.leadingIcon,
    this.label,
    this.width,
    this.expandedInsets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.medium,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
      borderSide: BorderSide(
        color: context.colors.background.medium,
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: SmoothBorderRadius(
        cornerRadius: AppRadius.medium,
        cornerSmoothing: AppRadius.smoothNormal,
      ),
      borderSide: BorderSide(color: context.colors.primary.dark, width: 2.0),
    );

    return DropdownMenu<T>(
      width: width,
      expandedInsets: expandedInsets,
      initialSelection: initialSelection,
      controller: controller,
      hintText: hintText,
      trailingIcon: SvgPicture.asset(
        'assets/icons/chevron-down.svg',
        colorFilter: ColorFilter.mode(
          context.colors.text.normal,
          BlendMode.srcIn,
        ),
      ),
      selectedTrailingIcon: SvgPicture.asset(
        'assets/icons/chevron-up.svg',
        colorFilter: ColorFilter.mode(
          context.colors.text.normal,
          BlendMode.srcIn,
        ),
      ),
      label: label,
      leadingIcon: leadingIcon,
      textStyle: AppTextTheme.bodyMedium(context),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: border,
        focusedBorder: focusedBorder,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.small,
          vertical: AppSpacing.xSmall,
        ),
        hintStyle: AppTextTheme.bodyMedium(
          context,
        ).copyWith(color: context.colors.text.muted),
        filled: true,
        fillColor: context.colors.background.light,
      ),
      dropdownMenuEntries: dropdownMenuEntries,
      onSelected: (value) {
        Gaimon.selection();
        onSelected?.call(value);
      },
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(
          context.colors.background.light,
        ),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(8),
        shadowColor: WidgetStateProperty.all(context.colors.shadow.shadow10),
        shape: WidgetStateProperty.all(
          SmoothRectangleBorder(
            side: BorderSide(color: context.colors.background.medium, width: 1),
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.medium,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
      ),
    );
  }
}
