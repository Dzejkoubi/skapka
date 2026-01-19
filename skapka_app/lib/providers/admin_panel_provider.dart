import 'package:flutter/material.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  List<DependentModel> _groupDependents = [];

  List<DependentModel> get groupDependents => _groupDependents;

  void setGroupDependents(List<DependentModel> dependents) {
    _groupDependents = dependents;
    notifyListeners();
  }

  void clear() {
    _groupDependents = [];
    notifyListeners();
  }
}
