import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/providers/account_provider.dart';

@RoutePage()
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = context.read<AccountProvider>();
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Text(accountProvider.account?.name ?? 'No Name'),
            Text(accountProvider.account?.surname ?? 'No Surname'),
            Text(accountProvider.group?.name ?? 'No Group Name'),
            Text(accountProvider.group?.number.toString() ?? 'No Group Number'),

            Text(accountProvider.email),

            Container(height: 800, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
