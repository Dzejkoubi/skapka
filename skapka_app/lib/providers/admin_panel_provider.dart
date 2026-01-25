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
  String _searchQuery = '';
  Timer? _debounce;

  List<DependentModel> get groupDependents => _groupDependents;
  List<AccountDependentModel> get groupAccountDependents =>
      _groupAccountDependents;
  List<AccountModel> get groupAccounts => _groupAccounts;
  List<LeaderModel> get groupLeaders => _groupLeaders;
  List<AccountDependentRelationModel> get groupAccountsDependentsRelations =>
      _groupAccountsDependentsRelations;
  String get searchQuery => _searchQuery;

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

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearchQuery() {
    _searchQuery = '';
    notifyListeners();
  }

  void clear() {
    _groupDependents = [];
    _groupAccounts = [];
    _groupLeaders = [];
    _groupAccountsDependentsRelations = [];
    _searchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
