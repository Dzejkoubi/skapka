// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_dependent_relation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountDependentRelationModel {

 String get accountId; String get dependentId; bool get isMainDependent;
/// Create a copy of AccountDependentRelationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDependentRelationModelCopyWith<AccountDependentRelationModel> get copyWith => _$AccountDependentRelationModelCopyWithImpl<AccountDependentRelationModel>(this as AccountDependentRelationModel, _$identity);

  /// Serializes this AccountDependentRelationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDependentRelationModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.isMainDependent, isMainDependent) || other.isMainDependent == isMainDependent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,dependentId,isMainDependent);

@override
String toString() {
  return 'AccountDependentRelationModel(accountId: $accountId, dependentId: $dependentId, isMainDependent: $isMainDependent)';
}


}

/// @nodoc
abstract mixin class $AccountDependentRelationModelCopyWith<$Res>  {
  factory $AccountDependentRelationModelCopyWith(AccountDependentRelationModel value, $Res Function(AccountDependentRelationModel) _then) = _$AccountDependentRelationModelCopyWithImpl;
@useResult
$Res call({
 String accountId, String dependentId, bool isMainDependent
});




}
/// @nodoc
class _$AccountDependentRelationModelCopyWithImpl<$Res>
    implements $AccountDependentRelationModelCopyWith<$Res> {
  _$AccountDependentRelationModelCopyWithImpl(this._self, this._then);

  final AccountDependentRelationModel _self;
  final $Res Function(AccountDependentRelationModel) _then;

/// Create a copy of AccountDependentRelationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? dependentId = null,Object? isMainDependent = null,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,isMainDependent: null == isMainDependent ? _self.isMainDependent : isMainDependent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountDependentRelationModel].
extension AccountDependentRelationModelPatterns on AccountDependentRelationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDependentRelationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDependentRelationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDependentRelationModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountDependentRelationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDependentRelationModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDependentRelationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String dependentId,  bool isMainDependent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDependentRelationModel() when $default != null:
return $default(_that.accountId,_that.dependentId,_that.isMainDependent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String dependentId,  bool isMainDependent)  $default,) {final _that = this;
switch (_that) {
case _AccountDependentRelationModel():
return $default(_that.accountId,_that.dependentId,_that.isMainDependent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String dependentId,  bool isMainDependent)?  $default,) {final _that = this;
switch (_that) {
case _AccountDependentRelationModel() when $default != null:
return $default(_that.accountId,_that.dependentId,_that.isMainDependent);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AccountDependentRelationModel implements AccountDependentRelationModel {
   _AccountDependentRelationModel({required this.accountId, required this.dependentId, this.isMainDependent = false});
  factory _AccountDependentRelationModel.fromJson(Map<String, dynamic> json) => _$AccountDependentRelationModelFromJson(json);

@override final  String accountId;
@override final  String dependentId;
@override@JsonKey() final  bool isMainDependent;

/// Create a copy of AccountDependentRelationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDependentRelationModelCopyWith<_AccountDependentRelationModel> get copyWith => __$AccountDependentRelationModelCopyWithImpl<_AccountDependentRelationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountDependentRelationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDependentRelationModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.isMainDependent, isMainDependent) || other.isMainDependent == isMainDependent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,dependentId,isMainDependent);

@override
String toString() {
  return 'AccountDependentRelationModel(accountId: $accountId, dependentId: $dependentId, isMainDependent: $isMainDependent)';
}


}

/// @nodoc
abstract mixin class _$AccountDependentRelationModelCopyWith<$Res> implements $AccountDependentRelationModelCopyWith<$Res> {
  factory _$AccountDependentRelationModelCopyWith(_AccountDependentRelationModel value, $Res Function(_AccountDependentRelationModel) _then) = __$AccountDependentRelationModelCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String dependentId, bool isMainDependent
});




}
/// @nodoc
class __$AccountDependentRelationModelCopyWithImpl<$Res>
    implements _$AccountDependentRelationModelCopyWith<$Res> {
  __$AccountDependentRelationModelCopyWithImpl(this._self, this._then);

  final _AccountDependentRelationModel _self;
  final $Res Function(_AccountDependentRelationModel) _then;

/// Create a copy of AccountDependentRelationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? dependentId = null,Object? isMainDependent = null,}) {
  return _then(_AccountDependentRelationModel(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,isMainDependent: null == isMainDependent ? _self.isMainDependent : isMainDependent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
