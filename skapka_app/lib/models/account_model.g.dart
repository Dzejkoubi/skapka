// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      accountId: json['account_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      rights: (json['rights'] as num?)?.toInt() ?? 0,
      groupId: json['group_id'] as String,
      isApproved: json['is_approved'] as bool? ?? false,
      name: json['name'] as String,
      surname: json['surname'] as String,
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'created_at': instance.createdAt.toIso8601String(),
      'rights': instance.rights,
      'group_id': instance.groupId,
      'is_approved': instance.isApproved,
      'name': instance.name,
      'surname': instance.surname,
    };
