import 'package:skapka_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.language)),
      ),
    );
  }
}
