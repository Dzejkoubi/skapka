import 'package:flutter/material.dart';

class ConcaveClipper extends CustomClipper<Path> {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  ConcaveClipper({
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Top Left
    path.moveTo(0, topLeft);
    if (topLeft > 0) {
      path.arcToPoint(
        Offset(topLeft, 0),
        radius: Radius.circular(topLeft),
        clockwise: false,
      );
    } else {
      path.moveTo(0, 0);
    }

    // Top Right
    path.lineTo(size.width - topRight, 0);
    if (topRight > 0) {
      path.arcToPoint(
        Offset(size.width, topRight),
        radius: Radius.circular(topRight),
        clockwise: false,
      );
    }

    // Bottom Right
    path.lineTo(size.width, size.height - bottomRight);
    if (bottomRight > 0) {
      path.arcToPoint(
        Offset(size.width - bottomRight, size.height),
        radius: Radius.circular(bottomRight),
        clockwise: false,
      );
    }

    // Bottom Left
    path.lineTo(bottomLeft, size.height);
    if (bottomLeft > 0) {
      path.arcToPoint(
        Offset(0, size.height - bottomLeft),
        radius: Radius.circular(bottomLeft),
        clockwise: false,
      );
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
