enum EventParticipantStatus {
  signedUp('signed_up'),
  excused('excused'),
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

class EventParticipantModel {
  final String eventId;
  final String dependentId;
  final String groupId;
  final EventParticipantStatus status;
  final String note;

  EventParticipantModel({
    required this.eventId,
    required this.dependentId,
    required this.groupId,
    required this.status,
    required this.note,
  });

  factory EventParticipantModel.fromJson(Map<String, dynamic> json) {
    return EventParticipantModel(
      eventId: json['event_id'] as String,
      dependentId: json['dependent_id'] as String,
      groupId: json['group_id'] as String,
      status: EventParticipantStatus.fromString(json['status'] as String),
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'dependent_id': dependentId,
      'group_id': groupId,
      'status': status.value, // Returns snake_case string
      'note': note,
    };
  }

  EventParticipantModel copyWith({
    String? eventId,
    String? dependentId,
    String? groupId,
    EventParticipantStatus? status,
    String? note,
  }) {
    return EventParticipantModel(
      eventId: eventId ?? this.eventId,
      dependentId: dependentId ?? this.dependentId,
      groupId: groupId ?? this.groupId,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }
}
