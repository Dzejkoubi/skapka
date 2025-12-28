import 'package:flutter/material.dart';

class DependentsProvider extends ChangeNotifier {
  final List<String> _dependents = [];

  List<String> get dependents => _dependents;

  void addDependent(String name) {
    _dependents.add(name);
    notifyListeners();
  }

  void removeDependent(String name) {
    _dependents.remove(name);
    notifyListeners();
  }
}
