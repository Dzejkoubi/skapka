import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/dependents/leader_dependent_model.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/buttons/switch_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

class EditLeadersLeaderBox extends StatelessWidget {
  final LeaderDependentModel? leader;
  final DependentModel? dependent;
  final VoidCallback? onRefresh;

  EditLeadersLeaderBox({super.key, this.leader, this.dependent, this.onRefresh})
    : assert(
        (leader != null && dependent == null) ||
            (leader == null && dependent != null),
        'You must provide either a leader OR a dependent, but not both.',
      );

  DependentModel get _dependent => leader?.dependent ?? dependent!;
  final SupabaseService supabaseService = SupabaseService();

  Future<void> _toggleLeaderStatus(BuildContext context) async {
    final loadingProvider = context.read<LoadingProvider>();
    final isLeader = _dependent.isLeader;

    if (isLeader && (leader?.leaderOfPatrolId.isNotEmpty ?? false)) {
      BottomDialog.show(
        context,
        type: BottomDialogType.negative,
        description: context
            .localizations
            .admin_panel_screen_edit_leaders_remove_error_assigned_patrols,
      );
      return;
    }

    try {
      loadingProvider.show();
      if (isLeader) {
        await supabaseService.removeLeaderStatus(_dependent.dependentId);
      } else {
        await supabaseService.addLeaderStatus(_dependent.dependentId);
      }

      if (context.mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description: isLeader
              ? context.localizations
                    .admin_panel_screen_edit_leaders_status_removed(
                      "${_dependent.name} ${_dependent.surname}",
                    )
              : context.localizations
                    .admin_panel_screen_edit_leaders_status_added(
                      "${_dependent.name} ${_dependent.surname}",
                    ),
        );
        onRefresh?.call();
      }
    } catch (e) {
      debugPrint('Error toggling leader status: $e');
      if (context.mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description: context
              .localizations
              .admin_panel_screen_edit_leaders_update_error,
        );
      }
    } finally {
      loadingProvider.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.small,
        vertical: AppSpacing.small,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text('${_dependent.name} ${_dependent.surname}'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: AppSpacing.xSmall,
            children: [
              if (_dependent.isLeader)
                MainButton.outlined(
                  text: '',
                  type: ButtonType.icon,
                  iconAsset: 'assets/icons/users-group.svg',
                  onPressed: () {
                    context.router.push(
                      SetPatrolLeaderRoute(dependent: _dependent),
                    );
                  },
                  variant: (leader?.leaderOfPatrolId.isNotEmpty ?? false)
                      ? ButtonStylesVariants.success
                      : ButtonStylesVariants.destructive,
                ),
              SwitchButton(
                value: _dependent.isLeader,
                onChanged: (value) => _toggleLeaderStatus(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
