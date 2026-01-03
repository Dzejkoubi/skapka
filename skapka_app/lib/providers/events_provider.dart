import 'package:flutter/foundation.dart';
import 'package:skapka_app/models/event_model.dart';
import 'package:skapka_app/utils/event_utils.dart';

class EventsProvider extends ChangeNotifier {
  final List<EventModel> _events = [];
  bool _hasMorePastEvents = true;

  bool get hasMorePastEvents => _hasMorePastEvents;

  void setHasMorePastEvents(bool value) {
    _hasMorePastEvents = value;
    notifyListeners();
  }

  List<EventModel> get events => _events;
  List<EventModel> get futureEvents =>
      _events.where((event) => EventUtils.isFuture(event)).toList();

  List<EventModel> get liveEvents =>
      _events.where((event) => EventUtils.isLive(event)).toList();

  List<EventModel> get pastEvents =>
      _events.where((event) => EventUtils.isPast(event)).toList();

  List<EventModel> get draftEvents =>
      _events.where((event) => EventUtils.isDraft(event)).toList();

  void setEvents(List<EventModel> events) {
    clear();
    _events.addAll(events);
    if (kDebugMode) {
      print('Events set: ${_events.length} events loaded.');
    }
    notifyListeners();
  }

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void addEvents(List<EventModel> events) {
    _events.addAll(events);
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
