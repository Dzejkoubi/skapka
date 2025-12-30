import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';

class MeetingPlaceContainer extends StatelessWidget {
  const MeetingPlaceContainer({
    super.key,
    required TextEditingController meetingPlaceController,
  }) : _meetingPlaceController = meetingPlaceController;

  final TextEditingController _meetingPlaceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xSmall),
      child: Column(
        spacing: AppSpacing.medium,
        children: [
          CustomForm(
            controller: _meetingPlaceController,
            labelText: context
                .localizations
                .create_edit_event_screen_meeting_place_text,
            characterLimit: 50,
            showSuffixIcon: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xSmall),
            child: Text(
              context
                  .localizations
                  .create_edit_event_screen_meeting_place_description,
              style: AppTextTheme.bodySmall(
                context,
              ).copyWith(color: context.colors.text.muted),
            ),
          ),
        ],
      ),
    );
  }
}
