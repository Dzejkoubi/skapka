import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skapka_app/models/dependents/dependent_model.dart';

part 'leader_dependent_model.freezed.dart';
part 'leader_dependent_model.g.dart';

@freezed
abstract class LeaderDependentModel with _$LeaderDependentModel {
  const LeaderDependentModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory LeaderDependentModel({
    required DependentModel dependent,
    required List<String> leaderOfPatrolId,
  }) = _LeaderDependentModel;

  factory LeaderDependentModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderDependentModelFromJson(json);

  bool get is18plus => dependent.is18plus;
}
