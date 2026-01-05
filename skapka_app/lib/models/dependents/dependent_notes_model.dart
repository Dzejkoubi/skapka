class DependentNotesModel {
  // Dietary Flags
  final bool? hasGlutenAllergy;
  final bool? hasLactoseIntolerance;
  final bool? hasNutAllergy;

  // Medical Flags
  final bool? hasAsthma;
  final bool? isClaustrophobic;
  final bool? hasEpilepsy;
  final bool? isSwimmer;

  // Text Details
  final String? otherNote;

  DependentNotesModel({
    this.hasGlutenAllergy,
    this.hasLactoseIntolerance,
    this.hasNutAllergy,
    this.hasAsthma,
    this.isClaustrophobic,
    this.hasEpilepsy,
    this.isSwimmer,
    this.otherNote,
  });

  factory DependentNotesModel.fromJson(Map<String, dynamic> json) {
    return DependentNotesModel(
      hasGlutenAllergy: json['has_gluten_allergy'] as bool?,
      hasLactoseIntolerance: json['has_lactose_intolerance'] as bool?,
      hasNutAllergy: json['has_nut_allergy'] as bool?,
      hasAsthma: json['has_asthma'] as bool?,
      isClaustrophobic: json['is_claustrophobic'] as bool?,
      hasEpilepsy: json['has_epilepsy'] as bool?,
      isSwimmer: json['is_swimmer'] as bool?,
      otherNote: json['other_note'] as String?,
    );
  }
}
