import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';

class ScreenAppbar extends StatelessWidget {
  final Appbar appbar;
  final Widget child;

  const ScreenAppbar({super.key, required this.appbar, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background.light,
      body: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(bottom: false, child: appbar),
          ),
        ],
      ),
    );
  }
}
