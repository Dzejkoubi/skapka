import 'package:flutter/material.dart';
import 'package:skapka_app/models/group_model.dart';
import 'package:skapka_app/models/patrol_model.dart';
import 'package:skapka_app/models/troop_model.dart';

class UnitsProvider extends ChangeNotifier {
  late GroupModel _accountGroup;
  late List<TroopModel> _troops;
  late List<PatrolModel> _patrols;

  // Getters
  GroupModel get accountGroup => _accountGroup;
  List<TroopModel> get troops => _troops;
  List<PatrolModel> get patrols => _patrols;

  // Setters
  void setAccountGroup(GroupModel group) {
    _accountGroup = group;
    notifyListeners();
  }

  void setTroops(List<TroopModel> troops) {
    _troops = troops;
    notifyListeners();
  }

  void setPatrols(List<PatrolModel> patrols) {
    _patrols = patrols;
    notifyListeners();
  }
}
