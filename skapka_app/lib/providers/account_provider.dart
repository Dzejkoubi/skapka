import 'package:flutter/widgets.dart';

class AccountProvider extends ChangeNotifier {
  String _name = '';
  String _surname = '';
  String _email = '';

  String get name => _name;
  String get surname => _surname;
  String get email => _email;

  void updateName(String newName) {
    _name = newName;
    // Don't call notifyListeners() unless you need UI to react
  }

  void updateSurname(String newSurname) {
    _surname = newSurname;
    // Don't call notifyListeners() unless you need UI to react
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    // Don't call notifyListeners() unless you need UI to react
  }
}
