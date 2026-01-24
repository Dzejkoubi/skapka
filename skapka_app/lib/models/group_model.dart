import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
abstract class GroupModel with _$GroupModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GroupModel({
    required groupId,
    required skautisId,
    required String name,
    required String number,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return _$GroupModelFromJson(json);
  }
}
