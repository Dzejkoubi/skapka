import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

/// Example usage of MainButton widget
class MainButtonExamples extends StatelessWidget {
  const MainButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============ Using Factory Constructors ============
            const Text(
              'Factory Constructors (Easiest)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Primary filled button
            MainButton.filled(
              text: 'Primary Button',
              onPressed: () => print('Filled button pressed'),
            ),
            const SizedBox(height: 12),

            // Outlined button
            MainButton.outlined(
              text: 'Secondary Button',
              onPressed: () => print('Outlined button pressed'),
            ),
            const SizedBox(height: 12),

            // Text button
            MainButton.text(
              text: 'Text Button',
              onPressed: () => print('Text button pressed'),
            ),
            const SizedBox(height: 12),

            // Destructive button
            MainButton.filled(
              text: 'Delete',
              variant: ButtonStylesVariants.destructive,
              onPressed: () => print('Delete pressed'),
            ),
            const SizedBox(height: 32),

            // ============ With Icons ============
            const Text(
              'Buttons with Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Button with text and icon
            MainButton.filled(
              text: 'Add Item',
              type: ButtonType.textIcon,
              iconAsset: 'assets/icons/tabler_icons/plus.png',
              onPressed: () => print('Add item pressed'),
            ),
            const SizedBox(height: 12),

            // Icon only button
            MainButton.outlined(
              text: '', // Required but not shown
              type: ButtonType.icon,
              iconAsset: 'assets/icons/tabler_icons/settings.png',
              onPressed: () => print('Settings pressed'),
            ),
            const SizedBox(height: 32),

            // ============ Different Variants ============
            const Text(
              'Color Variants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Success button
            MainButton.filled(
              text: 'Save',
              variant: ButtonStylesVariants.success,
              onPressed: () => print('Save pressed'),
            ),
            const SizedBox(height: 12),

            // White button (for dark backgrounds)
            Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16),
              child: MainButton.outlined(
                text: 'White Button',
                variant: ButtonStylesVariants.white,
                onPressed: () => print('White button pressed'),
              ),
            ),
            const SizedBox(height: 32),

            // ============ Disabled State ============
            const Text(
              'Disabled Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            MainButton(
              style: ButtonStyleTypes.filled,
              variant: ButtonStylesVariants.normal,
              state: ButtonState.disabled,
              text: 'Disabled Button',
              onPressed: null, // No callback
            ),
            const SizedBox(height: 12),

            MainButton(
              style: ButtonStyleTypes.outlined,
              variant: ButtonStylesVariants.normal,
              state: ButtonState.disabled,
              text: 'Disabled Outlined',
              onPressed: null,
            ),
            const SizedBox(height: 32),

            // ============ Custom Configuration ============
            const Text(
              'Custom Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Full control with all parameters
            MainButton(
              style: ButtonStyleTypes.outlined,
              variant: ButtonStylesVariants.success,
              state: ButtonState.released,
              type: ButtonType.textIcon,
              text: 'Custom Button',
              iconAsset: 'assets/icons/tabler_icons/check.png',
              onPressed: () => print('Custom pressed'),
            ),
            const SizedBox(height: 32),

            // ============ All Combinations Grid ============
            const Text(
              'All Style Combinations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Normal variant
            _buildVariantSection('Normal', ButtonStylesVariants.normal),
            const SizedBox(height: 16),

            // Success variant
            _buildVariantSection('Success', ButtonStylesVariants.success),
            const SizedBox(height: 16),

            // Destructive variant
            _buildVariantSection(
              'Destructive',
              ButtonStylesVariants.destructive,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariantSection(String title, ButtonStylesVariants variant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        MainButton(
          style: ButtonStyleTypes.filled,
          variant: variant,
          text: 'Filled $title',
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        MainButton(
          style: ButtonStyleTypes.outlined,
          variant: variant,
          text: 'Outlined $title',
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        MainButton(
          style: ButtonStyleTypes.text,
          variant: variant,
          text: 'Text $title',
          onPressed: () {},
        ),
      ],
    );
  }
}

// ============================================================================
// QUICK REFERENCE
// ============================================================================

/*

BUTTON STYLES (Structure):
- ButtonStyleTypes.filled   → Background + Shadow
- ButtonStyleTypes.outlined → Border only
- ButtonStyleTypes.text     → No background or border

BUTTON VARIANTS (Colors):
- ButtonStylesVariants.normal      → Blue
- ButtonStylesVariants.white       → White
- ButtonStylesVariants.success     → Green
- ButtonStylesVariants.destructive → Red

BUTTON TYPES (Content):
- ButtonType.text     → Text only
- ButtonType.icon     → Icon only
- ButtonType.textIcon → Text + Icon

BUTTON STATES:
- ButtonState.released  → Normal state (default)
- ButtonState.pressed   → Active/pressed (handled automatically)
- ButtonState.disabled  → Disabled state

USAGE PATTERNS:

1. Simple filled button:
   MainButton.filled(
     text: 'Click Me',
     onPressed: () {},
   )

2. Outlined destructive:
   MainButton.outlined(
     text: 'Delete',
     variant: ButtonStylesVariants.destructive,
     onPressed: () {},
   )

3. Button with icon:
   MainButton.filled(
     text: 'Add',
     type: ButtonType.textIcon,
     iconAsset: 'assets/icons/plus.png',
     onPressed: () {},
   )

4. Disabled button:
   MainButton(
     style: ButtonStyleTypes.filled,
     variant: ButtonStylesVariants.normal,
     state: ButtonState.disabled,
     text: 'Disabled',
     onPressed: null,
   )

*/
