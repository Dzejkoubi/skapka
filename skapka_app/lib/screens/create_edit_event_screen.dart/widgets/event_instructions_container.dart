import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';

class EventInstructionsContainer extends StatelessWidget {
  const EventInstructionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(CreateEditEventInstructionsRoute());
      },
      child: Container(
        decoration: AppDecorations.primaryContainer(context),
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.xSmall),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/chevron-right.svg',
              width: AppSizes.iconSizeSmall,
              height: AppSizes.iconSizeSmall,
              colorFilter: ColorFilter.mode(
                Colors.transparent,
                BlendMode.srcIn,
              ),
            ),
            Expanded(
              child: Text(
                context
                    .localizations
                    .create_edit_event_screen_instructions_text,
                style: AppTextTheme.titleSmall(context),
                textAlign: TextAlign.center,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron-right.svg',
              width: AppSizes.iconSizeSmall,
              height: AppSizes.iconSizeSmall,
              colorFilter: ColorFilter.mode(
                context.colors.primary.light,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
