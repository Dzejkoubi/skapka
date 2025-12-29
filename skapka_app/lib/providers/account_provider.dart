import 'package:flutter/widgets.dart';
import 'package:skapka_app/models/account_model.dart';

class AccountProvider extends ChangeNotifier {
  AccountModel? _account;
  String _email = '';

  AccountModel? get account => _account;
  String get email => _email;

  // Convenience getters
  String get accountId => _account?.accountId ?? '';
  String? get name => _account?.name;
  String? get surname => _account?.surname;
  DateTime? get createdAt => _account?.createdAt;
  int get rights => _account?.rights ?? 0;
  String get groupId => _account?.groupId ?? '';
  bool get isApproved => _account?.isApproved ?? false;

  void setAccount(AccountModel newAccount) {
    _account = newAccount;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void clear() {
    _account = null;
    _email = '';
    notifyListeners();
  }
}
