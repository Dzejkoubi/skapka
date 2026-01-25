import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/loading_floating_logo/loading_rotating_logo.dart';

class CenteredLoadingRotatingLogo extends StatelessWidget {
  const CenteredLoadingRotatingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacing.medium),
            LoadingRotatingLogo(),
            SizedBox(height: AppSpacing.medium),
          ],
        ),
      ),
    );
  }
}
