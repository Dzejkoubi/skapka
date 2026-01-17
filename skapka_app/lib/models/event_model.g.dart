// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventModel _$EventModelFromJson(Map<String, dynamic> json) => _EventModel(
  eventId: json['event_id'] as String,
  title: json['title'] as String,
  instructions: json['instructions'] as String?,
  openSignUp: json['open_sign_up'] == null
      ? null
      : DateTime.parse(json['open_sign_up'] as String),
  closeSignUp: json['close_sign_up'] == null
      ? null
      : DateTime.parse(json['close_sign_up'] as String),
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  meetingPlace: json['meeting_place'] as String?,
  photoAlbumLink: json['photo_album_link'] as String?,
  groupId: json['group_id'] as String,
  targetPatrolsIds: (json['target_patrols_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  lastEditedBy: json['last_edited_by'] as String?,
  isDraft: json['is_draft'] as bool,
);

Map<String, dynamic> _$EventModelToJson(_EventModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'title': instance.title,
      'instructions': instance.instructions,
      'open_sign_up': instance.openSignUp?.toIso8601String(),
      'close_sign_up': instance.closeSignUp?.toIso8601String(),
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'meeting_place': instance.meetingPlace,
      'photo_album_link': instance.photoAlbumLink,
      'group_id': instance.groupId,
      'target_patrols_ids': instance.targetPatrolsIds,
      'last_edited_by': instance.lastEditedBy,
      'is_draft': instance.isDraft,
    };
