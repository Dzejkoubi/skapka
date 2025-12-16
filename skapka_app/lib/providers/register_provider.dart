import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;

  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isLoading => _isLoading;

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

  void updatePassword(String newPassword) {
    _password = newPassword;
    // Don't call notifyListeners() unless you need UI to react
  }

  void updateConfirmPassword(String newConfirmPassword) {
    _confirmPassword = newConfirmPassword;
    // Don't call notifyListeners() unless you need UI to react
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
