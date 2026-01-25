// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'troop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TroopModel _$TroopModelFromJson(Map<String, dynamic> json) => _TroopModel(
  troopId: json['troop_id'] as String,
  name: json['name'] as String,
  groupId: json['group_id'] as String,
  skautisId: (json['skautis_id'] as num).toInt(),
);

Map<String, dynamic> _$TroopModelToJson(_TroopModel instance) =>
    <String, dynamic>{
      'troop_id': instance.troopId,
      'name': instance.name,
      'group_id': instance.groupId,
      'skautis_id': instance.skautisId,
    };
