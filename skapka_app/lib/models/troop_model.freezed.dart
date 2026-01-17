// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'troop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TroopModel {

 String get troopId; String get name; int get number; String get groupId; int get skautisId;
/// Create a copy of TroopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TroopModelCopyWith<TroopModel> get copyWith => _$TroopModelCopyWithImpl<TroopModel>(this as TroopModel, _$identity);

  /// Serializes this TroopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TroopModel&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,troopId,name,number,groupId,skautisId);

@override
String toString() {
  return 'TroopModel(troopId: $troopId, name: $name, number: $number, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class $TroopModelCopyWith<$Res>  {
  factory $TroopModelCopyWith(TroopModel value, $Res Function(TroopModel) _then) = _$TroopModelCopyWithImpl;
@useResult
$Res call({
 String troopId, String name, int number, String groupId, int skautisId
});




}
/// @nodoc
class _$TroopModelCopyWithImpl<$Res>
    implements $TroopModelCopyWith<$Res> {
  _$TroopModelCopyWithImpl(this._self, this._then);

  final TroopModel _self;
  final $Res Function(TroopModel) _then;

/// Create a copy of TroopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? troopId = null,Object? name = null,Object? number = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_self.copyWith(
troopId: null == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TroopModel].
extension TroopModelPatterns on TroopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TroopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TroopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TroopModel value)  $default,){
final _that = this;
switch (_that) {
case _TroopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TroopModel value)?  $default,){
final _that = this;
switch (_that) {
case _TroopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String troopId,  String name,  int number,  String groupId,  int skautisId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TroopModel() when $default != null:
return $default(_that.troopId,_that.name,_that.number,_that.groupId,_that.skautisId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String troopId,  String name,  int number,  String groupId,  int skautisId)  $default,) {final _that = this;
switch (_that) {
case _TroopModel():
return $default(_that.troopId,_that.name,_that.number,_that.groupId,_that.skautisId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String troopId,  String name,  int number,  String groupId,  int skautisId)?  $default,) {final _that = this;
switch (_that) {
case _TroopModel() when $default != null:
return $default(_that.troopId,_that.name,_that.number,_that.groupId,_that.skautisId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _TroopModel implements TroopModel {
  const _TroopModel({required this.troopId, required this.name, required this.number, required this.groupId, required this.skautisId});
  factory _TroopModel.fromJson(Map<String, dynamic> json) => _$TroopModelFromJson(json);

@override final  String troopId;
@override final  String name;
@override final  int number;
@override final  String groupId;
@override final  int skautisId;

/// Create a copy of TroopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TroopModelCopyWith<_TroopModel> get copyWith => __$TroopModelCopyWithImpl<_TroopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TroopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TroopModel&&(identical(other.troopId, troopId) || other.troopId == troopId)&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.skautisId, skautisId) || other.skautisId == skautisId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,troopId,name,number,groupId,skautisId);

@override
String toString() {
  return 'TroopModel(troopId: $troopId, name: $name, number: $number, groupId: $groupId, skautisId: $skautisId)';
}


}

/// @nodoc
abstract mixin class _$TroopModelCopyWith<$Res> implements $TroopModelCopyWith<$Res> {
  factory _$TroopModelCopyWith(_TroopModel value, $Res Function(_TroopModel) _then) = __$TroopModelCopyWithImpl;
@override @useResult
$Res call({
 String troopId, String name, int number, String groupId, int skautisId
});




}
/// @nodoc
class __$TroopModelCopyWithImpl<$Res>
    implements _$TroopModelCopyWith<$Res> {
  __$TroopModelCopyWithImpl(this._self, this._then);

  final _TroopModel _self;
  final $Res Function(_TroopModel) _then;

/// Create a copy of TroopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? troopId = null,Object? name = null,Object? number = null,Object? groupId = null,Object? skautisId = null,}) {
  return _then(_TroopModel(
troopId: null == troopId ? _self.troopId : troopId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,skautisId: null == skautisId ? _self.skautisId : skautisId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
