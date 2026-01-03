import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingFloatingLogo extends StatefulWidget {
  const LoadingFloatingLogo({super.key});

  @override
  State<LoadingFloatingLogo> createState() => _LoadingFloatingLogoState();
}

class _LoadingFloatingLogoState extends State<LoadingFloatingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Tween<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    return FadeTransition(
      opacity: Tween(begin: 0.2, end: 1.0).animate(curvedAnimation),
      child: ScaleTransition(
        scale: Tween(begin: 0.8, end: 1.0).animate(curvedAnimation),
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: SvgPicture.asset(
            'assets/images/logos/scout-logo-white-without-text.svg',
          ),
        ),
      ),
    );
  }
}
