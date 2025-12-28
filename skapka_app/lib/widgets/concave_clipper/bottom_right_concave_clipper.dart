import 'package:flutter/material.dart';

class BottomRightConcaveClipper extends CustomClipper<Path> {
  final double radius;
  BottomRightConcaveClipper(this.radius);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width, 0) // Move to top right
      ..lineTo(size.width, size.height - radius) // Move to start of curve
      ..arcToPoint(
        Offset(size.width - radius, size.height), // End of curve
        radius: Radius.circular(radius),
        clockwise: false, // Inverts the curve inward
      )
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
