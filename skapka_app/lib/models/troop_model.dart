import 'package:freezed_annotation/freezed_annotation.dart';

part 'troop_model.freezed.dart';
part 'troop_model.g.dart';

@freezed
abstract class TroopModel with _$TroopModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TroopModel({
    required String troopId,
    required String name,
    required int number,
    required String groupId,
    required int skautisId,
  }) = _TroopModel;

  factory TroopModel.fromJson(Map<String, dynamic> json) =>
      _$TroopModelFromJson(json);
}
