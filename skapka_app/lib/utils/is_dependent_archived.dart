import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';

bool isDependentArchived(BuildContext context, String dependentId) {
  final dependents = Provider.of<DependentsProvider>(
    context,
    listen: false,
  ).dependents;

  final dependentIndex = dependents.indexWhere(
    (d) => d.dependentId == dependentId,
  );

  if (dependentIndex != -1) {
    return dependents[dependentIndex].dependentDetails?.isArchived ?? false;
  }

  return false;
}
