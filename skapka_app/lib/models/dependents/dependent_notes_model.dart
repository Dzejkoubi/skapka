import 'package:freezed_annotation/freezed_annotation.dart';

part 'dependent_notes_model.freezed.dart';
part 'dependent_notes_model.g.dart';

@freezed
abstract class DependentNotesModel with _$DependentNotesModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DependentNotesModel({
    // Dietary Flags
    bool? hasGlutenAllergy,
    bool? hasLactoseIntolerance,
    bool? hasNutAllergy,
    // Medical Flags
    bool? hasAsthma,
    bool? isClaustrophobic,
    bool? hasEpilepsy,
    bool? isSwimmer,
    // Text Details
    String? otherNote,
  }) = _DependentNotesModel;

  factory DependentNotesModel.fromJson(Map<String, dynamic> json) =>
      _$DependentNotesModelFromJson(json);

  factory DependentNotesModel.empty() {
    return DependentNotesModel(
      hasGlutenAllergy: null,
      hasLactoseIntolerance: null,
      hasNutAllergy: null,
      hasAsthma: null,
      isClaustrophobic: null,
      hasEpilepsy: null,
      isSwimmer: null,
      otherNote: '',
    );
  }
}
