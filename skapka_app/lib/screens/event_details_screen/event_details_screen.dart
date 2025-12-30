import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/screens/calendar_screen/widgets/events_expansion_tile.dart';
import 'package:skapka_app/utils/is_user_admin.dart';
import 'package:skapka_app/utils/is_user_leader.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final EventTimeType eventTimeType;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.eventTimeType,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: event.title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: AppDecorations.primaryContainer(context),
              padding: EdgeInsets.all(AppSpacing.small),
              child: Column(
                spacing: AppSpacing.xSmall,
                children: [
                  if (isUserLeader(context))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(
                            context,
                          )!.create_event_screen_event_sign_up_from,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.create_event_screen_event_sign_up_to,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.create_event_screen_event_from_hint,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.create_event_screen_event_to_hint,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
