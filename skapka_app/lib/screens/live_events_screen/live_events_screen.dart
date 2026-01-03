import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';

@RoutePage()
class LiveEventsScreen extends StatelessWidget {
  const LiveEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountProvider accountProvider = context.read<AccountProvider>();
    DependentsProvider dependentsProvider = context.read<DependentsProvider>();
    return SingleChildScrollView(
      child: SafeArea(child: Column(children: [
            
          ],
        )),
    );
  }
}
