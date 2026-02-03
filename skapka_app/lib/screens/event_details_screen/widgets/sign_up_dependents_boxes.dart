import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/change_participant_event_status_dialog.dart';
import 'package:skapka_app/widgets/event_box/participant_event_status_box.dart';

class SignUpDependentsBoxes extends StatelessWidget {
  const SignUpDependentsBoxes({
    super.key,
    required this.dependentsProvider,
    required this.event,
    required this.eventTimeType,
  });

  final DependentsProvider dependentsProvider;
  final EventModel event;
  final EventTimeType eventTimeType;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.small,
      children: [
        for (var dependent in dependentsProvider.dependents.where(
          (d) => d.isArchived != true,
        ))
          Builder(
            builder: (context) {
              final participation = dependentsProvider
                  .getParticipationForDependent(dependent.dependentId);
              final eventParticipationList = participation.where(
                (p) => p.eventId == event.eventId,
              );

              if (eventParticipationList.isEmpty) {
                return const SizedBox.shrink();
              }
              final eventParticipation = eventParticipationList.first;

              final bool isEnabled =
                  eventTimeType == EventTimeType.live &&
                  event.closeSignUp!.isAfter(DateTime.now());
              // Allow changing status only if the event is live and the sign-up deadline has not passed

              return GestureDetector(
                onTap: isEnabled
                    ? () async {
                        await Future.delayed(Duration.zero);
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            useRootNavigator: true,
                            builder: (builder) {
                              return ChangeParticipantEventStatusDialog(
                                dependent: dependent,
                                eventModel: event,
                                oldStatus: eventParticipation.status,
                                dependentsProvider: context
                                    .read<DependentsProvider>(),
                              );
                            },
                          );
                        }
                        Gaimon.success();
                      }
                    : () {
                        Gaimon.error();
                        BottomDialog.show(
                          context,
                          type: BottomDialogType.negative,
                          description: context
                              .localizations
                              .live_events_screen_cannot_change_status_past_signup_deadline,
                        );
                      },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.small,
                    vertical: AppSpacing.xSmall,
                  ),
                  decoration: AppDecorations.primaryContainer(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${dependent.name} ${dependent.surname}',
                        style: AppTextTheme.bodyLarge(
                          context,
                        ).copyWith(color: context.colors.text.normal),
                      ),
                      AbsorbPointer(
                        child: ParticipantEventStatusBox(
                          status: eventParticipation.status,
                          isEnabled: isEnabled,
                          eventModel: event,
                          dependent: dependent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
