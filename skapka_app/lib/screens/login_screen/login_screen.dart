import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/screen_wrapper.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        backgroundColor: context.colors.primary.light,
        body: Column(
          children: [
            SizedBox(height: AppSpacing.bottomSpace),
            Center(
              child: Text(
                'Login Screen',
                style: AppTextTheme.displayLarge.copyWith(
                  color: context.colors.text.normalLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
