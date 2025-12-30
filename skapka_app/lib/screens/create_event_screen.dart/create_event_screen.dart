import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/main_button_theme.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(showBackChevron: true, showSettingsIcon: false),
      body: const Placeholder(),
      speedDialChildren: [
        SpeedDialChild(
          labelWidget: MainButton.filled(
            variant: ButtonStylesVariants.normal,
            text: AppLocalizations.of(
              context,
            )!.events_screen_speed_dial_open_create_event_text,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
