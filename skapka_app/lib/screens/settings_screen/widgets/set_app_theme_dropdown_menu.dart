import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/providers/theme_provider.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';

class SetAppThemeDropdownMenu extends StatelessWidget {
  const SetAppThemeDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      spacing: AppSpacing.medium,
      children: [
        Text(
          context.localizations.settings_screen_app_motive_dropdown_title,
          style: AppTextTheme.titleMedium(context),
        ),
        // Settings for app motive
        CustomDropdownMenu<ThemeMode>(
          expandedInsets: EdgeInsets.zero,
          initialSelection: themeProvider.themeMode,
          onSelected: (ThemeMode? value) {
            if (value != null) {
              themeProvider.setThemeMode(value);
            }
          },
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: ThemeMode.light,
              label: context.localizations.settings_screen_app_motive_light,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_light,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/sun-high.svg',
                height: AppSizes.iconSizeSmall,
                colorFilter: ColorFilter.mode(
                  context.colors.text.normal,
                  BlendMode.srcIn,
                ),
              ),
            ),
            DropdownMenuEntry(
              value: ThemeMode.dark,
              label: context.localizations.settings_screen_app_motive_dark,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_dark,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/moon-stars.svg',
                height: AppSizes.iconSizeSmall,
                colorFilter: ColorFilter.mode(
                  context.colors.text.normal,
                  BlendMode.srcIn,
                ),
              ),
            ),
            DropdownMenuEntry(
              value: ThemeMode.system,
              label: context.localizations.settings_screen_app_motive_system,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_system,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/brightness.svg',
                height: AppSizes.iconSizeSmall,
                colorFilter: ColorFilter.mode(
                  context.colors.text.normal,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
