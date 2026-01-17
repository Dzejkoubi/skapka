import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_participant_model.freezed.dart';
part 'event_participant_model.g.dart';

enum EventParticipantStatus {
  @JsonValue('signed_up')
  signedUp('signed_up'),
  @JsonValue('excused')
  excused('excused'),
  @JsonValue('not_specified')
  notSpecified('not_specified');

  final String value;
  const EventParticipantStatus(this.value);

  static EventParticipantStatus fromString(String val) {
    return EventParticipantStatus.values.firstWhere(
      (e) => e.value == val,
      orElse: () => EventParticipantStatus.notSpecified,
    );
  }
}

@freezed
abstract class EventParticipantModel with _$EventParticipantModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory EventParticipantModel({
    required String eventId,
    required String dependentId,
    required String groupId,
    required EventParticipantStatus status,
    @Default(true) bool? hasAttended,
    String? note,
  }) = _EventParticipantModel;

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantModelFromJson(json);
}
