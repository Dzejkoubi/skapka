import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/models/dependents/leader_dependent_model.dart';

@RoutePage()
class SetPatrolLeaderScreen extends StatelessWidget {
  final LeaderDependentModel leaderDependent;
  const SetPatrolLeaderScreen({
    required this.leaderDependent,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
