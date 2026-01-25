import 'package:freezed_annotation/freezed_annotation.dart';
part 'account_dependent_relation_model.freezed.dart';
part 'account_dependent_relation_model.g.dart';

@freezed
abstract class AccountDependentRelationModel
    with _$AccountDependentRelationModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AccountDependentRelationModel({
    required String accountId,
    required String dependentId,
    required bool isMainDependent,
  }) = _AccountDependentRelationModel;

  factory AccountDependentRelationModel.fromJson(Map<String, dynamic> json) =>
      _$AccountDependentRelationModelFromJson(json);
}
