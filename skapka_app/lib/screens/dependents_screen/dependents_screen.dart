import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/dependents_screen/widgets/dependent_box.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

@RoutePage()
class DependentsScreen extends StatelessWidget {
  const DependentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UnitsProvider unitsProvider = Provider.of<UnitsProvider>(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Consumer<DependentsProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.bottomSpace + AppSpacing.large,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.large,
                children: [
                  for (var dependent in provider.dependents) ...[
                    DependentBox(
                      dependent: dependent,
                      unitsProvider: unitsProvider,
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainButton.filled(
                        type: ButtonType.textIcon,
                        iconAsset: 'assets/icons/user-plus.svg',
                        text: context
                            .localizations
                            .dependents_screen_add_dependent_button_text,
                        onPressed: () {
                          BottomDialog.show(
                            context,
                            type: BottomDialogType.basic,
                            description:
                                'Tato funkce ještě není implementována',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
