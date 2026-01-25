// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventParticipantModel _$EventParticipantModelFromJson(
  Map<String, dynamic> json,
) => _EventParticipantModel(
  eventId: json['event_id'] as String,
  dependentId: json['dependent_id'] as String,
  groupId: json['group_id'] as String,
  status: $enumDecode(_$EventParticipantStatusEnumMap, json['status']),
  hasAttended: json['has_attended'] as bool? ?? true,
  note: json['note'] as String?,
);

Map<String, dynamic> _$EventParticipantModelToJson(
  _EventParticipantModel instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'dependent_id': instance.dependentId,
  'group_id': instance.groupId,
  'status': _$EventParticipantStatusEnumMap[instance.status]!,
  'has_attended': instance.hasAttended,
  'note': instance.note,
};

const _$EventParticipantStatusEnumMap = {
  EventParticipantStatus.signedUp: 'signed_up',
  EventParticipantStatus.excused: 'excused',
  EventParticipantStatus.notSpecified: 'not_specified',
};
