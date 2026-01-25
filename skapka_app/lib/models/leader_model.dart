import 'package:freezed_annotation/freezed_annotation.dart';

part 'leader_model.freezed.dart';
part 'leader_model.g.dart';

@freezed
abstract class LeaderModel with _$LeaderModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LeaderModel({
    required String dependentId,
    required String patrolId,
    required String groupId,
  }) = _LeaderModel;

  factory LeaderModel.fromJson(Map<String, dynamic> json) {
    return _$LeaderModelFromJson(json);
  }
}
