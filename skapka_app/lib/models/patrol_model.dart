import 'package:freezed_annotation/freezed_annotation.dart';

part 'patrol_model.freezed.dart';
part 'patrol_model.g.dart';

@freezed
abstract class PatrolModel with _$PatrolModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PatrolModel({
    required String patrolId,
    required String name,
    String? abbreviation,
    required String troopId,
    required String groupId,
    required int skautisId,
  }) = _PatrolModel;

  factory PatrolModel.fromJson(Map<String, dynamic> json) =>
      _$PatrolModelFromJson(json);
}
