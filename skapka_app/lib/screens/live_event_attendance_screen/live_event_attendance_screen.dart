import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class LiveEventAttendanceScreen extends StatelessWidget {
  const LiveEventAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: context.localizations.live_event_attendance_screen_title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(spacing: AppSpacing.large, children: []),
        ),
      ),
    );
  }
}
