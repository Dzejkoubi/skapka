import 'package:flutter/material.dart';
import 'package:skapka_app/models/dependents/account_dependent_model.dart';
import 'package:skapka_app/models/event_participant_model.dart';

class DependentsProvider extends ChangeNotifier {
  final List<AccountDependentModel> _dependents = [];
  final Map<String, List<EventParticipantModel>> _participation = {};

  List<AccountDependentModel> get dependents => _dependents;
  Map<String, List<EventParticipantModel>> get participation => _participation;

  void setDependents(List<AccountDependentModel> dependents) {
    clear();
    _dependents.addAll(dependents);
    notifyListeners();
  }

  void setParticipation(
    String dependentId,
    List<EventParticipantModel> participation,
  ) {
    _participation[dependentId] = participation;
    notifyListeners();
  }

  List<EventParticipantModel> getParticipationForDependent(String dependentId) {
    return _participation[dependentId] ?? [];
  }

  void addDependent(AccountDependentModel dependent) {
    _dependents.add(dependent);
    notifyListeners();
  }

  void removeDependent(AccountDependentModel dependent) {
    _dependents.remove(dependent);
    _participation.remove(dependent.dependentId);
    notifyListeners();
  }

  void clear() {
    _dependents.clear();
    _participation.clear();
    notifyListeners();
  }
}
