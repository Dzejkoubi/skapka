import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_gradients.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:provider/provider.dart';

class ChangeParticipantEventStatusDialog extends StatefulWidget {
  final AccountDependentModel dependent;
  final EventModel eventModel;
  final EventParticipantStatus oldStatus;
  final DependentsProvider dependentsProvider;

  const ChangeParticipantEventStatusDialog({
    required this.dependent,
    required this.eventModel,
    required this.oldStatus,
    required this.dependentsProvider,
    super.key,
  });

  @override
  State<ChangeParticipantEventStatusDialog> createState() =>
      _ChangeParticipantEventStatusDialogState();
}

class _ChangeParticipantEventStatusDialogState
    extends State<ChangeParticipantEventStatusDialog> {
  bool _isLoading = false;
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> _updateStatus(EventParticipantStatus newStatus) async {
    if (_isLoading) return;

    final loadingProvider = context.read<LoadingProvider>();

    setState(() {
      _isLoading = true;
    });

    loadingProvider.show(
      text: context
          .localizations
          .live_events_screen_change_dependent_status_dialog_loading,
    );

    try {
      await _supabaseService.updateDependentEventParticipationStatus(
        eventId: widget.eventModel.eventId,
        dependentId: widget.dependent.dependentId,
        newStatus: newStatus.value,
      );

      String statusText = '';
      switch (newStatus) {
        case EventParticipantStatus.signedUp:
          if (mounted) {
            statusText = context
                .localizations
                .live_events_screen_change_dependent_status_dialog_signed_up;
          }
          break;
        case EventParticipantStatus.excused:
          if (mounted) {
            statusText = context
                .localizations
                .live_events_screen_change_dependent_status_dialog_excused;
          }
          break;
        case EventParticipantStatus.notSpecified:
          if (mounted) {
            statusText = context
                .localizations
                .live_events_screen_change_dependent_status_dialog_no_response;
          }
          break;
      }

      await Future.wait(
        widget.dependentsProvider.dependents.map((dependent) async {
          final participation = await _supabaseService
              .getDependentParticipation(dependent.dependentId);
          widget.dependentsProvider.setParticipation(
            dependent.dependentId,
            participation,
          );
        }),
      );

      if (mounted) {
        loadingProvider.hide();
        Navigator.of(context).pop();
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description: context.localizations
              .live_events_screen_change_dependent_status_dialog_success(
                '${widget.dependent.dependentDetails?.name} ${widget.dependent.dependentDetails?.surname}',
                statusText,
              ),
        );
      }
    } catch (e) {
      loadingProvider.hide();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description: context
              .localizations
              .live_events_screen_change_dependent_status_dialog_error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderGradientColor = switch (widget.oldStatus) {
      EventParticipantStatus.notSpecified =>
        AppGradients.secondaryPrimaryGradient(context),
      EventParticipantStatus.signedUp => AppGradients.successGradient(context),
      EventParticipantStatus.excused => AppGradients.errorGradient(context),
    };

    return PopScope(
      canPop: !_isLoading,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xLarge),
        child: Stack(
          children: [
            Container(
              decoration: ShapeDecoration(
                gradient: borderGradientColor,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: AppRadius.xLarge,
                    cornerSmoothing: AppRadius.smoothNormal,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(2), // Border width
              child: Container(
                // Top container - background color (smaller, creates border effect)
                decoration: ShapeDecoration(
                  color: context.colors.background.light,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius:
                          AppRadius.xLarge - 2, // Adjusted for border width
                      cornerSmoothing: AppRadius.smoothNormal,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      context
                          .localizations
                          .live_events_screen_change_dependent_status_dialog_title,
                      style: AppTextTheme.titleMedium(
                        context,
                      ).copyWith(color: context.colors.text.normal),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Text(
                      context.localizations
                          .live_events_screen_change_dependent_status_dialog_description(
                            '${widget.dependent.dependentDetails?.name} ${widget.dependent.dependentDetails?.surname}',
                            widget.eventModel.title ?? '',
                          ),
                      style: AppTextTheme.bodyMedium(
                        context,
                      ).copyWith(color: context.colors.text.normal),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.large),

                    Column(
                      spacing: AppSpacing.small,
                      children: [
                        GestureDetector(
                          onTap:
                              widget.oldStatus ==
                                  EventParticipantStatus.signedUp
                              ? null
                              : () => _updateStatus(
                                  EventParticipantStatus.signedUp,
                                ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xSmall,
                              horizontal: AppSpacing.small,
                            ),
                            decoration: AppDecorations.secondaryContainer(
                              context,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context
                                      .localizations
                                      .live_events_screen_change_dependent_status_dialog_signed_up,
                                  style: AppTextTheme.bodyLarge(context)
                                      .copyWith(
                                        color:
                                            widget.oldStatus ==
                                                EventParticipantStatus.signedUp
                                            ? context.colors.text.muted
                                            : context.colors.text.normal,
                                      ),
                                ),
                                MainButton(
                                  style: ButtonStyleTypes.filled,
                                  variant: ButtonStylesVariants.success,
                                  type: ButtonType.icon,
                                  iconAsset: 'assets/icons/check.svg',
                                  text: '',
                                  state:
                                      widget.oldStatus ==
                                          EventParticipantStatus.signedUp
                                      ? ButtonState.disabled
                                      : ButtonState.released,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              widget.oldStatus == EventParticipantStatus.excused
                              ? null
                              : () => _updateStatus(
                                  EventParticipantStatus.excused,
                                ),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.small),
                            decoration: AppDecorations.secondaryContainer(
                              context,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context
                                      .localizations
                                      .live_events_screen_change_dependent_status_dialog_excused,
                                  style: AppTextTheme.bodyLarge(context)
                                      .copyWith(
                                        color:
                                            widget.oldStatus ==
                                                EventParticipantStatus.excused
                                            ? context.colors.text.muted
                                            : context.colors.text.normal,
                                      ),
                                ),
                                MainButton(
                                  style: ButtonStyleTypes.filled,
                                  variant: ButtonStylesVariants.destructive,
                                  type: ButtonType.icon,
                                  iconAsset: 'assets/icons/x.svg',
                                  text: '',
                                  state:
                                      widget.oldStatus ==
                                          EventParticipantStatus.excused
                                      ? ButtonState.disabled
                                      : ButtonState.released,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              widget.oldStatus ==
                                  EventParticipantStatus.notSpecified
                              ? null
                              : () => _updateStatus(
                                  EventParticipantStatus.notSpecified,
                                ),
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.small),
                            decoration: AppDecorations.secondaryContainer(
                              context,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  context
                                      .localizations
                                      .live_events_screen_change_dependent_status_dialog_no_response,
                                  style: AppTextTheme.bodyLarge(context)
                                      .copyWith(
                                        color:
                                            widget.oldStatus ==
                                                EventParticipantStatus
                                                    .notSpecified
                                            ? context.colors.text.muted
                                            : context.colors.text.normal,
                                      ),
                                ),
                                MainButton(
                                  style: ButtonStyleTypes.filled,
                                  variant: ButtonStylesVariants.normal,
                                  type: ButtonType.icon,
                                  iconAsset: 'assets/icons/minus.svg',
                                  text: '',
                                  state:
                                      widget.oldStatus ==
                                          EventParticipantStatus.notSpecified
                                      ? ButtonState.disabled
                                      : ButtonState.released,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!_isLoading)
              Positioned(
                top: 16.0,
                right: 16.0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    'assets/icons/x.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.colors.text.normal,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
