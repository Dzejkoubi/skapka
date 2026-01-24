import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class EditLeadersScreen extends StatelessWidget {
  const EditLeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // I need group dependents(saved in admin panel provider), Group them by is_leader to the top and i also need rows from dependents_leaders table,those leaders that have also dependent leaders table entry should be at the top of the list
    // Get depndets from admin panel provider or supabase service
    // Get leaders from admin panel provider or supabase service
    // Create list of dependents sorted by is_leader and those that are also in leaders table at the top
    // Leaders show leader badge, if leader is also in dependents_leaders table, show special badge
    // Leader cannot have dependent leaders assigned without being a leader himself
    return ScreenWrapper(
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName:
            context.localizations.admin_panel_screen_button_edit_leaders,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.bottomSpace + AppSpacing.xxLarge,
            ),
            child: Column(children: []),
          ),
        ),
      ),
    );
  }
}
