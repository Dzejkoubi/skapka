import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

@RoutePage()
/// Example widget demonstrating all button theme combinations
class ButtonThemeShowcaseScreen extends StatelessWidget {
  const ButtonThemeShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.background.light,
      appBar: AppBar(title: const Text('Button Theme Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Normal Variant
            _buildSection('Normal Variant', ButtonStylesVariants.normal),
            const SizedBox(height: 32),

            // White Variant
            _buildSection('White Variant', ButtonStylesVariants.white),
            const SizedBox(height: 32),

            // Success Variant
            _buildSection('Success Variant', ButtonStylesVariants.success),
            const SizedBox(height: 32),

            // Destructive Variant
            _buildSection(
              'Destructive Variant',
              ButtonStylesVariants.destructive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, ButtonStylesVariants variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Filled buttons
        const Text(
          'Filled',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _buttonGroup(variant, ButtonStyleTypes.filled, 'Filled'),
        const SizedBox(height: 16),

        // Outlined buttons
        const Text(
          'Outlined',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _buttonGroup(variant, ButtonStyleTypes.outlined, 'Outlined'),
        const SizedBox(height: 16),

        // Text buttons
        const Text(
          'Text',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _buttonGroup(variant, ButtonStyleTypes.text, 'Text'),
      ],
    );
  }

  Widget _buttonGroup(
    ButtonStylesVariants variant,
    ButtonStyleTypes type,
    String text,
  ) {
    return Column(
      children: [
        _buttonPair(
          variant: variant,
          type: type,
          text: text,
          buttonType: ButtonType.textIcon,
          iconAsset: 'assets/icons/tabler_icons/compass.svg',
        ),
        const SizedBox(height: 8),
        _buttonPair(
          variant: variant,
          type: type,
          text: text,
          buttonType: ButtonType.text,
        ),
        const SizedBox(height: 8),
        _buttonPair(
          variant: variant,
          type: type,
          text: text,
          buttonType: ButtonType.icon,
          iconAsset: 'assets/icons/tabler_icons/compass.svg',
        ),
      ],
    );
  }

  Widget _buttonPair({
    required ButtonStylesVariants variant,
    required ButtonStyleTypes type,
    required String text,
    required ButtonType buttonType,
    String? iconAsset,
  }) {
    return Row(
      children: [
        MainButton(
          style: type,
          variant: variant,
          text: text,
          type: buttonType,
          iconAsset: iconAsset,
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        MainButton(
          style: type,
          variant: variant,
          text: text,
          state: ButtonState.disabled,
          type: buttonType,
          iconAsset: iconAsset,
          onPressed: null,
        ),
      ],
    );
  }
}
