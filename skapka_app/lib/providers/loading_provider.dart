import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _loadingText;

  bool get isLoading => _isLoading;
  String? get loadingText => _loadingText;

  void show({String? text}) {
    _isLoading = true;
    _loadingText = text;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    _loadingText = null;
    notifyListeners();
  }
}
