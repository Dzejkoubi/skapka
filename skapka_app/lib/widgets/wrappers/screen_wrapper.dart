import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/navbar/navbar.dart';

class ScreenWrapper extends StatelessWidget {
  final Appbar appBar;
  final Widget body;
  final Navbar? bottomNavigationBar;
  final List<SpeedDialChild>? speedDialChildren;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Object? fabKey;
  final ValueNotifier<bool>? openCloseDial;
  final EdgeInsetsGeometry padding;

  const ScreenWrapper({
    super.key,
    required this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.speedDialChildren,
    this.floatingActionButtonLocation,
    this.fabKey,
    this.openCloseDial,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
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
                child: Padding(padding: padding, child: body),
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
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: RotationTransition(turns: animation, child: child),
            );
          },
          child: speedDialChildren != null
              ? SpeedDial(
                  key: ValueKey(fabKey ?? speedDialChildren.hashCode),
                  openCloseDial: openCloseDial,
                  animationCurve: Curves.elasticInOut,
                  onOpen: () => Gaimon.soft(),
                  onClose: () => Gaimon.soft(),
                  backgroundColor: context.colors.background.light,
                  foregroundColor: context.colors.primary.light,
                  shape: SmoothRectangleBorder(
                    side: BorderSide(
                      color: context.colors.primary.light,
                      width: 2,
                    ),
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: AppRadius.medium,
                      cornerSmoothing: AppRadius.smoothNormal,
                    ),
                  ),
                  activeChild: SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: AppSizes.iconSizeSmall,
                    height: AppSizes.iconSizeSmall,
                    colorFilter: ColorFilter.mode(
                      context.colors.primary.normal,
                      BlendMode.srcIn,
                    ),
                  ),
                  children: speedDialChildren!,
                  child: SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: AppSizes.iconSizeSmall,
                    height: AppSizes.iconSizeSmall,
                    colorFilter: ColorFilter.mode(
                      context.colors.primary.normal,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
