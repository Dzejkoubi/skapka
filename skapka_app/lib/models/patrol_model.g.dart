// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patrol_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatrolModel _$PatrolModelFromJson(Map<String, dynamic> json) => _PatrolModel(
  patrolId: json['patrol_id'] as String,
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String?,
  troopId: json['troop_id'] as String,
  groupId: json['group_id'] as String,
  skautisId: (json['skautis_id'] as num).toInt(),
);

Map<String, dynamic> _$PatrolModelToJson(_PatrolModel instance) =>
    <String, dynamic>{
      'patrol_id': instance.patrolId,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'troop_id': instance.troopId,
      'group_id': instance.groupId,
      'skautis_id': instance.skautisId,
    };
