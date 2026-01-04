import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skapka_app/app/l10n/l10n_extension.dart';
import 'package:skapka_app/app/theme/app_color_theme.dart';
import 'package:skapka_app/app/theme/app_decorations.dart';
import 'package:skapka_app/app/theme/app_spacing.dart';
import 'package:skapka_app/app/theme/app_text_theme.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/providers/account_provider.dart';
import 'package:skapka_app/providers/dependents_provider.dart';
import 'package:skapka_app/providers/loading_provider.dart';
import 'package:skapka_app/services/supabase_service.dart';
import 'package:skapka_app/widgets/appbar/appbar.dart';
import 'package:skapka_app/widgets/buttons/main_button.dart';
import 'package:skapka_app/widgets/dialogs/bottom_dialog.dart';
import 'package:skapka_app/widgets/dialogs/large_dialog.dart';
import 'package:skapka_app/widgets/forms/custom_text_field.dart';
import 'package:skapka_app/widgets/wrappers/screen_wrapper.dart';

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
  final SupabaseService _supabaseService = SupabaseService();
  late final TextEditingController _medicalNoteController;
  late final TextEditingController _dietaryNoteController;
  late final TextEditingController _otherNoteController;

  bool _hasGlutenAllergy = false;
  bool _hasLactoseIntolerance = false;
  bool _hasNutAllergy = false;
  bool _hasAsthma = false;
  bool _isClaustrophobic = false;
  bool _hasEpilepsy = false;
  bool _isSwimmer = false;

  bool _allowPop = false;

  bool get _hasChanges {
    final notes = widget.dependent.dependentDetails?.notes;

    if (_medicalNoteController.text != (notes?.medicalNote ?? '')) return true;
    if (_dietaryNoteController.text != (notes?.dietaryNote ?? '')) return true;
    if (_otherNoteController.text != (notes?.otherNote ?? '')) return true;

    if (_hasGlutenAllergy != (notes?.hasGlutenAllergy ?? false)) return true;
    if (_hasLactoseIntolerance != (notes?.hasLactoseIntolerance ?? false)) {
      return true;
    }
    if (_hasNutAllergy != (notes?.hasNutAllergy ?? false)) return true;
    if (_hasAsthma != (notes?.hasAsthma ?? false)) return true;
    if (_isClaustrophobic != (notes?.isClaustrophobic ?? false)) return true;
    if (_hasEpilepsy != (notes?.hasEpilepsy ?? false)) return true;
    if (_isSwimmer != (notes?.isSwimmer ?? false)) return true;

    return false;
  }

  @override
  void initState() {
    super.initState();
    final notes = widget.dependent.dependentDetails?.notes;
    _medicalNoteController = TextEditingController(text: notes?.medicalNote);
    _dietaryNoteController = TextEditingController(text: notes?.dietaryNote);
    _otherNoteController = TextEditingController(text: notes?.otherNote);

    _hasGlutenAllergy = notes?.hasGlutenAllergy ?? false;
    _hasLactoseIntolerance = notes?.hasLactoseIntolerance ?? false;
    _hasNutAllergy = notes?.hasNutAllergy ?? false;
    _hasAsthma = notes?.hasAsthma ?? false;
    _isClaustrophobic = notes?.isClaustrophobic ?? false;
    _hasEpilepsy = notes?.hasEpilepsy ?? false;
    _isSwimmer = notes?.isSwimmer ?? false;
  }

  @override
  void dispose() {
    _medicalNoteController.dispose();
    _dietaryNoteController.dispose();
    _otherNoteController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    context.read<LoadingProvider>().show();
    try {
      final notes = DependentNotesModel(
        hasGlutenAllergy: _hasGlutenAllergy,
        hasLactoseIntolerance: _hasLactoseIntolerance,
        hasNutAllergy: _hasNutAllergy,
        hasAsthma: _hasAsthma,
        isClaustrophobic: _isClaustrophobic,
        hasEpilepsy: _hasEpilepsy,
        isSwimmer: _isSwimmer,
        medicalNote: _medicalNoteController.text,
        dietaryNote: _dietaryNoteController.text,
        otherNote: _otherNoteController.text,
      );

      await _supabaseService.updateDependentNotes(
        dependentId: widget.dependent.dependentId,
        notes: notes,
      );

      if (mounted) {
        // Refresh dependents
        final accountProvider = context.read<AccountProvider>();
        final dependentsProvider = context.read<DependentsProvider>();
        final dependents = await _supabaseService.getAccountDependents(
          accountProvider.accountId,
        );
        dependentsProvider.setDependents(dependents);

        if (mounted) {
          context.read<LoadingProvider>().hide();
          context.router.pop();
          BottomDialog.show(
            context,
            type: BottomDialogType.positive,
            description: context.localizations.dependents_screen_save_success,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        context.read<LoadingProvider>().hide();
        BottomDialog.show(
          context,
          type: BottomDialogType.negative,
          description: context.localizations.generic_error,
        );
      }
    }
  }

  Future<void> _showUnsavedChangesDialog() async {
    await showDialog(
      context: context,
      builder: (context) => LargeDialog(
        type: LargeDialogType.basic,
        title: context
            .localizations
            .dependents_screen_unsaved_changes_dialog_title,
        description: context
            .localizations
            .dependents_screen_unsaved_changes_dialog_description,
        primaryButtonText:
            context.localizations.dependents_screen_unsaved_changes_dialog_save,
        secondaryButtonText: context
            .localizations
            .dependents_screen_unsaved_changes_dialog_discard,
        onPrimaryPressed: () {
          Navigator.of(context).pop();
          _saveChanges();
        },
        onSecondaryPressed: () {
          Navigator.of(context).pop();
          setState(() => _allowPop = true);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.router.pop();
          });
        },
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      decoration: AppDecorations.primaryContainer(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.small,
        vertical: AppSpacing.xSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: AppTextTheme.bodyMedium(context))),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: context.colors.primary.normal,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.medium,
        bottom: AppSpacing.small,
      ),
      child: Text(title, style: AppTextTheme.titleSmall(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _allowPop || !_hasChanges,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _showUnsavedChangesDialog();
      },
      child: ScreenWrapper(
        appBar: Appbar(
          showBackChevron: true,
          showSettingsIcon: false,
          screenName: context.localizations.dependents_screen_dependent_notes,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localizations.dependents_screen_dependent_description(
                      '${widget.dependent.dependentDetails?.name} ${widget.dependent.dependentDetails?.surname}',
                    ),
                    style: AppTextTheme.bodyMedium(
                      context,
                    ).copyWith(color: context.colors.text.muted),
                  ),
                  const SizedBox(height: AppSpacing.medium),

                  // Health Flags
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_has_gluten_allergy,
                    _hasGlutenAllergy,
                    (v) => setState(() => _hasGlutenAllergy = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_has_lactose_intolerance,
                    _hasLactoseIntolerance,
                    (v) => setState(() => _hasLactoseIntolerance = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_has_nut_allergy,
                    _hasNutAllergy,
                    (v) => setState(() => _hasNutAllergy = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_has_asthma,
                    _hasAsthma,
                    (v) => setState(() => _hasAsthma = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_is_claustrophobic,
                    _isClaustrophobic,
                    (v) => setState(() => _isClaustrophobic = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_has_epilepsy,
                    _hasEpilepsy,
                    (v) => setState(() => _hasEpilepsy = v),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  _buildSwitchTile(
                    context
                        .localizations
                        .dependents_screen_depents_details_is_swimmer,
                    _isSwimmer,
                    (v) => setState(() => _isSwimmer = v),
                  ),

                  // Notes
                  _buildSectionTitle(
                    context
                        .localizations
                        .dependents_screen_depents_details_other_medical_notes,
                  ),
                  CustomTextField(
                    controller: _medicalNoteController,
                    hintText: context
                        .localizations
                        .dependents_screen_depents_details_other_medical_notes,
                    maxLines: 3,
                  ),

                  _buildSectionTitle(
                    context
                        .localizations
                        .dependents_screen_depents_details_other_dietary_notes,
                  ),
                  CustomTextField(
                    controller: _dietaryNoteController,
                    hintText: context
                        .localizations
                        .dependents_screen_depents_details_other_dietary_notes,
                    maxLines: 3,
                  ),

                  _buildSectionTitle(
                    context
                        .localizations
                        .dependents_screen_depents_details_other_notes,
                  ),
                  CustomTextField(
                    controller: _otherNoteController,
                    hintText: context
                        .localizations
                        .dependents_screen_depents_details_other_notes,
                    maxLines: 3,
                  ),

                  const SizedBox(
                    height: AppSpacing.bottomSpace + AppSpacing.large,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
