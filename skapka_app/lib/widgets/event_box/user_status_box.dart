import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_shadow.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/services/supabase_service.dart';

enum UserStatus { noResponse, signedUp, excused }

class UserStatusBox extends StatelessWidget {
  final UserStatus status;
  final bool isEnabled;
  final String eventId;
  final String dependentId;

  const UserStatusBox({
    super.key,
    required this.status,
    required this.isEnabled,
    required this.eventId,
    required this.dependentId,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context);
    SupabaseService supabaseService = SupabaseService();

    return GestureDetector(
      onTap: isEnabled
          ? () {
              supabaseService.updateDependentEventParticipationStatus(
                eventId: eventId,
                dependentId: dependentId,
                newStatus: switch (status) {
                  UserStatus.noResponse => 'not_specified',
                  UserStatus.signedUp => 'signed_up',
                  UserStatus.excused => 'excused',
                },
              );
            }
          : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 40,
        width: 40,
        decoration: ShapeDecoration(
          gradient: config.gradient,
          color: config.backgroundColor,
          shadows: [config.boxShadow],
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.small,
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            config.svgAssetPath,
            colorFilter: ColorFilter.mode(config.iconColor, BlendMode.srcIn),
            width: AppSizes.iconSizeSmall,
            height: AppSizes.iconSizeSmall,
          ),
        ),
      ),
    );
  }

  _UserStatusBoxConfig _getConfig(BuildContext context) {
    final String iconPath = switch (status) {
      UserStatus.noResponse => 'assets/icons/minus.svg',
      UserStatus.signedUp => 'assets/icons/check.svg',
      UserStatus.excused => 'assets/icons/x.svg',
    };

    if (isEnabled) {
      return switch (status) {
        UserStatus.noResponse => _UserStatusBoxConfig(
          gradient: AppGradients.secondaryPrimaryGradient(context),
          iconColor: Colors.white,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        UserStatus.signedUp => _UserStatusBoxConfig(
          gradient: AppGradients.successGradient(context),
          iconColor: Colors.white,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        UserStatus.excused => _UserStatusBoxConfig(
          gradient: AppGradients.errorGradient(context),
          iconColor: Colors.white,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
      };
    } else {
      return _UserStatusBoxConfig(
        gradient: AppGradients.greyGradient(context),
        backgroundColor: context.colors.background.mediumLight,
        iconColor: context.colors.text.mutedReversed,
        svgAssetPath: iconPath,
        boxShadow: AppShadow.outerXSmall(context),
      );
    }
  }
}

class _UserStatusBoxConfig {
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color iconColor;
  final String svgAssetPath;
  final BoxShadow boxShadow;

  _UserStatusBoxConfig({
    this.gradient,
    this.backgroundColor,
    required this.iconColor,
    required this.svgAssetPath,
    required this.boxShadow,
  });
}
