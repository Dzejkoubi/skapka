import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/providers/language_provider.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';

class SetAppLanguageDropdownMenu extends StatelessWidget {
  const SetAppLanguageDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      spacing: AppSpacing.medium,
      children: [
        Text(
          context.localizations.settings_screen_app_language_dropdown_title,
          style: AppTextTheme.titleMedium(context),
        ),
        // Settings for app language
        CustomDropdownMenu(
          onSelected: (locale) {
            if (locale != null) {
              languageProvider.setLocale(Locale(locale));
            }
          },
          expandedInsets: EdgeInsets.zero,
          initialSelection: languageProvider.locale?.languageCode,
          dropdownMenuEntries: [
            DropdownMenuEntry(
              value: 'cs',
              label: context.localizations.settings_screen_app_language_czech,
              labelWidget: Text(
                context.localizations.settings_screen_app_language_czech,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: CountryFlag.fromPhonePrefix(
                '+420',
                theme: const ImageTheme(
                  shape: Rectangle(),
                  height: 24.0,
                  width: 36.0,
                ),
              ),
            ),
            DropdownMenuEntry(
              value: 'en',
              label: context.localizations.settings_screen_app_language_english,
              labelWidget: Text(
                context.localizations.settings_screen_app_language_english,
                style: AppTextTheme.bodyMedium(context),
              ),
              leadingIcon: CountryFlag.fromPhonePrefix(
                '+44',
                theme: const ImageTheme(
                  shape: Rectangle(),
                  height: 24.0,
                  width: 36.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
