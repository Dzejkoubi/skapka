import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/app_localizations.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/forms/custom_text_field.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

@RoutePage()
class CreateEditEventInstructionsScreen extends StatefulWidget {
  final String? initialInstructions;
  final Function(String) onSave;

  const CreateEditEventInstructionsScreen({
    super.key,
    this.initialInstructions,
    required this.onSave,
  });

  @override
  State<CreateEditEventInstructionsScreen> createState() =>
      _CreateEditEventInstructionsScreenState();
}

class _CreateEditEventInstructionsScreenState
    extends State<CreateEditEventInstructionsScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialInstructions);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _insertMarkdown(String prefix, {String suffix = ''}) {
    final text = _controller.text;
    final selection = _controller.selection;

    // If no selection, just insert at cursor
    if (selection.start == -1) {
      _controller.text = '$text$prefix$suffix';
      return;
    }

    final selectedText = selection.textInside(text);
    final newText = text.replaceRange(
      selection.start,
      selection.end,
      '$prefix$selectedText$suffix',
    );

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection(
        baseOffset: selection.start + prefix.length,
        extentOffset: selection.start + prefix.length + selectedText.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      padding: EdgeInsets.zero,
      appBar: Appbar(
        showBackChevron: true,
        showSettingsIcon: false,
        screenName: AppLocalizations.of(
          context,
        )!.create_edit_instructions_screen_title,
        onBackPressed: () {
          widget.onSave(_controller.text);
          context.router.pop();
        },
      ),
      body: Column(
        children: [
          SizedBox(height: Appbar.topBarHeight + Appbar.bottomRadius),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: AppSpacing.small,
              children: [
                SizedBox(width: AppSpacing.xLarge),
                MainButton.outlined(
                  text: 'H1',
                  onPressed: () => _insertMarkdown('# '),
                ),
                MainButton.outlined(
                  text: 'H2',
                  onPressed: () => _insertMarkdown('## '),
                ),
                MainButton.outlined(
                  text: 'H3',
                  onPressed: () => _insertMarkdown('### '),
                ),
                MainButton.outlined(
                  text: 'B',
                  onPressed: () => _insertMarkdown('**', suffix: '**'),
                ),
                MainButton.outlined(
                  text: 'List',
                  onPressed: () => _insertMarkdown('* '),
                ),
                SizedBox(width: AppSpacing.xLarge),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xLarge,
              ),
              child: CustomTextField(
                controller: _controller,
                hintText: context
                    .localizations
                    .create_edit_event_screen_instructions_hint,
                maxLines: null,
                expands: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
