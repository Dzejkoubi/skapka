class EventModel {
  final String eventId;
  final String? title;
  final String? details;
  final DateTime? openSignUp;
  final DateTime? closeSignUp;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? photoAlbumLink;
  final String? groupId;
  final bool isDraft;
  EventModel({
    required this.eventId,
    required this.title,
    required this.details,
    required this.openSignUp,
    required this.closeSignUp,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.photoAlbumLink,
    required this.groupId,
    required this.isDraft,
  });
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'] as String,
      title: json['title'] as String?,
      details: json['details'] as String?,
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
      location: json['location'] as String?,
      photoAlbumLink: json['photo_album_link'] as String?,
      groupId: json['group_id'] as String,
      isDraft: json['is_draft'] as bool? ?? false,
    );
  }
}
