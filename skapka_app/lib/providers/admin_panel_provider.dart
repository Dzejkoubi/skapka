import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skapka_app/models/account_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';

class AdminPanelProvider extends ChangeNotifier {
  List<DependentModel> _groupDependents = [];
  List<AccountModel> _groupAccounts = [];
  String _surnameSearchQuery = '';
  Timer? _debounce;

  List<DependentModel> get groupDependents => _groupDependents;
  List<AccountModel> get groupAccounts => _groupAccounts;
  String get surnameSearchQuery => _surnameSearchQuery;

  void setGroupDependents(List<DependentModel> dependents) {
    _groupDependents = dependents;
    notifyListeners();
  }

  void setGroupAccounts(List<AccountModel> accounts) {
    _groupAccounts = accounts;
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

  void clear() {
    _groupDependents = [];
    _groupAccounts = [];
    _surnameSearchQuery = '';
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
