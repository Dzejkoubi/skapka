import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/router/router.gr.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_sizes.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/create_edit_event_screen.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/participant_info_row.dart';

class EventParticipantsContainer extends StatelessWidget {
  const EventParticipantsContainer({
    super.key,
    required this.widget,
    required int totalParticipantsCount,
    required String targetPatrolNames,
    required int totalLeadersCount,
    required int total18PlusCount,
    required int totalSignedUpParticipantsCount,
  }) : _totalParticipantsCount = totalParticipantsCount,
       _targetPatrolNames = targetPatrolNames,
       _totalLeadersCount = totalLeadersCount,
       _total18PlusCount = total18PlusCount,
       _totalSignedUpParticipantsCount = totalSignedUpParticipantsCount;
  final CreateEditEventScreen widget;
  final int _totalParticipantsCount;
  final String _targetPatrolNames;
  final int _totalLeadersCount;
  final int _total18PlusCount;
  final int _totalSignedUpParticipantsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.primaryContainer(context),
      padding: EdgeInsets.all(AppSpacing.small),
      child: Column(
        spacing: AppSpacing.medium,
        children: [
          GestureDetector(
            onTap: () {
              context.router.push(
                CreateEditEventParticipantsRoute(
                  eventParticipants: widget.eventParticipants,
                ),
              );
            },
            child: Container(
              decoration: AppDecorations.secondaryContainer(context),
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
                      AppLocalizations.of(
                        context,
                      )!.create_edit_event_screen_select_participants_text,
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xSmall),
            child: Column(
              spacing: AppSpacing.xSmall,
              children: [
                ParticipantInfoRow(
                  label: context
                      .localizations
                      .create_edit_event_screen_total_participants_text,
                  value: '$_totalParticipantsCount',
                ),
                ParticipantInfoRow(
                  label: context
                      .localizations
                      .create_edit_event_screen_total_signed_up_participants_text,
                  value: '$_totalSignedUpParticipantsCount',
                ),
                ParticipantInfoRow(
                  label: context.localizations.create_edit_event_screen_18_plus,
                  value: '$_total18PlusCount',
                ),
                ParticipantInfoRow(
                  label: context.localizations.create_edit_event_screen_leaders,
                  value: '$_totalLeadersCount',
                ),
                ParticipantInfoRow(
                  label: context.localizations.create_edit_event_screen_troops,
                  value: _targetPatrolNames,
                  isScrollable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
