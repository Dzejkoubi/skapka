// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patrol_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatrolModel {

 String get patrolId; String get name; String? get abbreviation; String get troopId; String get groupId; int get skautisId;
/// Create a copy of PatrolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatrolModelCopyWith<PatrolModel> get copyWith => _$PatrolModelCopyWithImpl<PatrolModel>(this as PatrolModel, _$identity);

  /// Serializes this PatrolModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatrolModel&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patrolId,name,abbreviation,troopId,groupId,skautisId);

@override
String toString() {
  return 'PatrolModel(patrolId: $patrolId, name: $name, abbreviation: $abbreviation, troopId: $troopId, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class $PatrolModelCopyWith<$Res>  {
  factory $PatrolModelCopyWith(PatrolModel value, $Res Function(PatrolModel) _then) = _$PatrolModelCopyWithImpl;
@useResult
$Res call({
 String patrolId, String name, String? abbreviation, String troopId, String groupId, int skautisId
});




}
/// @nodoc
class _$PatrolModelCopyWithImpl<$Res>
    implements $PatrolModelCopyWith<$Res> {
  _$PatrolModelCopyWithImpl(this._self, this._then);

  final PatrolModel _self;
  final $Res Function(PatrolModel) _then;

/// Create a copy of PatrolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? patrolId = null,Object? name = null,Object? abbreviation = freezed,Object? troopId = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_self.copyWith(
patrolId: null == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: freezed == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String?,troopId: null == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PatrolModel].
extension PatrolModelPatterns on PatrolModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatrolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatrolModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatrolModel value)  $default,){
final _that = this;
switch (_that) {
case _PatrolModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatrolModel value)?  $default,){
final _that = this;
switch (_that) {
case _PatrolModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String patrolId,  String name,  String? abbreviation,  String troopId,  String groupId,  int skautisId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatrolModel() when $default != null:
return $default(_that.patrolId,_that.name,_that.abbreviation,_that.troopId,_that.groupId,_that.skautisId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String patrolId,  String name,  String? abbreviation,  String troopId,  String groupId,  int skautisId)  $default,) {final _that = this;
switch (_that) {
case _PatrolModel():
return $default(_that.patrolId,_that.name,_that.abbreviation,_that.troopId,_that.groupId,_that.skautisId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String patrolId,  String name,  String? abbreviation,  String troopId,  String groupId,  int skautisId)?  $default,) {final _that = this;
switch (_that) {
case _PatrolModel() when $default != null:
return $default(_that.patrolId,_that.name,_that.abbreviation,_that.troopId,_that.groupId,_that.skautisId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PatrolModel implements PatrolModel {
  const _PatrolModel({required this.patrolId, required this.name, this.abbreviation, required this.troopId, required this.groupId, required this.skautisId});
  factory _PatrolModel.fromJson(Map<String, dynamic> json) => _$PatrolModelFromJson(json);

@override final  String patrolId;
@override final  String name;
@override final  String? abbreviation;
@override final  String troopId;
@override final  String groupId;
@override final  int skautisId;

/// Create a copy of PatrolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatrolModelCopyWith<_PatrolModel> get copyWith => __$PatrolModelCopyWithImpl<_PatrolModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatrolModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatrolModel&&(identical(other.patrolId, patrolId) || other.patrolId == patrolId)&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,patrolId,name,abbreviation,troopId,groupId,skautisId);

@override
String toString() {
  return 'PatrolModel(patrolId: $patrolId, name: $name, abbreviation: $abbreviation, troopId: $troopId, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class _$PatrolModelCopyWith<$Res> implements $PatrolModelCopyWith<$Res> {
  factory _$PatrolModelCopyWith(_PatrolModel value, $Res Function(_PatrolModel) _then) = __$PatrolModelCopyWithImpl;
@override @useResult
$Res call({
 String patrolId, String name, String? abbreviation, String troopId, String groupId, int skautisId
});




}
/// @nodoc
class __$PatrolModelCopyWithImpl<$Res>
    implements _$PatrolModelCopyWith<$Res> {
  __$PatrolModelCopyWithImpl(this._self, this._then);

  final _PatrolModel _self;
  final $Res Function(_PatrolModel) _then;

/// Create a copy of PatrolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? patrolId = null,Object? name = null,Object? abbreviation = freezed,Object? troopId = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_PatrolModel(
patrolId: null == patrolId ? _self.patrolId : patrolId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: freezed == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String?,troopId: null == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
