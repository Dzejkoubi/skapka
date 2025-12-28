import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: false,
        screenName: AppLocalizations.of(context)!.events_screen_title,
        showSettingsIcon: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [Text('Events Screen Content'), Container(height: 800)],
          ),
        ),
      ),
    );
  }
}
