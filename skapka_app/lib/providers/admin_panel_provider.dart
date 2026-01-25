import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/dependents/account_dependent_relation_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';
import 'package:skapka_app/models/leader_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  List<DependentModel> _groupDependents = [];
  List<AccountDependentModel> _groupAccountDependents = [];
  List<AccountModel> _groupAccounts = [];
  List<LeaderModel> _groupLeaders = [];
  List<AccountDependentRelationModel> _groupAccountsDependentsRelations = [];
  String _surnameSearchQuery = '';
  Timer? _debounce;

  List<DependentModel> get groupDependents => _groupDependents;
  List<AccountDependentModel> get groupAccountDependents =>
      _groupAccountDependents;
  List<AccountModel> get groupAccounts => _groupAccounts;
  List<LeaderModel> get groupLeaders => _groupLeaders;
  List<AccountDependentRelationModel> get groupAccountsDependentsRelations =>
      _groupAccountsDependentsRelations;
  String get surnameSearchQuery => _surnameSearchQuery;

  void setGroupDependents(List<DependentModel> dependents) {
    _groupDependents = dependents;
    notifyListeners();
  }

  void setGroupAccountDependentsList(
    List<AccountDependentModel> accountDependents,
  ) {
    _groupAccountDependents = accountDependents;
    notifyListeners();
  }

  void setGroupAccounts(List<AccountModel> accounts) {
    _groupAccounts = accounts;
    notifyListeners();
  }

  void setGroupLeaders(List<LeaderModel> leaders) {
    _groupLeaders = leaders;
    notifyListeners();
  }

  void setGroupAccountDependents(
    List<AccountDependentRelationModel> accountDependents,
  ) {
    _groupAccountsDependentsRelations = accountDependents;
    notifyListeners();
  }

  void setSurnameSearchQuery(String query) {
    _surnameSearchQuery = query;
    notifyListeners();
  }

  void setSurnameSearchQueryDebounced(String query, VoidCallback? onDebounced) {
    _surnameSearchQuery = query;
    notifyListeners();

    // Cancel any existing debounce timer
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (onDebounced != null) onDebounced();
    });
  }

  void clearSurnameSearchQuery() {
    _surnameSearchQuery = '';
    notifyListeners();
  }

  void clear() {
    _groupDependents = [];
    _groupAccounts = [];
    _groupLeaders = [];
    _groupAccountsDependentsRelations = [];
    _surnameSearchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
