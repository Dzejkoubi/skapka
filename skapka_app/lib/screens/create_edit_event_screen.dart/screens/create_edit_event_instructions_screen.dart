import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class CreateEditEventInstructionsScreen extends StatelessWidget {
  const CreateEditEventInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_instructions_screen_title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Column(children: [Text('ljflkdsjlfkds')])),
      ),
    );
  }
}
