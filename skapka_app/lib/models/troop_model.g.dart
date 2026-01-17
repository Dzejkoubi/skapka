// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'troop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TroopModel _$TroopModelFromJson(Map<String, dynamic> json) => _TroopModel(
  troopId: json['troop_id'] as String,
  name: json['name'] as String,
  number: (json['number'] as num).toInt(),
  groupId: json['group_id'] as String,
  skautisId: (json['skautis_id'] as num).toInt(),
);

Map<String, dynamic> _$TroopModelToJson(_TroopModel instance) =>
    <String, dynamic>{
      'troop_id': instance.troopId,
      'name': instance.name,
      'number': instance.number,
      'group_id': instance.groupId,
      'skautis_id': instance.skautisId,
    };
