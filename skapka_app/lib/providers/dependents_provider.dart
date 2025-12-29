import 'package:flutter/material.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';

class DependentsProvider extends ChangeNotifier {
  final List<AccountDependentModel> _dependents = [];

  List<AccountDependentModel> get dependents => _dependents;

  void addDependent(AccountDependentModel dependent) {
    _dependents.add(dependent);
    notifyListeners();
  }

  void removeDependent(AccountDependentModel dependent) {
    _dependents.remove(dependent);
    notifyListeners();
  }
}
