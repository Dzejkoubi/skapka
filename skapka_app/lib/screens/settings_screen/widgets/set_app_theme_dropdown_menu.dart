import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';

class SetAppThemeDropdownMenu extends StatelessWidget {
  const SetAppThemeDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.medium,
      children: [
        Text(
          context.localizations.settings_screen_app_motive_dropdown_title,
          style: AppTextTheme.titleMedium(context),
        ),
        // Settings for app motive
        CustomDropdownMenu(
          expandedInsets: EdgeInsets.zero,
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: 'light',
              label: context.localizations.settings_screen_app_motive_light,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_light,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/sun-high.svg',
                height: AppSizes.iconSizeSmall,
              ),
            ),
            DropdownMenuEntry(
              value: 'dark',
              label: context.localizations.settings_screen_app_motive_dark,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_dark,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/moon-stars.svg',
                height: AppSizes.iconSizeSmall,
              ),
            ),
            DropdownMenuEntry(
              value: 'system',
              label: context.localizations.settings_screen_app_motive_system,
              labelWidget: Text(
                context.localizations.settings_screen_app_motive_system,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: SvgPicture.asset(
                'assets/icons/brightness.svg',
                height: AppSizes.iconSizeSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
