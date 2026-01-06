import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_shadow.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/change_participant_event_status_dialog.dart';

class ParticipantEventStatusBox extends StatelessWidget {
  final EventParticipantStatus status;
  final bool isEnabled;
  final EventModel eventModel;
  final AccountDependentModel dependent;

  const ParticipantEventStatusBox({
    super.key,
    required this.status,
    required this.isEnabled,
    required this.eventModel,
    required this.dependent,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isEnabled
          ? () {
              Gaimon.success();
              if (context.mounted) {
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (builder) {
                    return ChangeParticipantEventStatusDialog(
                      dependent: dependent,
                      eventModel: eventModel,
                      oldStatus: status,
                      dependentsProvider: context.read<DependentsProvider>(),
                    );
                  },
                );
              }
            }
          : () => {
              Gaimon.error(),

              BottomDialog.show(
                context,
                type: BottomDialogType.negative,
                description: context
                    .localizations
                    .live_events_screen_cannot_change_status_past_signup_deadline,
              ),
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
          borderGradient: AppGradients.primaryGradient(context),
          backgroundColor: context.colors.primary.normal,
          iconColor: context.colors.text.normalLight,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        EventParticipantStatus.signedUp => _ParticipantStatusBoxConfig(
          borderGradient: AppGradients.successGradient(context),
          backgroundColor: context.colors.success.normal,
          iconColor: context.colors.text.normalLight,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
        EventParticipantStatus.excused => _ParticipantStatusBoxConfig(
          borderGradient: AppGradients.errorGradient(context),
          backgroundColor: context.colors.error.normal,
          iconColor: context.colors.text.normalLight,
          svgAssetPath: iconPath,
          boxShadow: AppShadow.outerSmall(context),
        ),
      };
    } else {
      return _ParticipantStatusBoxConfig(
        borderGradient: LinearGradient(
          colors: [
            context.colors.text.mutedLight,
            context.colors.text.mutedLight,
          ],
        ),
        backgroundColor: context.colors.text.mutedLight,
        iconColor: context.colors.text.normalLight,
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
