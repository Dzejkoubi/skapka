import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class SettingsBox extends StatelessWidget {
  final String text;
  final PageRouteInfo route;

  const SettingsBox({super.key, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Gaimon.soft();
        context.router.push(route);
      },
      child: Container(
        decoration: AppDecorations.primaryContainer(context),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
        child: Row(
          children: [
            Text(text, style: AppTextTheme.titleSmall(context)),
            Expanded(child: Container()),
            SvgPicture.asset(
              'assets/icons/chevron-right.svg',
              width: AppSizes.iconSizeSmall,
              height: AppSizes.iconSizeSmall,
              colorFilter: ColorFilter.mode(
                context.colors.text.normal,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
