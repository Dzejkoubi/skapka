import 'package:flutter/material.dart';

class BottomLeftConcaveClipper extends CustomClipper<Path> {
  final double radius;
  BottomLeftConcaveClipper(this.radius);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(radius, size.height) // Move to start of curve
      ..arcToPoint(
        Offset(0, size.height - radius), // End of curve
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
