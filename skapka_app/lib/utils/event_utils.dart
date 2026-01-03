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
    // 1. openSignUp is set and in the past
    // 2. closeSignUp is not set OR in the future
    // AND the event hasn't ended yet
    bool isSignUpOpen =
        event.openSignUp != null &&
        event.openSignUp!.isBefore(now) &&
        (event.closeSignUp == null || event.closeSignUp!.isAfter(now));

    return isSignUpOpen && !isPast(event);
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
