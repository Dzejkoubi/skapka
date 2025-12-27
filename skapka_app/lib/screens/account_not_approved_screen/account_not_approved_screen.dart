import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/providers/auth_provider.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';

@RoutePage()
class AccountNotApprovedScreen extends StatelessWidget {
  const AccountNotApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const notifyAdministratorButtonEnabled = false;
    AuthService authService = AuthService();
    AuthProvider authProvider = context.read<AuthProvider>();

    return Scaffold(
      backgroundColor: context.colors.primary.light,
      body: ScrollableOnKeyboardScreenWrapper(
        builder: (constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.huge),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/images/shapes/outline-shape-1.svg'),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(
                      context,
                    )!.account_not_approved_screen_title,
                    style: AppTextTheme.displayLarge(
                      context,
                    ).copyWith(color: context.colors.text.normalLight),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.xxLarge),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  AppLocalizations.of(
                    context,
                  )!.account_not_approved_screen_text,
                  style: AppTextTheme.bodyMedium(
                    context,
                  ).copyWith(color: context.colors.text.mutedLight),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSpacing.xxLarge),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xLarge,
                ),
                child: MainButton.filled(
                  type: ButtonType.text,
                  variant: ButtonStylesVariants.white,
                  onPressed: () {
                    onNotifyAdministratorPressed(
                      context,
                      notifyAdministratorButtonEnabled:
                          notifyAdministratorButtonEnabled,
                    );
                  },
                  text: AppLocalizations.of(
                    context,
                  )!.account_not_approved_screen_notify_administrator_button_text,
                ),
              ),
              SizedBox(height: AppSpacing.medium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 96),
                child: MainButton.outlined(
                  type: ButtonType.textIcon,
                  iconAsset: 'assets/icons/logout.svg',
                  variant: ButtonStylesVariants.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => LargeDialog(
                        type: LargeDialogType.negative,
                        title: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_logout_dialog_title,
                        description: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_logout_dialog_description,
                        primaryButtonText: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_logout_dialog_primary_button_text,
                        onPrimaryPressed: () async {
                          try {
                            await authService.signOut();
                            authProvider.signOut();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              BottomDialog.show(
                                context,
                                type: BottomDialogType.positive,
                                description: AppLocalizations.of(
                                  context,
                                )!.account_not_approved_screen_logout_success,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              BottomDialog.show(
                                context,
                                type: BottomDialogType.negative,
                                description: AppLocalizations.of(
                                  context,
                                )!.account_not_approved_screen_logout_error,
                              );
                            }
                          }
                        },
                        secondaryButtonText: AppLocalizations.of(
                          context,
                        )!.cancel,
                        onSecondaryPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                  text: AppLocalizations.of(
                    context,
                  )!.account_not_approved_screen_logout_button_text,
                ),
              ),
              SizedBox(height: AppSpacing.medium),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.large,
                ),
                child: MainButton.text(
                  type: ButtonType.textIcon,
                  iconAsset: 'assets/icons/user-x.svg',
                  variant: ButtonStylesVariants.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => LargeDialog(
                        type: LargeDialogType.negative,
                        title: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_delete_account_dialog_title,
                        description: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_delete_account_dialog_description,
                        primaryButtonText: AppLocalizations.of(
                          context,
                        )!.account_not_approved_screen_delete_account_dialog_primary_button_text,
                        onPrimaryPressed: () async {
                          try {
                            await authService.deleteAccount();
                            authProvider.signOut();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              BottomDialog.show(
                                context,
                                type: BottomDialogType.positive,
                                description: AppLocalizations.of(
                                  context,
                                )!.account_not_approved_screen_delete_success,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              BottomDialog.show(
                                context,
                                type: BottomDialogType.negative,
                                description: AppLocalizations.of(
                                  context,
                                )!.account_not_approved_screen_delete_error,
                              );
                            }
                          }
                        },
                        secondaryButtonText: AppLocalizations.of(
                          context,
                        )!.cancel,
                        onSecondaryPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                  text: AppLocalizations.of(
                    context,
                  )!.account_not_approved_screen_delete_account_button_text,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void onNotifyAdministratorPressed(
    context, {
    bool notifyAdministratorButtonEnabled = false,
  }) {
    if (notifyAdministratorButtonEnabled == true) {
      showDialog(
        context: context,
        builder: (_) => LargeDialog(
          type: LargeDialogType.basic,
          title: AppLocalizations.of(
            context,
          )!.account_not_approved_screen_notify_administrator_dialog_title,
          description: AppLocalizations.of(
            context,
          )!.account_not_approved_screen_notify_administrator_dialog_description,
          primaryButtonText: AppLocalizations.of(
            context,
          )!.account_not_approved_screen_notify_administrator_dialog_primary_button_text,
          onPrimaryPressed: () {
            print('Notify administrator button pressed');
          },
        ),
      );
    } else {
      BottomDialog.show(
        context,
        type: BottomDialogType.negative,
        description: AppLocalizations.of(
          context,
        )!.account_not_approved_screen_notify_administrator_button_error_dialog,
      );
    }
  }
}
