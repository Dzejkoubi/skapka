// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => _GroupModel(
  groupId: json['group_id'],
  skautisId: json['skautis_id'],
  name: json['name'] as String,
  number: json['number'] as String,
);

Map<String, dynamic> _$GroupModelToJson(_GroupModel instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'skautis_id': instance.skautisId,
      'name': instance.name,
      'number': instance.number,
    };
