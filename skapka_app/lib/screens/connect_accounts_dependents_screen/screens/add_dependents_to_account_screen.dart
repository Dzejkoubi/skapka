import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/switch_button.dart';
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
  late Set<String> _connectedDependentIds;
  final SupabaseService _supabaseService = SupabaseService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectedDependentIds = widget.alreadyConnectedDependents
        .map((d) => d.dependentId)
        .toSet();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _toggleConnection(String dependentId, bool newValue) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.show();

    final dependent = widget.adminProvider.groupDependents.firstWhere(
      (d) => d.dependentId == dependentId,
    );

    try {
      if (newValue) {
        // Connect
        await _supabaseService.connectDependentToAccount(
          accountId: widget.account.accountId,
          dependentId: dependentId,
          groupId: dependent.groupId,
        );
        setState(() {
          _connectedDependentIds.add(dependentId);
        });
        if (mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_add_connection_success(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        }
      } else {
        // Disconnect
        await _supabaseService.disconnectDependentFromAccount(
          accountId: widget.account.accountId,
          dependentId: dependentId,
        );
        setState(() {
          _connectedDependentIds.remove(dependentId);
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
      }
    } catch (e) {
      if (mounted) {
        if (newValue) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_add_connection_error(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        } else {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations
                .admin_panel_screen_connect_accounts_dependents_delete_connection_error(
                  '${dependent.name} ${dependent.surname}',
                  '${widget.account.name} ${widget.account.surname}',
                ),
          );
        }
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
      final aConnected = _connectedDependentIds.contains(a.dependentId);
      final bConnected = _connectedDependentIds.contains(b.dependentId);
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
                      final isConnected = _connectedDependentIds.contains(
                        dependent.dependentId,
                      );

                      return Row(
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
                          SwitchButton(
                            value: isConnected,
                            onChanged: (value) =>
                                _toggleConnection(dependent.dependentId, value),
                          ),
                        ],
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
