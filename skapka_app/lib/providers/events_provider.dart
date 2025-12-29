import 'package:flutter/material.dart';
import 'package:skapka_app/models/event_model.dart';

class EventsProvider extends ChangeNotifier {
  final List<EventModel> _events = [];

  List<EventModel> get events => _events;

  void addEvent(EventModel event) {
    _events.add(event);
    print('Event added: ${event.title}');
    notifyListeners();
  }

  void removeEvent(EventModel event) {
    _events.remove(event);
    notifyListeners();
  }
}
