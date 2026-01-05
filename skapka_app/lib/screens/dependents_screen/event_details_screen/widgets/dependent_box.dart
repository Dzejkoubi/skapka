import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/providers/units_provider.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

class DependentBox extends StatelessWidget {
  final AccountDependentModel dependent;
  final UnitsProvider unitsProvider;
  const DependentBox({
    super.key,
    required this.dependent,
    required this.unitsProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      padding: EdgeInsets.all(AppSpacing.medium),
      child: Column(
        spacing: AppSpacing.medium,
        children: [
          Text(
            '${dependent.dependentDetails?.name} ${dependent.dependentDetails?.surname}',
            style: AppTextTheme.titleSmall(context),
          ),
          Column(
            spacing: AppSpacing.xSmall,
            children: [
              // Nickname
              Row(
                children: [
                  Text(
                    context.localizations.dependents_screen_dependent_nickname,
                    style: AppTextTheme.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Text(
                    dependent.dependentDetails?.nickname ?? '-',
                    style: AppTextTheme.bodySmallBold(context),
                  ),
                ],
              ),
              // Patrol
              Row(
                children: [
                  Text(
                    context.localizations.dependents_screen_dependent_patrol,
                    style: AppTextTheme.bodySmall(context),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Text(
                    dependent.dependentDetails?.patrolId != null
                        ? unitsProvider.getPatrolNameById(
                                dependent.dependentDetails!.patrolId!,
                              ) ??
                              '-'
                        : '-',
                    style: AppTextTheme.bodySmallBold(context),
                  ),
                ],
              ),
            ],
          ),
          // Edit dependent's details button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton.outlined(
                variant: ButtonStylesVariants.normal,
                text: context
                    .localizations
                    .dependents_screen_dependent_notes_button_text,
                onPressed: () {
                  context.router.push(
                    EditDependentDetailsRoute(dependent: dependent),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
