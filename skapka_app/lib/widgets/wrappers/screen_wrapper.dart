import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/navbar/navbar.dart';

class ScreenWrapper extends StatelessWidget {
  final Appbar appBar;
  final Widget body;
  final Navbar? bottomNavigationBar;
  const ScreenWrapper({
    super.key,
    required this.appBar,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: context.colors.primary.normal,
      bottom: bottomNavigationBar != null,
      child: Scaffold(
        backgroundColor: context.colors.background.light,
        body: Stack(
          children: [
            Positioned.fill(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  padding: MediaQuery.of(context).padding.copyWith(
                    top: appBar.preferredSize.height,
                    bottom: bottomNavigationBar != null ? Navbar.barHeight : 0,
                  ),
                ),
                child: body,
              ),
            ),
            Positioned(top: 0, left: 0, right: 0, child: appBar),
            if (bottomNavigationBar != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: bottomNavigationBar!,
              ),
          ],
        ),
      ),
    );
  }
}
