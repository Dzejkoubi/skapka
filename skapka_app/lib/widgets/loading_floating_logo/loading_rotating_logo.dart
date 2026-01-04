import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';

class LoadingRotatingLogo extends StatefulWidget {
  const LoadingRotatingLogo({super.key});

  @override
  State<LoadingRotatingLogo> createState() => _LoadingRotatingLogoState();
}

class _LoadingRotatingLogoState extends State<LoadingRotatingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: controller,
      child: SvgPicture.asset(
        height: AppSizes.iconSizeHuge,
        'assets/images/logos/scout-logo-white-without-text.svg',
      ),
    );
  }
}
