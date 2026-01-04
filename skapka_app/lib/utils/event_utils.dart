import 'package:skapka_app/models/event_model.dart';

class EventUtils {
  static bool isDraft(EventModel event) => event.isDraft;

  static bool isPast(EventModel event) {
    if (event.isDraft) return false;
    final now = DateTime.now();
    return event.endDate != null && event.endDate!.isBefore(now);
  }

  static bool isLive(EventModel event) {
    if (event.isDraft) return false;
    final now = DateTime.now();
    // Sign up is open if:
    // 1. opensignup is before now
    // 2. end date is after now

    return event.openSignUp!.isBefore(now) &&
        (event.endDate == null || event.endDate!.isAfter(now));
  }

  static bool isFuture(EventModel event) {
    if (event.isDraft) return false;
    return !isPast(event) && !isLive(event);
  }

  static EventTimeType getEventTimeType(EventModel event) {
    if (isDraft(event)) return EventTimeType.draft;
    if (isPast(event)) return EventTimeType.past;
    if (isLive(event)) return EventTimeType.live;
    return EventTimeType.future;
  }
}
