import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/screens/connect_accounts_dependents_screen/widgets/three_state_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class AddDependentsToAccountScreen extends StatefulWidget {
  final AdminPanelProvider adminProvider;
  final AccountModel account;
  final List<AccountDependentModel> alreadyConnectedDependents;

  const AddDependentsToAccountScreen({
    required this.adminProvider,
    required this.account,
    required this.alreadyConnectedDependents,
    super.key,
  });

  @override
  State<AddDependentsToAccountScreen> createState() =>
      _AddDependentsToAccountScreenState();
}

class _AddDependentsToAccountScreenState
    extends State<AddDependentsToAccountScreen> {
  // Map dependentId -> state (0=Disconnect, 1=Connect, 2=Main)
  late Map<String, int> _dependentStates;
  final SupabaseService _supabaseService = SupabaseService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dependentStates = {};
    for (var d in widget.alreadyConnectedDependents) {
      _dependentStates[d.dependentId] = d.isMainDependent
          ? ThreeStateButton.valueCrown
          : ThreeStateButton.valueCheck;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _changeState(String dependentId, int newState) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.show();

    final dependent = widget.adminProvider.groupDependents.firstWhere(
      (d) => d.dependentId == dependentId,
    );

    int oldState = _dependentStates[dependentId] ?? ThreeStateButton.valueX;

    try {
      if (newState == ThreeStateButton.valueX) {
        // Disconnect (0)
        await _supabaseService.disconnectDependentFromAccount(
          accountId: widget.account.accountId,
          dependentId: dependentId,
        );
        setState(() {
          _dependentStates.remove(dependentId);
        });
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_delete_connection_success(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        }
      } else if (newState == ThreeStateButton.valueCheck) {
        // Connect (1)
        if (oldState == ThreeStateButton.valueX) {
          // Connect new
          await _supabaseService.connectDependentToAccount(
            accountId: widget.account.accountId,
            dependentId: dependentId,
            groupId: dependent.groupId,
          );
        } else if (oldState == ThreeStateButton.valueCrown) {
          // Demote from Main
          await _supabaseService.unsetMainDependent(
            accountId: widget.account.accountId,
            dependentId: dependentId,
          );
        }
        setState(() {
          _dependentStates[dependentId] = ThreeStateButton.valueCheck;
        });
        if (mounted && oldState == ThreeStateButton.valueX) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_add_connection_success(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        } else if (mounted && oldState == ThreeStateButton.valueCrown) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_unset_main_dependent_success(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        }
      } else if (newState == ThreeStateButton.valueCrown) {
        // Make Main (2)
        if (oldState == ThreeStateButton.valueX) {
          // Connect then set main
          await _supabaseService.connectDependentToAccount(
            accountId: widget.account.accountId,
            dependentId: dependentId,
            groupId: dependent.groupId,
          );
        }
        await _supabaseService.setMainDependent(
          accountId: widget.account.accountId,
          dependentId: dependentId,
        );
        setState(() {
          // Demote any existing main dependent in local state
          _dependentStates.updateAll((key, value) {
            return value == ThreeStateButton.valueCrown
                ? ThreeStateButton.valueCheck
                : value;
          });
          // Promote current
          _dependentStates[dependentId] = ThreeStateButton.valueCrown;
        });
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_set_main_dependent_success(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
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

  void setMainDependent(
    AccountDependentModel dependent,
    AccountModel account,
    SupabaseService supabaseService,
    LoadingProvider loadingProvider,
    bool isMain,
  ) async {
    try {
      loadingProvider.show();
      if (isMain) {
        await supabaseService.setMainDependent(
          accountId: account.accountId,
          dependentId: dependent.dependentId,
        );
      } else {
        await supabaseService.unsetMainDependent(
          accountId: account.accountId,
          dependentId: dependent.dependentId,
        );
      }
    } catch (e) {
      debugPrint('Error updating main dependent status: $e');
      if (mounted) {
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

  @override
  Widget build(BuildContext context) {
    // Access groupDependents from the passed provider
    final dependents = List.of(widget.adminProvider.groupDependents);

    // Apply filter
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      dependents.retainWhere((d) {
        return d.name.toLowerCase().contains(query) ||
            d.surname.toLowerCase().contains(query);
      });
    }

    // Sort logic
    dependents.sort((a, b) {
      final aState = _dependentStates[a.dependentId] ?? ThreeStateButton.valueX;
      final bState = _dependentStates[b.dependentId] ?? ThreeStateButton.valueX;
      final aConnected = aState != ThreeStateButton.valueX;
      final bConnected = bState != ThreeStateButton.valueX;
      if (aConnected && !bConnected) return -1;
      if (!aConnected && bConnected) return 1;
      return a.surname.compareTo(b.surname);
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        widget.adminProvider.clearSearchQuery();
      },
      child: ScreenWrapper(
        appBar: Appbar(
          showBackChevron: true,
          showSettingsIcon: false,
          screenName: context.localizations
              .admin_panel_screen_connect_accounts_dependents_add_connection_screen_title(
                '${widget.account.name} ${widget.account.surname}',
              ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.bottomSpace + AppSpacing.xxLarge,
              ),
              child: Column(
                spacing: AppSpacing.large,
                children: [
                  CustomForm(
                    showSuffixIcon: false,
                    controller: _searchController,
                    labelText: context
                        .localizations
                        .admin_panel_screen_search_field_hint,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dependents.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppSpacing.medium),
                    itemBuilder: (context, index) {
                      final dependent = dependents[index];
                      final state =
                          _dependentStates[dependent.dependentId] ??
                          ThreeStateButton.valueX;

                      return Container(
                        padding: const EdgeInsets.only(left: AppSpacing.small),
                        decoration: AppDecorations.primaryContainer(context),
                        child: Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  '${dependent.name} ${dependent.surname}',
                                  style: AppTextTheme.bodyLarge(context),
                                ),
                              ),
                            ),
                            ThreeStateButton(
                              value: state,
                              isXEnabled: state != ThreeStateButton.valueCrown,
                              onChanged: (value) =>
                                  _changeState(dependent.dependentId, value),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
