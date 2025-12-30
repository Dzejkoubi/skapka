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

class EventParticipantsContainer extends StatelessWidget {
  const EventParticipantsContainer({
    super.key,
    required this.widget,
    required int totalParticipantsCount,
    required String targetPatrolNames,
    required int totalLeadersCount,
    required int total18PlusCount,
  }) : _totalParticipantsCount = totalParticipantsCount,
       _targetPatrolNames = targetPatrolNames,
       _totalLeadersCount = totalLeadersCount,
       _total18PlusCount = total18PlusCount;

  final CreateEditEventScreen widget;
  final int _totalParticipantsCount;
  final String _targetPatrolNames;
  final int _totalLeadersCount;
  final int _total18PlusCount;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.localizations.create_edit_event_screen_total_participants_text}:',
                      style: AppTextTheme.bodyMedium(
                        context,
                      ).copyWith(color: context.colors.text.muted),
                    ),
                    const SizedBox(width: AppSpacing.medium),
                    Text(
                      '$_totalParticipantsCount',
                      style: AppTextTheme.bodyMedium(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.localizations.create_edit_event_screen_troops}:',
                      style: AppTextTheme.bodyMedium(
                        context,
                      ).copyWith(color: context.colors.text.muted),
                    ),
                    const SizedBox(width: AppSpacing.medium),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          _targetPatrolNames,
                          style: AppTextTheme.bodyMedium(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${context.localizations.create_edit_event_screen_18_leaders}:',
                      style: AppTextTheme.bodyMedium(
                        context,
                      ).copyWith(color: context.colors.text.muted),
                    ),
                    const SizedBox(width: AppSpacing.medium),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '$_totalLeadersCount / $_total18PlusCount',
                          style: AppTextTheme.bodyMedium(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
