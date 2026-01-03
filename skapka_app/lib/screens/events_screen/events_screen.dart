import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';

@RoutePage()
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = context.read<AccountProvider>();
    DependentsProvider dependentsProvider = context.read<DependentsProvider>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Text(accountProvider.account?.name ?? 'No Name'),
            Text(accountProvider.account?.surname ?? 'No Surname'),
            Text(accountProvider.group?.name ?? 'No Group Name'),
            Text(accountProvider.group?.number.toString() ?? 'No Group Number'),
            Text(dependentsProvider.dependents.length.toString()),
            Text(accountProvider.email),
            MainButton(
              style: ButtonStyleTypes.outlined,
              variant: ButtonStylesVariants.destructive,
              text: 'Printdependents',
              onPressed: () {
                for (var dependent in dependentsProvider.dependents) {
                  debugPrint('Dependent: ${dependent.toString()}');
                }
              },
            ),

            Container(height: 800, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
