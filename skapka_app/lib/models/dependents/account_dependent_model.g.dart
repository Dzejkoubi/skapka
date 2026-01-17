// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dependent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountDependentModel _$AccountDependentModelFromJson(
  Map<String, dynamic> json,
) => _AccountDependentModel(
  dependentId: json['dependent_id'] as String,
  isLeader: json['is_leader'] as bool,
  name: json['name'] as String,
  surname: json['surname'] as String,
  nickname: json['nickname'] as String?,
  born: json['born'] == null ? null : DateTime.parse(json['born'] as String),
  sex: $enumDecode(_$SexEnumEnumMap, json['sex']),
  parent1Email: json['parent1_email'] as String?,
  parent1Phone: json['parent1_phone'] as String?,
  parent2Email: json['parent2_email'] as String?,
  parent2Phone: json['parent2_phone'] as String?,
  contactEmail: json['contact_email'] as String?,
  contactPhone: json['contact_phone'] as String?,
  troopId: json['troop_id'] as String?,
  patrolId: json['patrol_id'] as String?,
  isArchived: json['is_archived'] as bool,
  secretCode: json['secret_code'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  groupId: json['group_id'] as String,
  skautisId: (json['skautis_id'] as num).toInt(),
  notes: DependentNotesModel.fromJson(json['notes'] as Map<String, dynamic>),
  isMainDependent: json['is_main_dependent'] as bool,
);

Map<String, dynamic> _$AccountDependentModelToJson(
  _AccountDependentModel instance,
) => <String, dynamic>{
  'dependent_id': instance.dependentId,
  'is_leader': instance.isLeader,
  'name': instance.name,
  'surname': instance.surname,
  'nickname': instance.nickname,
  'born': instance.born?.toIso8601String(),
  'sex': _$SexEnumEnumMap[instance.sex]!,
  'parent1_email': instance.parent1Email,
  'parent1_phone': instance.parent1Phone,
  'parent2_email': instance.parent2Email,
  'parent2_phone': instance.parent2Phone,
  'contact_email': instance.contactEmail,
  'contact_phone': instance.contactPhone,
  'troop_id': instance.troopId,
  'patrol_id': instance.patrolId,
  'is_archived': instance.isArchived,
  'secret_code': instance.secretCode,
  'created_at': instance.createdAt.toIso8601String(),
  'group_id': instance.groupId,
  'skautis_id': instance.skautisId,
  'notes': instance.notes,
  'is_main_dependent': instance.isMainDependent,
};

const _$SexEnumEnumMap = {
  SexEnum.male: 'male',
  SexEnum.female: 'female',
  SexEnum.other: 'other',
};
