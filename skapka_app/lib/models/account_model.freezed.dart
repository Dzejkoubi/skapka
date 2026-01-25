// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get accountId; DateTime get createdAt; int get rights; String get groupId; bool get isApproved; String get name; String get surname;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rights, rights) || other.rights == rights)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,createdAt,rights,groupId,isApproved,name,surname);

@override
String toString() {
  return 'AccountModel(accountId: $accountId, createdAt: $createdAt, rights: $rights, groupId: $groupId, isApproved: $isApproved, name: $name, surname: $surname)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String accountId, DateTime createdAt, int rights, String groupId, bool isApproved, String name, String surname
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? createdAt = null,Object? rights = null,Object? groupId = null,Object? isApproved = null,Object? name = null,Object? surname = null,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,rights: null == rights ? _self.rights : rights // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  DateTime createdAt,  int rights,  String groupId,  bool isApproved,  String name,  String surname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.accountId,_that.createdAt,_that.rights,_that.groupId,_that.isApproved,_that.name,_that.surname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  DateTime createdAt,  int rights,  String groupId,  bool isApproved,  String name,  String surname)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.accountId,_that.createdAt,_that.rights,_that.groupId,_that.isApproved,_that.name,_that.surname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  DateTime createdAt,  int rights,  String groupId,  bool isApproved,  String name,  String surname)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.accountId,_that.createdAt,_that.rights,_that.groupId,_that.isApproved,_that.name,_that.surname);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AccountModel implements AccountModel {
  const _AccountModel({required this.accountId, required this.createdAt, this.rights = 0, required this.groupId, this.isApproved = false, required this.name, required this.surname});
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String accountId;
@override final  DateTime createdAt;
@override@JsonKey() final  int rights;
@override final  String groupId;
@override@JsonKey() final  bool isApproved;
@override final  String name;
@override final  String surname;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rights, rights) || other.rights == rights)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,createdAt,rights,groupId,isApproved,name,surname);

@override
String toString() {
  return 'AccountModel(accountId: $accountId, createdAt: $createdAt, rights: $rights, groupId: $groupId, isApproved: $isApproved, name: $name, surname: $surname)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String accountId, DateTime createdAt, int rights, String groupId, bool isApproved, String name, String surname
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? createdAt = null,Object? rights = null,Object? groupId = null,Object? isApproved = null,Object? name = null,Object? surname = null,}) {
  return _then(_AccountModel(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,rights: null == rights ? _self.rights : rights // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
