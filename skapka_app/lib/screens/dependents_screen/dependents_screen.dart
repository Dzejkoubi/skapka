import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/screens/dependents_screen/widgets/dependent_box.dart';

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
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppSpacing.large,
                    children: [
                      // Display only non-archived dependents
                      for (var dependent in provider.dependents.where(
                        (d) => d.isArchived != true,
                      ))
                        DependentBox(
                          dependent: dependent,
                          unitsProvider: unitsProvider,
                        ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.small),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     MainButton.filled(
                  //       type: ButtonType.textIcon,
                  //       iconAsset: 'assets/icons/user-plus.svg',
                  //       text: context
                  //           .localizations
                  //           .dependents_screen_add_dependent_button_text,
                  //       onPressed: () {
                  //         BottomDialog.show(
                  //           context,
                  //           type: BottomDialogType.basic,
                  //           description: context
                  //               .localizations
                  //               .common_this_feature_not_implemented,
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
