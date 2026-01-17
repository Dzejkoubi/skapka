// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dependent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DependentModel {

 String get dependentId; bool get isLeader; String get name; String get surname; String? get nickname; DateTime? get born; SexEnum get sex; String? get parent1Email; String? get parent1Phone; String? get parent2Email; String? get parent2Phone; String? get contactEmail; String? get contactPhone; String? get troopId; String? get patrolId; bool get isArchived; String? get secretCode; DateTime get createdAt; String get groupId; int get skautisId;
/// Create a copy of DependentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DependentModelCopyWith<DependentModel> get copyWith => _$DependentModelCopyWithImpl<DependentModel>(this as DependentModel, _$identity);

  /// Serializes this DependentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DependentModel&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.born, born) || other.born == born)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.parent1Email, parent1Email) || other.parent1Email == parent1Email)&&(identical(other.parent1Phone, parent1Phone) || other.parent1Phone == parent1Phone)&&(identical(other.parent2Email, parent2Email) || other.parent2Email == parent2Email)&&(identical(other.parent2Phone, parent2Phone) || other.parent2Phone == parent2Phone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.secretCode, secretCode) || other.secretCode == secretCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,dependentId,isLeader,name,surname,nickname,born,sex,parent1Email,parent1Phone,parent2Email,parent2Phone,contactEmail,contactPhone,troopId,patrolId,isArchived,secretCode,createdAt,groupId,skautisId]);

@override
String toString() {
  return 'DependentModel(dependentId: $dependentId, isLeader: $isLeader, name: $name, surname: $surname, nickname: $nickname, born: $born, sex: $sex, parent1Email: $parent1Email, parent1Phone: $parent1Phone, parent2Email: $parent2Email, parent2Phone: $parent2Phone, contactEmail: $contactEmail, contactPhone: $contactPhone, troopId: $troopId, patrolId: $patrolId, isArchived: $isArchived, secretCode: $secretCode, createdAt: $createdAt, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class $DependentModelCopyWith<$Res>  {
  factory $DependentModelCopyWith(DependentModel value, $Res Function(DependentModel) _then) = _$DependentModelCopyWithImpl;
@useResult
$Res call({
 String dependentId, bool isLeader, String name, String surname, String? nickname, DateTime? born, SexEnum sex, String? parent1Email, String? parent1Phone, String? parent2Email, String? parent2Phone, String? contactEmail, String? contactPhone, String? troopId, String? patrolId, bool isArchived, String? secretCode, DateTime createdAt, String groupId, int skautisId
});




}
/// @nodoc
class _$DependentModelCopyWithImpl<$Res>
    implements $DependentModelCopyWith<$Res> {
  _$DependentModelCopyWithImpl(this._self, this._then);

  final DependentModel _self;
  final $Res Function(DependentModel) _then;

/// Create a copy of DependentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dependentId = null,Object? isLeader = null,Object? name = null,Object? surname = null,Object? nickname = freezed,Object? born = freezed,Object? sex = null,Object? parent1Email = freezed,Object? parent1Phone = freezed,Object? parent2Email = freezed,Object? parent2Phone = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? troopId = freezed,Object? patrolId = freezed,Object? isArchived = null,Object? secretCode = freezed,Object? createdAt = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_self.copyWith(
dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,born: freezed == born ? _self.born : born // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as SexEnum,parent1Email: freezed == parent1Email ? _self.parent1Email : parent1Email // ignore: cast_nullable_to_non_nullable
as String?,parent1Phone: freezed == parent1Phone ? _self.parent1Phone : parent1Phone // ignore: cast_nullable_to_non_nullable
as String?,parent2Email: freezed == parent2Email ? _self.parent2Email : parent2Email // ignore: cast_nullable_to_non_nullable
as String?,parent2Phone: freezed == parent2Phone ? _self.parent2Phone : parent2Phone // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,troopId: freezed == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String?,patrolId: freezed == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,secretCode: freezed == secretCode ? _self.secretCode : secretCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DependentModel].
extension DependentModelPatterns on DependentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DependentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DependentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DependentModel value)  $default,){
final _that = this;
switch (_that) {
case _DependentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DependentModel value)?  $default,){
final _that = this;
switch (_that) {
case _DependentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dependentId,  bool isLeader,  String name,  String surname,  String? nickname,  DateTime? born,  SexEnum sex,  String? parent1Email,  String? parent1Phone,  String? parent2Email,  String? parent2Phone,  String? contactEmail,  String? contactPhone,  String? troopId,  String? patrolId,  bool isArchived,  String? secretCode,  DateTime createdAt,  String groupId,  int skautisId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DependentModel() when $default != null:
return $default(_that.dependentId,_that.isLeader,_that.name,_that.surname,_that.nickname,_that.born,_that.sex,_that.parent1Email,_that.parent1Phone,_that.parent2Email,_that.parent2Phone,_that.contactEmail,_that.contactPhone,_that.troopId,_that.patrolId,_that.isArchived,_that.secretCode,_that.createdAt,_that.groupId,_that.skautisId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dependentId,  bool isLeader,  String name,  String surname,  String? nickname,  DateTime? born,  SexEnum sex,  String? parent1Email,  String? parent1Phone,  String? parent2Email,  String? parent2Phone,  String? contactEmail,  String? contactPhone,  String? troopId,  String? patrolId,  bool isArchived,  String? secretCode,  DateTime createdAt,  String groupId,  int skautisId)  $default,) {final _that = this;
switch (_that) {
case _DependentModel():
return $default(_that.dependentId,_that.isLeader,_that.name,_that.surname,_that.nickname,_that.born,_that.sex,_that.parent1Email,_that.parent1Phone,_that.parent2Email,_that.parent2Phone,_that.contactEmail,_that.contactPhone,_that.troopId,_that.patrolId,_that.isArchived,_that.secretCode,_that.createdAt,_that.groupId,_that.skautisId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dependentId,  bool isLeader,  String name,  String surname,  String? nickname,  DateTime? born,  SexEnum sex,  String? parent1Email,  String? parent1Phone,  String? parent2Email,  String? parent2Phone,  String? contactEmail,  String? contactPhone,  String? troopId,  String? patrolId,  bool isArchived,  String? secretCode,  DateTime createdAt,  String groupId,  int skautisId)?  $default,) {final _that = this;
switch (_that) {
case _DependentModel() when $default != null:
return $default(_that.dependentId,_that.isLeader,_that.name,_that.surname,_that.nickname,_that.born,_that.sex,_that.parent1Email,_that.parent1Phone,_that.parent2Email,_that.parent2Phone,_that.contactEmail,_that.contactPhone,_that.troopId,_that.patrolId,_that.isArchived,_that.secretCode,_that.createdAt,_that.groupId,_that.skautisId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DependentModel extends DependentModel {
   _DependentModel({required this.dependentId, required this.isLeader, required this.name, required this.surname, this.nickname, this.born, required this.sex, this.parent1Email, this.parent1Phone, this.parent2Email, this.parent2Phone, this.contactEmail, this.contactPhone, this.troopId, this.patrolId, required this.isArchived, this.secretCode, required this.createdAt, required this.groupId, required this.skautisId}): super._();
  factory _DependentModel.fromJson(Map<String, dynamic> json) => _$DependentModelFromJson(json);

@override final  String dependentId;
@override final  bool isLeader;
@override final  String name;
@override final  String surname;
@override final  String? nickname;
@override final  DateTime? born;
@override final  SexEnum sex;
@override final  String? parent1Email;
@override final  String? parent1Phone;
@override final  String? parent2Email;
@override final  String? parent2Phone;
@override final  String? contactEmail;
@override final  String? contactPhone;
@override final  String? troopId;
@override final  String? patrolId;
@override final  bool isArchived;
@override final  String? secretCode;
@override final  DateTime createdAt;
@override final  String groupId;
@override final  int skautisId;

/// Create a copy of DependentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DependentModelCopyWith<_DependentModel> get copyWith => __$DependentModelCopyWithImpl<_DependentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DependentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DependentModel&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.isLeader, isLeader) || other.isLeader == isLeader)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.born, born) || other.born == born)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.parent1Email, parent1Email) || other.parent1Email == parent1Email)&&(identical(other.parent1Phone, parent1Phone) || other.parent1Phone == parent1Phone)&&(identical(other.parent2Email, parent2Email) || other.parent2Email == parent2Email)&&(identical(other.parent2Phone, parent2Phone) || other.parent2Phone == parent2Phone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.secretCode, secretCode) || other.secretCode == secretCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,dependentId,isLeader,name,surname,nickname,born,sex,parent1Email,parent1Phone,parent2Email,parent2Phone,contactEmail,contactPhone,troopId,patrolId,isArchived,secretCode,createdAt,groupId,skautisId]);

@override
String toString() {
  return 'DependentModel(dependentId: $dependentId, isLeader: $isLeader, name: $name, surname: $surname, nickname: $nickname, born: $born, sex: $sex, parent1Email: $parent1Email, parent1Phone: $parent1Phone, parent2Email: $parent2Email, parent2Phone: $parent2Phone, contactEmail: $contactEmail, contactPhone: $contactPhone, troopId: $troopId, patrolId: $patrolId, isArchived: $isArchived, secretCode: $secretCode, createdAt: $createdAt, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class _$DependentModelCopyWith<$Res> implements $DependentModelCopyWith<$Res> {
  factory _$DependentModelCopyWith(_DependentModel value, $Res Function(_DependentModel) _then) = __$DependentModelCopyWithImpl;
@override @useResult
$Res call({
 String dependentId, bool isLeader, String name, String surname, String? nickname, DateTime? born, SexEnum sex, String? parent1Email, String? parent1Phone, String? parent2Email, String? parent2Phone, String? contactEmail, String? contactPhone, String? troopId, String? patrolId, bool isArchived, String? secretCode, DateTime createdAt, String groupId, int skautisId
});




}
/// @nodoc
class __$DependentModelCopyWithImpl<$Res>
    implements _$DependentModelCopyWith<$Res> {
  __$DependentModelCopyWithImpl(this._self, this._then);

  final _DependentModel _self;
  final $Res Function(_DependentModel) _then;

/// Create a copy of DependentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dependentId = null,Object? isLeader = null,Object? name = null,Object? surname = null,Object? nickname = freezed,Object? born = freezed,Object? sex = null,Object? parent1Email = freezed,Object? parent1Phone = freezed,Object? parent2Email = freezed,Object? parent2Phone = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? troopId = freezed,Object? patrolId = freezed,Object? isArchived = null,Object? secretCode = freezed,Object? createdAt = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_DependentModel(
dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,isLeader: null == isLeader ? _self.isLeader : isLeader // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,born: freezed == born ? _self.born : born // ignore: cast_nullable_to_non_nullable
as DateTime?,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as SexEnum,parent1Email: freezed == parent1Email ? _self.parent1Email : parent1Email // ignore: cast_nullable_to_non_nullable
as String?,parent1Phone: freezed == parent1Phone ? _self.parent1Phone : parent1Phone // ignore: cast_nullable_to_non_nullable
as String?,parent2Email: freezed == parent2Email ? _self.parent2Email : parent2Email // ignore: cast_nullable_to_non_nullable
as String?,parent2Phone: freezed == parent2Phone ? _self.parent2Phone : parent2Phone // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,troopId: freezed == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String?,patrolId: freezed == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,secretCode: freezed == secretCode ? _self.secretCode : secretCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
