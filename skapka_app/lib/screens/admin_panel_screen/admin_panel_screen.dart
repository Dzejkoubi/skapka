import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/admin_panel_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/basic_expansion_tile.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

@RoutePage()
class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseService supabaseService = SupabaseService();
    AccountProvider accountProvider = context.read<AccountProvider>();
    initializeGroupDependents({
      required BuildContext context,
      required AdminPanelProvider adminPanelProvider,
      bool autoFetch = false,
    }) async {
      try {
        debugPrint('Initializing group dependents for Admin Panel');
        if (adminPanelProvider.groupDependents.isEmpty || autoFetch) {
          List<DependentModel> dependents = await supabaseService
              .getGroupDependents(groupId: accountProvider.groupId);
          adminPanelProvider.setGroupDependents(dependents);
        }
      } catch (e) {
        debugPrint('Error initializing group dependents: $e');
        if (context.mounted) {
          BottomDialog.show(
            context,
            type: BottomDialogType.negative,
            description: context.localizations.generic_error,
          );
        }
        rethrow;
      }
    }

    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.admin_panel_screen_title,
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
                // DB warnings expansion tile
                Consumer<AdminPanelProvider>(
                  builder: (context, adminProvider, child) => BasicExpansionTile(
                    title: context
                        .localizations
                        .admin_panel_screen_db_warnings_expansion_tile_title,
                    customBorderColor: AppColorTheme.error.normal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.small,
                      children: [
                        // Warnings list
                        FutureBuilder(
                          future: initializeGroupDependents(
                            context: context,
                            adminPanelProvider: adminProvider,
                          ),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingRotatingLogo();
                            } else if (asyncSnapshot.hasError) {
                              return Text(
                                context.localizations.error,
                                style: AppTextTheme.bodyMedium(context),
                              );
                            } else {
                              final dependents = adminProvider.groupDependents;
                              final warningWidgets = <Widget>[];

                              for (final dependent in dependents) {
                                if (dependent.isArchived) continue;

                                bool missingPersonalEmail = false;
                                bool missingPersonalPhone = false;
                                bool missingParentEmail = false;
                                bool missingParentPhone = false;
                                bool hasWarning = false;

                                // If the user is a leader, show normal (personal) contact warnings.
                                // If the user is NOT a leader (dependent), show parent contact warnings.
                                // Note: Logic inverted based on user requirement (isLeader check acts as !isLeader).
                                if (!dependent.isLeader) {
                                  if (dependent.contactEmail == null ||
                                      dependent.contactEmail!.isEmpty) {
                                    missingPersonalEmail = true;
                                    hasWarning = true;
                                  }
                                  if (dependent.contactPhone == null ||
                                      dependent.contactPhone!.isEmpty) {
                                    missingPersonalPhone = true;
                                    hasWarning = true;
                                  }
                                } else {
                                  if (dependent.parent1Email == null ||
                                      dependent.parent1Email!.isEmpty) {
                                    missingParentEmail = true;
                                    hasWarning = true;
                                  }
                                  if (dependent.parent1Phone == null ||
                                      dependent.parent1Phone!.isEmpty) {
                                    missingParentPhone = true;
                                    hasWarning = true;
                                  }
                                }

                                if (hasWarning) {
                                  warningWidgets.add(
                                    Container(
                                      decoration:
                                          AppDecorations.primaryContainer(
                                            context,
                                            borderColor:
                                                AppColorTheme.error.normal,
                                          ),
                                      padding: const EdgeInsets.all(
                                        AppSpacing.xSmall,
                                      ),

                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                context.localizations
                                                    .admin_panel_screen_db_warning_account_does_not_have_some_contact_filled_in(
                                                      '${dependent.name} ${dependent.surname}',
                                                      missingPersonalEmail
                                                          .toString(),
                                                      missingPersonalPhone
                                                          .toString(),
                                                      missingParentEmail
                                                          .toString(),
                                                      missingParentPhone
                                                          .toString(),
                                                    ),
                                                style: AppTextTheme.bodyMedium(
                                                  context,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }

                              if (warningWidgets.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.small,
                                    ),
                                    child: Text(
                                      context
                                          .localizations
                                          .admin_panel_screen_db_warning_no_warnings_subtitle,
                                      style: AppTextTheme.bodyMedium(context),
                                    ),
                                  ),
                                );
                              }

                              return Column(
                                spacing: AppSpacing.small,
                                children: warningWidgets,
                              );
                            }
                          },
                        ),
                        // Reload warnings button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MainButton.filled(
                              variant: ButtonStylesVariants.destructive,
                              text: '',
                              type: ButtonType.icon,
                              onPressed: () {
                                initializeGroupDependents(
                                  context: context,
                                  adminPanelProvider: adminProvider,
                                  autoFetch: true,
                                );
                              },
                              iconAsset: 'assets/icons/reload.svg',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Account editing expansion tile
                BasicExpansionTile(
                  title: context
                      .localizations
                      .admin_panel_screen_accounts_management_title,
                  child: Column(
                    spacing: AppSpacing.xSmall,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.filled(
                            onPressed: () {
                              context.router.push(const ApproveAccountsRoute());
                            },
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/check.svg',
                            text: context
                                .localizations
                                .admin_panel_screen_button_approve_accounts,
                            expandToFillWidth: false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            onPressed: () {},
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/pencil.svg',
                            text: context
                                .localizations
                                .admin_panel_screen_button_edit_leaders,
                            expandToFillWidth: false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            onPressed: () {
                              context.router.push(
                                const EditAccountRightsRoute(),
                              );
                            },
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/license.svg',
                            text: context
                                .localizations
                                .admin_panel_screen_button_edit_rights,
                            expandToFillWidth: false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            onPressed: () {},
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/user-plus.svg',
                            text: context
                                .localizations
                                .admin_panel_screen_button_connect_dependents,
                            expandToFillWidth: false,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            onPressed: () {},
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/eye-off.svg',
                            text: context
                                .localizations
                                .admin_panel_screen_button_dependent_codes,
                            expandToFillWidth: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Skautis management expansion tile
                BasicExpansionTile(
                  title: context
                      .localizations
                      .admin_panel_screen_data_management_title,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/cloud-down.svg',
                            variant: ButtonStylesVariants.normal,
                            text: context
                                .localizations
                                .admin_panel_screen_button_skautis_sync,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Notification settings expansion tile
                BasicExpansionTile(
                  title: context
                      .localizations
                      .admin_panel_screen_notification_title,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MainButton.outlined(
                            type: ButtonType.textIcon,
                            iconAsset: 'assets/icons/bell-up.svg',
                            variant: ButtonStylesVariants.normal,
                            text: context
                                .localizations
                                .admin_panel_screen_button_send_notification,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Edit server driven content expansion tile
              ],
            ),
          ),
        ),
      ),
    );
  }
}
