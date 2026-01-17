import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountModel({
    required String accountId,
    required DateTime createdAt,
    @Default(0) int rights,
    required String groupId,
    @Default(false) bool isApproved,
    String? name,
    String? surname,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
