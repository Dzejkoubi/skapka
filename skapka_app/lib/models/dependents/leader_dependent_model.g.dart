// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader_dependent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderDependentModel _$LeaderDependentModelFromJson(
  Map<String, dynamic> json,
) => _LeaderDependentModel(
  dependent: DependentModel.fromJson(json['dependent'] as Map<String, dynamic>),
  leaderOfPatrolId: (json['leader_of_patrol_id'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$LeaderDependentModelToJson(
  _LeaderDependentModel instance,
) => <String, dynamic>{
  'dependent': instance.dependent,
  'leader_of_patrol_id': instance.leaderOfPatrolId,
};
