import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  const CustomFloatingActionButtonLocation({
    this.left,
    this.right,
    this.top,
    this.bottom,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double x = 0;
    double y = 0;

    if (left != null) {
      x = left!;
    } else if (right != null) {
      x =
          scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width -
          right!;
    } else {
      x =
          scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width -
          16;
    }

    if (top != null) {
      y = top!;
    } else if (bottom != null) {
      y =
          scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height -
          bottom!;
    } else {
      y =
          scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height -
          16;
    }

    return Offset(x, y);
  }
}
