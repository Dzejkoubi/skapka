import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/basic_expansion_tile.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';

class ConnectAccountsDependentsAccountBox extends StatelessWidget {
  const ConnectAccountsDependentsAccountBox({
    super.key,
    required this.accountDependents,
    required this.supabaseService,
    required this.loadingProvider,
    required this.account,
    required this.adminProvider,
    required this.loadData,
  });

  final Iterable<AccountDependentModel> accountDependents;
  final SupabaseService supabaseService;
  final LoadingProvider loadingProvider;
  final AccountModel account;
  final AdminPanelProvider adminProvider;
  final Future<void> Function({bool forceRefresh}) loadData;

  @override
  Widget build(BuildContext context) {
    void disconnectDependentFromAccount(
      AccountDependentModel dependent,
      AccountModel account,
      AdminPanelProvider adminProvider,
      SupabaseService supabaseService,
      LoadingProvider loadingProvider,
      BuildContext context,
    ) async {
      try {
        loadingProvider.show();
        await supabaseService.disconnectDependentFromAccount(
          dependentId: dependent.dependentId,
          accountId: account.accountId,
        );
        await loadData(forceRefresh: true);
        if (context.mounted) {
          context.pop();
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_delete_connection_success(
                  '${dependent.name} ${dependent.surname}',
                  '${account.name} ${account.surname}',
                ),
          );
        }
      } catch (e) {
        debugPrint('Error disconnecting dependent from account: $e');
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations.generic_error,
          );
        }
      } finally {
        loadingProvider.hide();
      }
    }

    return BasicExpansionTile(
      title: '${account.name} ${account.surname} (${accountDependents.length})',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...accountDependents.map(
            (dependent) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${dependent.name} ${dependent.surname}',
                    style: AppTextTheme.bodyLarge(context),
                  ),
                ),
                SizedBox(width: AppSpacing.medium),
                MainButton(
                  style: ButtonStyleTypes.text,
                  text: '',
                  type: ButtonType.icon,
                  variant: ButtonStylesVariants.destructive,
                  state: dependent.isMainDependent
                      ? ButtonState.disabled
                      : ButtonState.released,
                  iconAsset: 'assets/icons/trash.svg',
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) {
                      return LargeDialog(
                        type: LargeDialogType.negative,
                        title: context
                            .localizations
                            .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_title,
                        description: context.localizations
                            .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_subtitle(
                              '${dependent.name} ${dependent.surname}',
                              '${account.name} ${account.surname}',
                            ),
                        primaryButtonText: context
                            .localizations
                            .admin_panel_screen_connect_accounts_dependents_delete_connection_dialog_title,
                        secondaryButtonText: context.localizations.cancel,
                        onPrimaryPressed: () {
                          if (dependent.isMainDependent) {
                            context.pop();
                            BottomDialog.show(
                              context,
                              type: BottomDialogType.negative,
                              description: context.localizations
                                  .admin_panel_screen_connect_accounts_dependents_delete_connection_error_main_dependent(
                                    '${dependent.name} ${dependent.surname}',
                                    '${account.name} ${account.surname}',
                                  ),
                            );
                          } else {
                            disconnectDependentFromAccount(
                              dependent,
                              account,
                              adminProvider,
                              supabaseService,
                              loadingProvider,
                              context,
                            );
                          }
                        },
                        onSecondaryPressed: () {
                          context.pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(
                style: ButtonStyleTypes.outlined,
                variant: ButtonStylesVariants.normal,
                text: context
                    .localizations
                    .admin_panel_screen_connect_accounts_dependents_add_connection_button_text,
                onPressed: () async {
                  await context.router.push(
                    AddDependentsToAccountRoute(
                      adminProvider: adminProvider,
                      account: account,
                      alreadyConnectedDependents: accountDependents.toList(),
                    ),
                  );
                  await loadData(forceRefresh: true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
