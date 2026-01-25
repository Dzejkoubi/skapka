import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/widgets/buttons/switch_button.dart';

class ApproveAccountsAccountBox extends StatelessWidget {
  const ApproveAccountsAccountBox({
    super.key,
    required this.account,
    required this.updateAccountApprovalStatus,
  });

  final AccountModel account;
  final Future<void> Function(AccountModel account, bool isApproved)
  updateAccountApprovalStatus;

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
            child: Text(
              '${account.name} ${account.surname}',
              style: AppTextTheme.bodyMedium(context),
            ),
          ),
          SwitchButton(
            value: account.isApproved,
            onChanged: (value) async =>
                await updateAccountApprovalStatus(account, value),
          ),
        ],
      ),
    );
  }
}
