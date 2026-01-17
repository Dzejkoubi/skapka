// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leader_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaderModel {

 String get dependentId; String get patrolId; String get groupId;
/// Create a copy of LeaderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderModelCopyWith<LeaderModel> get copyWith => _$LeaderModelCopyWithImpl<LeaderModel>(this as LeaderModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderModel&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,dependentId,patrolId,groupId);

@override
String toString() {
  return 'LeaderModel(dependentId: $dependentId, patrolId: $patrolId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class $LeaderModelCopyWith<$Res>  {
  factory $LeaderModelCopyWith(LeaderModel value, $Res Function(LeaderModel) _then) = _$LeaderModelCopyWithImpl;
@useResult
$Res call({
 String dependentId, String patrolId, String groupId
});




}
/// @nodoc
class _$LeaderModelCopyWithImpl<$Res>
    implements $LeaderModelCopyWith<$Res> {
  _$LeaderModelCopyWithImpl(this._self, this._then);

  final LeaderModel _self;
  final $Res Function(LeaderModel) _then;

/// Create a copy of LeaderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dependentId = null,Object? patrolId = null,Object? groupId = null,}) {
  return _then(_self.copyWith(
dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,patrolId: null == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaderModel].
extension LeaderModelPatterns on LeaderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dependentId,  String patrolId,  String groupId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderModel() when $default != null:
return $default(_that.dependentId,_that.patrolId,_that.groupId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dependentId,  String patrolId,  String groupId)  $default,) {final _that = this;
switch (_that) {
case _LeaderModel():
return $default(_that.dependentId,_that.patrolId,_that.groupId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dependentId,  String patrolId,  String groupId)?  $default,) {final _that = this;
switch (_that) {
case _LeaderModel() when $default != null:
return $default(_that.dependentId,_that.patrolId,_that.groupId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LeaderModel implements LeaderModel {
  const _LeaderModel({required this.dependentId, required this.patrolId, required this.groupId});
  

@override final  String dependentId;
@override final  String patrolId;
@override final  String groupId;

/// Create a copy of LeaderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderModelCopyWith<_LeaderModel> get copyWith => __$LeaderModelCopyWithImpl<_LeaderModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderModel&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.groupId, groupId) || other.groupId == groupId));
}


@override
int get hashCode => Object.hash(runtimeType,dependentId,patrolId,groupId);

@override
String toString() {
  return 'LeaderModel(dependentId: $dependentId, patrolId: $patrolId, groupId: $groupId)';
}


}

/// @nodoc
abstract mixin class _$LeaderModelCopyWith<$Res> implements $LeaderModelCopyWith<$Res> {
  factory _$LeaderModelCopyWith(_LeaderModel value, $Res Function(_LeaderModel) _then) = __$LeaderModelCopyWithImpl;
@override @useResult
$Res call({
 String dependentId, String patrolId, String groupId
});




}
/// @nodoc
class __$LeaderModelCopyWithImpl<$Res>
    implements _$LeaderModelCopyWith<$Res> {
  __$LeaderModelCopyWithImpl(this._self, this._then);

  final _LeaderModel _self;
  final $Res Function(_LeaderModel) _then;

/// Create a copy of LeaderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dependentId = null,Object? patrolId = null,Object? groupId = null,}) {
  return _then(_LeaderModel(
dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,patrolId: null == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
