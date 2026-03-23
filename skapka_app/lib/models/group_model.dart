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
  }) = _GroupModel;

  static const defaultGroupId = '809f0ed3-e1de-4bde-bc99-ad90a164e16e';

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return _$GroupModelFromJson(json);
  }
}
