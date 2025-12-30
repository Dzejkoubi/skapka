enum EventTimeType { future, live, past, draft }

class EventModel {
  final String eventId;
  final String? title;
  final String? instructions;
  final DateTime? openSignUp;
  final DateTime? closeSignUp;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? meetingPlace;
  final String? photoAlbumLink;
  final String? groupId;
  final List<String>? targetPatrolsIds;
  final String? lastEditedBy;
  final bool isDraft;
  EventModel({
    required this.eventId,
    required this.title,
    required this.instructions,
    required this.openSignUp,
    required this.closeSignUp,
    required this.startDate,
    required this.endDate,
    required this.meetingPlace,
    required this.photoAlbumLink,
    required this.groupId,
    required this.targetPatrolsIds,
    required this.lastEditedBy,
    required this.isDraft,
  });
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'] as String,
      title: json['title'] as String?,
      instructions: json['instructions'] as String?,
      openSignUp: json['open_sign_up'] != null
          ? DateTime.parse(json['open_sign_up'] as String)
          : null,
      closeSignUp: json['close_sign_up'] != null
          ? DateTime.parse(json['close_sign_up'] as String)
          : null,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'] as String)
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      meetingPlace: json['meeting_place'] as String?,
      photoAlbumLink: json['photo_album_link'] as String?,
      groupId: json['group_id'] as String?,
      targetPatrolsIds: (json['target_patrols'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastEditedBy: json['last_edited_by'] as String?,
      isDraft: json['is_draft'] as bool? ?? false,
    );
  }

  EventModel copyWith({
    String? eventId,
    String? title,
    String? instructions,
    DateTime? openSignUp,
    DateTime? closeSignUp,
    DateTime? startDate,
    DateTime? endDate,
    String? meetingPlace,
    String? photoAlbumLink,
    String? groupId,
    List<String>? targetPatrolsIds,
    String? lastEditedBy,
    bool? isDraft,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      openSignUp: openSignUp ?? this.openSignUp,
      closeSignUp: closeSignUp ?? this.closeSignUp,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      meetingPlace: meetingPlace ?? this.meetingPlace,
      photoAlbumLink: photoAlbumLink ?? this.photoAlbumLink,
      groupId: groupId ?? this.groupId,
      targetPatrolsIds: targetPatrolsIds ?? this.targetPatrolsIds,
      lastEditedBy: lastEditedBy ?? this.lastEditedBy,
      isDraft: isDraft ?? this.isDraft,
    );
  }
}
