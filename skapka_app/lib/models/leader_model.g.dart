// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaderModel _$LeaderModelFromJson(Map<String, dynamic> json) => _LeaderModel(
  dependentId: json['dependent_id'] as String,
  patrolId: json['patrol_id'] as String,
  groupId: json['group_id'] as String,
);

// ignore: unused_element
Map<String, dynamic> _$LeaderModelToJson(_LeaderModel instance) =>
    <String, dynamic>{
      'dependent_id': instance.dependentId,
      'patrol_id': instance.patrolId,
      'group_id': instance.groupId,
    };
