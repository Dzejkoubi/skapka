import 'package:auto_route/auto_route.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_radius.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/custom_dropdown_menu.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_text_field.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';
import 'package:provider/provider.dart';

@RoutePage()
class EditDependentDetailsScreen extends StatefulWidget {
  final AccountDependentModel dependent;

  const EditDependentDetailsScreen({super.key, required this.dependent});

  @override
  State<EditDependentDetailsScreen> createState() =>
      _EditDependentDetailsScreenState();
}

class _EditDependentDetailsScreenState
    extends State<EditDependentDetailsScreen> {
  late DependentNotesModel _originalNotes;
  // Services and providers
  final SupabaseService _supabaseService = SupabaseService();
  late final loadingProvider = context.read<LoadingProvider>();
  late final dependentsProvider = context.read<DependentsProvider>();

  // State variables for 3-state bools (true/false/null)
  bool? _hasGlutenAllergy;
  bool? _hasLactoseIntolerance;
  bool? _hasNutAllergy;
  bool? _hasAsthma;
  bool? _isClaustrophobic;
  bool? _hasEpilepsy;
  bool? _isSwimmer;

  // Controllers for text notes
  late final TextEditingController _otherNoteController;

  bool get _hasChanges {
    return _hasGlutenAllergy != _originalNotes.hasGlutenAllergy ||
        _hasLactoseIntolerance != _originalNotes.hasLactoseIntolerance ||
        _hasNutAllergy != _originalNotes.hasNutAllergy ||
        _hasAsthma != _originalNotes.hasAsthma ||
        _isClaustrophobic != _originalNotes.isClaustrophobic ||
        _hasEpilepsy != _originalNotes.hasEpilepsy ||
        _isSwimmer != _originalNotes.isSwimmer ||
        _otherNoteController.text.trim() != (_originalNotes.otherNote ?? '');
  }

  Future<void> _saveChanges() async {
    loadingProvider.show();
    try {
      await _supabaseService.updateDependentNotes(
        dependentId: widget.dependent.dependentId,
        notes: editedNotes,
      );

      final freshNotes = await _supabaseService.getDependentNotes(
        widget.dependent.dependentId,
      );

      if (freshNotes != null) {
        dependentsProvider.updateDependentNotes(
          widget.dependent.dependentId,
          freshNotes,
        );
      }

      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.positive,
          description: context.localizations.dependents_screen_save_success,
        );

        context.router.pop();
      }
    } catch (e) {
      if (mounted) {
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description: context.localizations.generic_error,
        );
      }
    } finally {
      loadingProvider.hide();
    }
  }

  Future<void> _showUnsavedChangesDialog() async {
    await showDialog(
      context: context,
      builder: (context) => LargeDialog(
        type: LargeDialogType.basic,
        title: context.localizations.save,
        description: context
            .localizations
            .dependents_screen_unsaved_changes_dialog_description,
        primaryButtonText: context.localizations.save,
        secondaryButtonText: context.localizations.cancel,
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          _saveChanges();
        },
        onSecondaryPressed: () {
          context.router.pop();
          context.router.pop();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _originalNotes = widget.dependent.notes;

    // Initialize state variables
    _hasGlutenAllergy = _originalNotes.hasGlutenAllergy;
    _hasLactoseIntolerance = _originalNotes.hasLactoseIntolerance;
    _hasNutAllergy = _originalNotes.hasNutAllergy;
    _hasAsthma = _originalNotes.hasAsthma;
    _isClaustrophobic = _originalNotes.isClaustrophobic;
    _hasEpilepsy = _originalNotes.hasEpilepsy;
    _isSwimmer = _originalNotes.isSwimmer;

    _otherNoteController = TextEditingController(
      text: _originalNotes.otherNote,
    );
  }

  DependentNotesModel get editedNotes => DependentNotesModel(
    hasGlutenAllergy: _hasGlutenAllergy,
    hasLactoseIntolerance: _hasLactoseIntolerance,
    hasNutAllergy: _hasNutAllergy,
    hasAsthma: _hasAsthma,
    isClaustrophobic: _isClaustrophobic,
    hasEpilepsy: _hasEpilepsy,
    isSwimmer: _isSwimmer,
    otherNote: _otherNoteController.text.trim(),
  );

  List<DropdownMenuEntry<bool?>> get _threeStateEntries => [
    DropdownMenuEntry(
      value: true,
      label: context.localizations.yes,
      labelWidget: Text(
        context.localizations.yes,
        style: AppTextTheme.bodyMedium(context),
      ),
    ),
    DropdownMenuEntry(
      value: false,
      label: context.localizations.no,
      labelWidget: Text(
        context.localizations.no,
        style: AppTextTheme.bodyMedium(context),
      ),
    ),
    DropdownMenuEntry(
      value: null,
      label: '-',
      labelWidget: Text('-', style: AppTextTheme.bodyMedium(context)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _showUnsavedChangesDialog();
      },
      child: Stack(
        children: [
          ScreenWrapper(
            appBar: Appbar(
              showBackChevron: true,
              screenName: context
                  .localizations
                  .dependents_screen_dependent_notes_button_text,
              showSettingsIcon: false,
              onBackPressed: () async {
                if (_hasChanges) {
                  await _showUnsavedChangesDialog();
                } else {
                  context.router.pop();
                }
              },
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  spacing: AppSpacing.large,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          '${widget.dependent.name} ${widget.dependent.surname}',
                          style: AppTextTheme.titleMedium(context),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          context
                              .localizations
                              .dependents_screen_dependent_description,
                          style: AppTextTheme.labelLarge(context),
                        ),
                      ],
                    ),
                    Container(
                      decoration: ShapeDecoration(
                        color: context.colors.background.light,
                        shape: SmoothRectangleBorder(
                          side: BorderSide(
                            color: context.colors.background.medium,
                            width: 1.0,
                          ),
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: AppRadius.large,
                            cornerSmoothing: AppRadius.smoothNormal,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(AppSpacing.medium),
                      child: Column(
                        spacing: AppSpacing.small,
                        children: [
                          _buildDropdownSection(
                            label: "Alergie na lepek",
                            value: _hasGlutenAllergy,
                            onSelected: (val) =>
                                setState(() => _hasGlutenAllergy = val),
                          ),
                          _buildDropdownSection(
                            label: "Intolerance laktózy",
                            value: _hasLactoseIntolerance,
                            onSelected: (val) =>
                                setState(() => _hasLactoseIntolerance = val),
                          ),
                          _buildDropdownSection(
                            label: "Alergie na ořechy",
                            value: _hasNutAllergy,
                            onSelected: (val) =>
                                setState(() => _hasNutAllergy = val),
                          ),
                          _buildDropdownSection(
                            label: "Astma",
                            value: _hasAsthma,
                            onSelected: (val) =>
                                setState(() => _hasAsthma = val),
                          ),
                          _buildDropdownSection(
                            label: "Klaustrofobie",
                            value: _isClaustrophobic,
                            onSelected: (val) =>
                                setState(() => _isClaustrophobic = val),
                          ),
                          _buildDropdownSection(
                            label: "Epilepsie",
                            value: _hasEpilepsy,
                            onSelected: (val) =>
                                setState(() => _hasEpilepsy = val),
                          ),
                          _buildDropdownSection(
                            label: "Plavec",
                            value: _isSwimmer,
                            onSelected: (val) =>
                                setState(() => _isSwimmer = val),
                          ),
                        ],
                      ),
                    ),
                    // Textová pole pro poznámky
                    Column(
                      spacing: AppSpacing.medium,
                      children: [
                        Column(
                          spacing: AppSpacing.xxSmall,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              context
                                  .localizations
                                  .dependents_screen_depents_details_other_notes,
                              style: AppTextTheme.titleMedium(context),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              context
                                  .localizations
                                  .dependents_screen_depents_details_other_notes_description,
                              style: AppTextTheme.labelLarge(context),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: _otherNoteController,
                          hintText: context
                              .localizations
                              .dependents_screen_depents_details_other_notes,
                          maxLines: 8,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.bottomSpace),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection({
    required String label,
    required bool? value,
    required ValueChanged<bool?> onSelected,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextTheme.labelLarge(context)),
          CustomDropdownMenu<bool?>(
            initialSelection: value,
            dropdownMenuEntries: _threeStateEntries,
            onSelected: onSelected,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _otherNoteController.dispose();
    super.dispose();
  }
}
