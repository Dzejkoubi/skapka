import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

enum EventTimeType { future, live, past, draft }

@freezed
abstract class EventModel with _$EventModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EventModel({
    required String eventId,
    required String title,
    required String? instructions,
    required DateTime? openSignUp,
    required DateTime? closeSignUp,
    required DateTime? startDate,
    required DateTime? endDate,
    required String? meetingPlace,
    required String? leavingPlace,
    required String? photoAlbumLink,
    required String groupId,
    required List<String>? targetPatrolsIds,
    required String? lastEditedBy,
    required bool isDraft,
  }) = _EventModel;

  factory EventModel.empty() => const EventModel(
    eventId: '',
    title: '',
    instructions: null,
    openSignUp: null,
    closeSignUp: null,
    startDate: null,
    endDate: null,
    meetingPlace: '',
    leavingPlace: '',
    photoAlbumLink: '',
    groupId: '',
    targetPatrolsIds: [],
    lastEditedBy: null,
    isDraft: true,
  );

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}
