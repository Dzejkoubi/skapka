import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/services/auth_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';

class AccountContainer extends StatelessWidget {
  const AccountContainer({
    super.key,
    required this.accountProvider,
    required this.authService,
  });

  final AccountProvider accountProvider;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: AppDecorations.primaryContainer(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  '${accountProvider.name} ${accountProvider.surname}',
                  style: AppTextTheme.displaySmall(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.small),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                LogoutButton(authService: authService),
                const SizedBox(width: AppSpacing.small),
                DeleteAccountButton(authService: authService),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return MainButton.text(
      variant: ButtonStylesVariants.destructive,
      text: AppLocalizations.of(
        context,
      )!.settings_screen_change_delete_account_button_text,
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
                if (context.mounted) {
                  BottomDialog.show(
                    context,
                    type: BottomDialogType.positive,
                    description: AppLocalizations.of(
                      context,
                    )!.account_not_approved_screen_delete_success,
                  );
                  context.router.replaceAll([
                    const WelcomeRoute(),
                  ]); // Navigate to Welcome after deletion
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
            secondaryButtonText: AppLocalizations.of(context)!.cancel,
            onSecondaryPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return MainButton.outlined(
      variant: ButtonStylesVariants.destructive,
      text: AppLocalizations.of(
        context,
      )!.settings_screen_change_signout_button_text,
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
                if (context.mounted) {
                  BottomDialog.show(
                    context,
                    type: BottomDialogType.positive,
                    description: AppLocalizations.of(
                      context,
                    )!.account_not_approved_screen_logout_success,
                  );
                  context.router.replaceAll([
                    const WelcomeRoute(),
                  ]); // Navigate to Welcome after logout
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
            secondaryButtonText: AppLocalizations.of(context)!.cancel,
            onSecondaryPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
