class EventParticipant {
  String eventId;
  String dependentId;
  String status;
  String note;
  EventParticipant({
    required this.eventId,
    required this.dependentId,
    required this.status,
    required this.note,
  });

  factory EventParticipant.fromJson(Map<String, dynamic> json) {
    return EventParticipant(
      eventId: json['event_id'] as String,
      dependentId: json['dependent_id'] as String,
      status: json['status'] as String,
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'dependent_id': dependentId,
      'status': status,
      'note': note,
    };
  }

  EventParticipant copyWith({
    String? eventId,
    String? dependentId,
    String? status,
    String? note,
  }) {
    return EventParticipant(
      eventId: eventId ?? this.eventId,
      dependentId: dependentId ?? this.dependentId,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }
}
