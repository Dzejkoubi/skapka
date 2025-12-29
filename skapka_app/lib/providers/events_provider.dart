import 'package:flutter/material.dart';
import 'package:skapka_app/models/event_model.dart';

class EventsProvider extends ChangeNotifier {
  final List<EventModel> _events = [];

  List<EventModel> get events => _events;
  List<EventModel> get futureEvents => _events.where((event) {
    if (event.isDraft) return false;
    final now = DateTime.now();
    return event.openSignUp != null &&
        event.openSignUp!.isBefore(now) &&
        (event.closeSignUp == null || event.closeSignUp!.isAfter(now));
  }).toList();

  List<EventModel> get liveEvents => _events.where((event) {
    if (event.isDraft) return false;
    final now = DateTime.now();
    return event.closeSignUp != null &&
        event.closeSignUp!.isBefore(now) &&
        event.endDate != null &&
        event.endDate!.isAfter(now);
  }).toList();

  List<EventModel> get pastEvents => _events.where((event) {
    if (event.isDraft) return false;
    final now = DateTime.now();
    return event.endDate != null && event.endDate!.isBefore(now);
  }).toList();

  List<EventModel> get draftEvents =>
      _events.where((event) => event.isDraft).toList();

  void setEvents(List<EventModel> events) {
    clear();
    _events.addAll(events);
    notifyListeners();
  }

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(EventModel event) {
    _events.remove(event);
    notifyListeners();
  }

  void clear() {
    _events.clear();
    notifyListeners();
  }
}
