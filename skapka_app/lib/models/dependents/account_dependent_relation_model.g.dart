// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dependent_relation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountDependentRelationModel _$AccountDependentRelationModelFromJson(
  Map<String, dynamic> json,
) => _AccountDependentRelationModel(
  accountId: json['account_id'] as String,
  dependentId: json['dependent_id'] as String,
  isMainDependent: json['is_main_dependent'] as bool? ?? false,
);

Map<String, dynamic> _$AccountDependentRelationModelToJson(
  _AccountDependentRelationModel instance,
) => <String, dynamic>{
  'account_id': instance.accountId,
  'dependent_id': instance.dependentId,
  'is_main_dependent': instance.isMainDependent,
};
