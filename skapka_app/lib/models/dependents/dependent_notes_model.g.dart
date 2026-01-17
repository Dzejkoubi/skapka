// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent_notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DependentNotesModel _$DependentNotesModelFromJson(Map<String, dynamic> json) =>
    _DependentNotesModel(
      hasGlutenAllergy: json['has_gluten_allergy'] as bool?,
      hasLactoseIntolerance: json['has_lactose_intolerance'] as bool?,
      hasNutAllergy: json['has_nut_allergy'] as bool?,
      hasAsthma: json['has_asthma'] as bool?,
      isClaustrophobic: json['is_claustrophobic'] as bool?,
      hasEpilepsy: json['has_epilepsy'] as bool?,
      isSwimmer: json['is_swimmer'] as bool?,
      otherNote: json['other_note'] as String?,
    );

Map<String, dynamic> _$DependentNotesModelToJson(
  _DependentNotesModel instance,
) => <String, dynamic>{
  'has_gluten_allergy': instance.hasGlutenAllergy,
  'has_lactose_intolerance': instance.hasLactoseIntolerance,
  'has_nut_allergy': instance.hasNutAllergy,
  'has_asthma': instance.hasAsthma,
  'is_claustrophobic': instance.isClaustrophobic,
  'has_epilepsy': instance.hasEpilepsy,
  'is_swimmer': instance.isSwimmer,
  'other_note': instance.otherNote,
};
