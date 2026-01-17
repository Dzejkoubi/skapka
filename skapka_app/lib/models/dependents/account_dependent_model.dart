import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skapka_app/models/dependents/dependent_notes_model.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';

part 'account_dependent_model.freezed.dart';
part 'account_dependent_model.g.dart';

// Dependent model that has isMainDependent field to indicate if it's the main dependent for the account
@freezed
abstract class AccountDependentModel with _$AccountDependentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AccountDependentModel({
    required String dependentId,
    required bool isLeader,
    required String name,
    required String surname,
    String? nickname,
    DateTime? born,
    required SexEnum sex,
    String? parent1Email,
    String? parent1Phone,
    String? parent2Email,
    String? parent2Phone,
    String? contactEmail,
    String? contactPhone,
    String? troopId,
    String? patrolId,
    required bool isArchived,
    String? secretCode,
    required DateTime createdAt,
    required String groupId,
    required int skautisId,
    required DependentNotesModel notes,
    required bool isMainDependent,
  }) = _AccountDependentModel;

  factory AccountDependentModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDependentModelFromJson(json);
}
