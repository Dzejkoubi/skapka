import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/forms/custom_form.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:skapka_app/widgets/wrappers/scrollable_on_keyboard_screen_wrapper.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/event_date_selector.dart';
import 'package:skapka_app/screens/create_edit_event_screen.dart/widgets/create_edit_event_speed_dial.dart';

@RoutePage()
class CreateEditEventScreen extends StatefulWidget {
  final EventModel? event;
  final EventTimeType? eventTimeType;
  const CreateEditEventScreen({super.key, this.event, this.eventTimeType});

  @override
  State<CreateEditEventScreen> createState() => _CreateEditEventScreenState();
}

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  final TextEditingController _eventTitleController = TextEditingController();
  DateTime? _openSignUp;
  DateTime? _closeSignUp;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _eventTitleController.text = widget.event!.title ?? '';
      _openSignUp = widget.event!.openSignUp;
      _closeSignUp = widget.event!.closeSignUp;
      _startDate = widget.event!.startDate;
      _endDate = widget.event!.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ValueNotifier<bool>(false),
      child: Builder(
        builder: (context) {
          final dialOpenNotifier = context.watch<ValueNotifier<bool>>();
          return ScreenWrapper(
            appBar: Appbar(
              showBackChevron: true,
              showSettingsIcon: false,
              screenName: widget.event == null
                  ? AppLocalizations.of(
                      context,
                    )!.create_edit_event_screen_title_create
                  : AppLocalizations.of(
                      context,
                    )!.create_edit_event_screen_title_edit,
            ),
            body: SafeArea(
              child: ScrollableOnKeyboardScreenWrapper(
                builder: (constraints) {
                  return Column(
                    spacing: AppSpacing.large,
                    children: [
                      CustomForm(
                        controller: _eventTitleController,
                        labelText: AppLocalizations.of(
                          context,
                        )!.create_edit_event_screen_event_title_hint,
                        characterLimit: 50,
                        showSuffixIcon: false,
                        validator: (title) {
                          if (title == null || title.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.create_edit_event_screen_event_title_error_empty;
                          } else if (title.length > 50) {
                            return AppLocalizations.of(
                              context,
                            )!.create_edit_event_screen_event_title_error_too_long;
                          }
                          return null;
                        },
                      ),
                      EventDateSelector(
                        openSignUp: _openSignUp,
                        closeSignUp: _closeSignUp,
                        startDate: _startDate,
                        endDate: _endDate,
                        onOpenSignUpChanged: (d) =>
                            setState(() => _openSignUp = d),
                        onCloseSignUpChanged: (d) =>
                            setState(() => _closeSignUp = d),
                        onStartDateChanged: (d) =>
                            setState(() => _startDate = d),
                        onEndDateChanged: (d) => setState(() => _endDate = d),
                      ),
                    ],
                  );
                },
              ),
            ),
            speedDialChildren: CreateEditEventSpeedDial.build(
              context: context,
              dialOpenNotifier: dialOpenNotifier,
              event: widget.event,
              eventTimeType: widget.eventTimeType,
              onDelete: () {
                if (kDebugMode) print('User confirmed delete event');
              },
              onPublish: () {
                if (kDebugMode) print('User confirmed publish event');
              },
              onUnpublish: () {
                if (kDebugMode) print('User confirmed unpublish event');
              },
              onSave: ({required bool asDraft}) {
                if (kDebugMode)
                  print('User confirmed save event (asDraft: $asDraft)');
              },
            ),
            fabKey: dialOpenNotifier.hashCode,
            openCloseDial: dialOpenNotifier,
          );
        },
      ),
    );
  }
}
