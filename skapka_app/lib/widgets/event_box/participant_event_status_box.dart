import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_shadow.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';

class ParticipantEventStatusBox extends StatelessWidget {
  final EventParticipantStatus status;
  final bool isEnabled;
  final String eventId;
  final String dependentId;

  const ParticipantEventStatusBox({
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
                  EventParticipantStatus.notSpecified => 'signed_up',
                  EventParticipantStatus.signedUp => 'excused',
                  EventParticipantStatus.excused => 'not_specified',
                },
              );
            }
          : () {
              BottomDialog.show(
                context,
                type: BottomDialogType.negative,
                description:
                    'Nelze změnit stav přihlášení na výpravu po vypršení datumu přihlašování',
              );
            },
      child: Container(
        decoration: ShapeDecoration(
          shadows: [config.boxShadow],
          gradient: config.borderGradient,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: AppRadius.small + 2, // Adjusted for border width
              cornerSmoothing: AppRadius.smoothNormal,
            ),
          ),
        ),
        padding: const EdgeInsets.all(2), // Border width
        child: Container(
          height: AppSizes.iconSizeXLarge,
          width: AppSizes.iconSizeXLarge,
          decoration: ShapeDecoration(
            color: config.backgroundColor,
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
              height: AppSizes.iconSizeLarge,
              colorFilter: ColorFilter.mode(config.iconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }

  _ParticipantStatusBoxConfig _getConfig(BuildContext context) {
    final String iconPath = switch (status) {
      EventParticipantStatus.notSpecified => 'assets/icons/minus.svg',
      EventParticipantStatus.signedUp => 'assets/icons/check.svg',
      EventParticipantStatus.excused => 'assets/icons/x.svg',
    };

    if (isEnabled) {
      return switch (status) {
        EventParticipantStatus.notSpecified => _ParticipantStatusBoxConfig(
          borderGradient: AppGradients.secondaryPrimaryGradient(context),
          backgroundColor: context.colors.primary.normal,
          iconColor: context.colors.text.normal,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        EventParticipantStatus.signedUp => _ParticipantStatusBoxConfig(
          borderGradient: AppGradients.successGradient(context),
          backgroundColor: context.colors.success.normal,
          iconColor: context.colors.text.normal,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        EventParticipantStatus.excused => _ParticipantStatusBoxConfig(
          borderGradient: AppGradients.errorGradient(context),
          backgroundColor: context.colors.error.normal,
          iconColor: context.colors.text.normal,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
      };
    } else {
      return _ParticipantStatusBoxConfig(
        borderGradient: LinearGradient(
          colors: [
            context.colors.text.mutedReversed,
            context.colors.text.mutedReversed,
          ],
        ),
        backgroundColor: context.colors.background.mediumLight,
        iconColor: context.colors.text.mutedReversed,
        svgAssetPath: iconPath,
        boxShadow: AppShadow.outerXSmall(context),
      );
    }
  }
}

class _ParticipantStatusBoxConfig {
  final Gradient? borderGradient;
  final Color? backgroundColor;
  final Color iconColor;
  final String svgAssetPath;
  final BoxShadow boxShadow;

  _ParticipantStatusBoxConfig({
    this.borderGradient,
    this.backgroundColor,
    required this.iconColor,
    required this.svgAssetPath,
    required this.boxShadow,
  });
}
