// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leader_dependent_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaderDependentModel {

 DependentModel get dependent; List<String> get leaderOfPatrolId;
/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderDependentModelCopyWith<LeaderDependentModel> get copyWith => _$LeaderDependentModelCopyWithImpl<LeaderDependentModel>(this as LeaderDependentModel, _$identity);

  /// Serializes this LeaderDependentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderDependentModel&&(identical(other.dependent, dependent) || other.dependent == dependent)&&const DeepCollectionEquality().equals(other.leaderOfPatrolId, leaderOfPatrolId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dependent,const DeepCollectionEquality().hash(leaderOfPatrolId));

@override
String toString() {
  return 'LeaderDependentModel(dependent: $dependent, leaderOfPatrolId: $leaderOfPatrolId)';
}


}

/// @nodoc
abstract mixin class $LeaderDependentModelCopyWith<$Res>  {
  factory $LeaderDependentModelCopyWith(LeaderDependentModel value, $Res Function(LeaderDependentModel) _then) = _$LeaderDependentModelCopyWithImpl;
@useResult
$Res call({
 DependentModel dependent, List<String> leaderOfPatrolId
});


$DependentModelCopyWith<$Res> get dependent;

}
/// @nodoc
class _$LeaderDependentModelCopyWithImpl<$Res>
    implements $LeaderDependentModelCopyWith<$Res> {
  _$LeaderDependentModelCopyWithImpl(this._self, this._then);

  final LeaderDependentModel _self;
  final $Res Function(LeaderDependentModel) _then;

/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dependent = null,Object? leaderOfPatrolId = null,}) {
  return _then(_self.copyWith(
dependent: null == dependent ? _self.dependent : dependent // ignore: cast_nullable_to_non_nullable
as DependentModel,leaderOfPatrolId: null == leaderOfPatrolId ? _self.leaderOfPatrolId : leaderOfPatrolId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DependentModelCopyWith<$Res> get dependent {
  
  return $DependentModelCopyWith<$Res>(_self.dependent, (value) {
    return _then(_self.copyWith(dependent: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaderDependentModel].
extension LeaderDependentModelPatterns on LeaderDependentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderDependentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderDependentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderDependentModel value)  $default,){
final _that = this;
switch (_that) {
case _LeaderDependentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderDependentModel value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderDependentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DependentModel dependent,  List<String> leaderOfPatrolId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderDependentModel() when $default != null:
return $default(_that.dependent,_that.leaderOfPatrolId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DependentModel dependent,  List<String> leaderOfPatrolId)  $default,) {final _that = this;
switch (_that) {
case _LeaderDependentModel():
return $default(_that.dependent,_that.leaderOfPatrolId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DependentModel dependent,  List<String> leaderOfPatrolId)?  $default,) {final _that = this;
switch (_that) {
case _LeaderDependentModel() when $default != null:
return $default(_that.dependent,_that.leaderOfPatrolId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _LeaderDependentModel extends LeaderDependentModel {
   _LeaderDependentModel({required this.dependent, required final  List<String> leaderOfPatrolId}): _leaderOfPatrolId = leaderOfPatrolId,super._();
  factory _LeaderDependentModel.fromJson(Map<String, dynamic> json) => _$LeaderDependentModelFromJson(json);

@override final  DependentModel dependent;
 final  List<String> _leaderOfPatrolId;
@override List<String> get leaderOfPatrolId {
  if (_leaderOfPatrolId is EqualUnmodifiableListView) return _leaderOfPatrolId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leaderOfPatrolId);
}


/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderDependentModelCopyWith<_LeaderDependentModel> get copyWith => __$LeaderDependentModelCopyWithImpl<_LeaderDependentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaderDependentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderDependentModel&&(identical(other.dependent, dependent) || other.dependent == dependent)&&const DeepCollectionEquality().equals(other._leaderOfPatrolId, _leaderOfPatrolId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dependent,const DeepCollectionEquality().hash(_leaderOfPatrolId));

@override
String toString() {
  return 'LeaderDependentModel(dependent: $dependent, leaderOfPatrolId: $leaderOfPatrolId)';
}


}

/// @nodoc
abstract mixin class _$LeaderDependentModelCopyWith<$Res> implements $LeaderDependentModelCopyWith<$Res> {
  factory _$LeaderDependentModelCopyWith(_LeaderDependentModel value, $Res Function(_LeaderDependentModel) _then) = __$LeaderDependentModelCopyWithImpl;
@override @useResult
$Res call({
 DependentModel dependent, List<String> leaderOfPatrolId
});


@override $DependentModelCopyWith<$Res> get dependent;

}
/// @nodoc
class __$LeaderDependentModelCopyWithImpl<$Res>
    implements _$LeaderDependentModelCopyWith<$Res> {
  __$LeaderDependentModelCopyWithImpl(this._self, this._then);

  final _LeaderDependentModel _self;
  final $Res Function(_LeaderDependentModel) _then;

/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dependent = null,Object? leaderOfPatrolId = null,}) {
  return _then(_LeaderDependentModel(
dependent: null == dependent ? _self.dependent : dependent // ignore: cast_nullable_to_non_nullable
as DependentModel,leaderOfPatrolId: null == leaderOfPatrolId ? _self._leaderOfPatrolId : leaderOfPatrolId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of LeaderDependentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DependentModelCopyWith<$Res> get dependent {
  
  return $DependentModelCopyWith<$Res>(_self.dependent, (value) {
    return _then(_self.copyWith(dependent: value));
  });
}
}

// dart format on
