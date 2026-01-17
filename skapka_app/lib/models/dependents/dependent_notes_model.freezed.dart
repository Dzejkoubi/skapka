// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dependent_notes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DependentNotesModel {

// Dietary Flags
 bool? get hasGlutenAllergy; bool? get hasLactoseIntolerance; bool? get hasNutAllergy;// Medical Flags
 bool? get hasAsthma; bool? get isClaustrophobic; bool? get hasEpilepsy; bool? get isSwimmer;// Text Details
 String? get otherNote;
/// Create a copy of DependentNotesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DependentNotesModelCopyWith<DependentNotesModel> get copyWith => _$DependentNotesModelCopyWithImpl<DependentNotesModel>(this as DependentNotesModel, _$identity);

  /// Serializes this DependentNotesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DependentNotesModel&&(identical(other.hasGlutenAllergy, hasGlutenAllergy) || other.hasGlutenAllergy == hasGlutenAllergy)&&(identical(other.hasLactoseIntolerance, hasLactoseIntolerance) || other.hasLactoseIntolerance == hasLactoseIntolerance)&&(identical(other.hasNutAllergy, hasNutAllergy) || other.hasNutAllergy == hasNutAllergy)&&(identical(other.hasAsthma, hasAsthma) || other.hasAsthma == hasAsthma)&&(identical(other.isClaustrophobic, isClaustrophobic) || other.isClaustrophobic == isClaustrophobic)&&(identical(other.hasEpilepsy, hasEpilepsy) || other.hasEpilepsy == hasEpilepsy)&&(identical(other.isSwimmer, isSwimmer) || other.isSwimmer == isSwimmer)&&(identical(other.otherNote, otherNote) || other.otherNote == otherNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasGlutenAllergy,hasLactoseIntolerance,hasNutAllergy,hasAsthma,isClaustrophobic,hasEpilepsy,isSwimmer,otherNote);

@override
String toString() {
  return 'DependentNotesModel(hasGlutenAllergy: $hasGlutenAllergy, hasLactoseIntolerance: $hasLactoseIntolerance, hasNutAllergy: $hasNutAllergy, hasAsthma: $hasAsthma, isClaustrophobic: $isClaustrophobic, hasEpilepsy: $hasEpilepsy, isSwimmer: $isSwimmer, otherNote: $otherNote)';
}


}

/// @nodoc
abstract mixin class $DependentNotesModelCopyWith<$Res>  {
  factory $DependentNotesModelCopyWith(DependentNotesModel value, $Res Function(DependentNotesModel) _then) = _$DependentNotesModelCopyWithImpl;
@useResult
$Res call({
 bool? hasGlutenAllergy, bool? hasLactoseIntolerance, bool? hasNutAllergy, bool? hasAsthma, bool? isClaustrophobic, bool? hasEpilepsy, bool? isSwimmer, String? otherNote
});




}
/// @nodoc
class _$DependentNotesModelCopyWithImpl<$Res>
    implements $DependentNotesModelCopyWith<$Res> {
  _$DependentNotesModelCopyWithImpl(this._self, this._then);

  final DependentNotesModel _self;
  final $Res Function(DependentNotesModel) _then;

/// Create a copy of DependentNotesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasGlutenAllergy = freezed,Object? hasLactoseIntolerance = freezed,Object? hasNutAllergy = freezed,Object? hasAsthma = freezed,Object? isClaustrophobic = freezed,Object? hasEpilepsy = freezed,Object? isSwimmer = freezed,Object? otherNote = freezed,}) {
  return _then(_self.copyWith(
hasGlutenAllergy: freezed == hasGlutenAllergy ? _self.hasGlutenAllergy : hasGlutenAllergy // ignore: cast_nullable_to_non_nullable
as bool?,hasLactoseIntolerance: freezed == hasLactoseIntolerance ? _self.hasLactoseIntolerance : hasLactoseIntolerance // ignore: cast_nullable_to_non_nullable
as bool?,hasNutAllergy: freezed == hasNutAllergy ? _self.hasNutAllergy : hasNutAllergy // ignore: cast_nullable_to_non_nullable
as bool?,hasAsthma: freezed == hasAsthma ? _self.hasAsthma : hasAsthma // ignore: cast_nullable_to_non_nullable
as bool?,isClaustrophobic: freezed == isClaustrophobic ? _self.isClaustrophobic : isClaustrophobic // ignore: cast_nullable_to_non_nullable
as bool?,hasEpilepsy: freezed == hasEpilepsy ? _self.hasEpilepsy : hasEpilepsy // ignore: cast_nullable_to_non_nullable
as bool?,isSwimmer: freezed == isSwimmer ? _self.isSwimmer : isSwimmer // ignore: cast_nullable_to_non_nullable
as bool?,otherNote: freezed == otherNote ? _self.otherNote : otherNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DependentNotesModel].
extension DependentNotesModelPatterns on DependentNotesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DependentNotesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DependentNotesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DependentNotesModel value)  $default,){
final _that = this;
switch (_that) {
case _DependentNotesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DependentNotesModel value)?  $default,){
final _that = this;
switch (_that) {
case _DependentNotesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? hasGlutenAllergy,  bool? hasLactoseIntolerance,  bool? hasNutAllergy,  bool? hasAsthma,  bool? isClaustrophobic,  bool? hasEpilepsy,  bool? isSwimmer,  String? otherNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DependentNotesModel() when $default != null:
return $default(_that.hasGlutenAllergy,_that.hasLactoseIntolerance,_that.hasNutAllergy,_that.hasAsthma,_that.isClaustrophobic,_that.hasEpilepsy,_that.isSwimmer,_that.otherNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? hasGlutenAllergy,  bool? hasLactoseIntolerance,  bool? hasNutAllergy,  bool? hasAsthma,  bool? isClaustrophobic,  bool? hasEpilepsy,  bool? isSwimmer,  String? otherNote)  $default,) {final _that = this;
switch (_that) {
case _DependentNotesModel():
return $default(_that.hasGlutenAllergy,_that.hasLactoseIntolerance,_that.hasNutAllergy,_that.hasAsthma,_that.isClaustrophobic,_that.hasEpilepsy,_that.isSwimmer,_that.otherNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? hasGlutenAllergy,  bool? hasLactoseIntolerance,  bool? hasNutAllergy,  bool? hasAsthma,  bool? isClaustrophobic,  bool? hasEpilepsy,  bool? isSwimmer,  String? otherNote)?  $default,) {final _that = this;
switch (_that) {
case _DependentNotesModel() when $default != null:
return $default(_that.hasGlutenAllergy,_that.hasLactoseIntolerance,_that.hasNutAllergy,_that.hasAsthma,_that.isClaustrophobic,_that.hasEpilepsy,_that.isSwimmer,_that.otherNote);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _DependentNotesModel implements DependentNotesModel {
  const _DependentNotesModel({this.hasGlutenAllergy, this.hasLactoseIntolerance, this.hasNutAllergy, this.hasAsthma, this.isClaustrophobic, this.hasEpilepsy, this.isSwimmer, this.otherNote});
  factory _DependentNotesModel.fromJson(Map<String, dynamic> json) => _$DependentNotesModelFromJson(json);

// Dietary Flags
@override final  bool? hasGlutenAllergy;
@override final  bool? hasLactoseIntolerance;
@override final  bool? hasNutAllergy;
// Medical Flags
@override final  bool? hasAsthma;
@override final  bool? isClaustrophobic;
@override final  bool? hasEpilepsy;
@override final  bool? isSwimmer;
// Text Details
@override final  String? otherNote;

/// Create a copy of DependentNotesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DependentNotesModelCopyWith<_DependentNotesModel> get copyWith => __$DependentNotesModelCopyWithImpl<_DependentNotesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DependentNotesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DependentNotesModel&&(identical(other.hasGlutenAllergy, hasGlutenAllergy) || other.hasGlutenAllergy == hasGlutenAllergy)&&(identical(other.hasLactoseIntolerance, hasLactoseIntolerance) || other.hasLactoseIntolerance == hasLactoseIntolerance)&&(identical(other.hasNutAllergy, hasNutAllergy) || other.hasNutAllergy == hasNutAllergy)&&(identical(other.hasAsthma, hasAsthma) || other.hasAsthma == hasAsthma)&&(identical(other.isClaustrophobic, isClaustrophobic) || other.isClaustrophobic == isClaustrophobic)&&(identical(other.hasEpilepsy, hasEpilepsy) || other.hasEpilepsy == hasEpilepsy)&&(identical(other.isSwimmer, isSwimmer) || other.isSwimmer == isSwimmer)&&(identical(other.otherNote, otherNote) || other.otherNote == otherNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasGlutenAllergy,hasLactoseIntolerance,hasNutAllergy,hasAsthma,isClaustrophobic,hasEpilepsy,isSwimmer,otherNote);

@override
String toString() {
  return 'DependentNotesModel(hasGlutenAllergy: $hasGlutenAllergy, hasLactoseIntolerance: $hasLactoseIntolerance, hasNutAllergy: $hasNutAllergy, hasAsthma: $hasAsthma, isClaustrophobic: $isClaustrophobic, hasEpilepsy: $hasEpilepsy, isSwimmer: $isSwimmer, otherNote: $otherNote)';
}


}

/// @nodoc
abstract mixin class _$DependentNotesModelCopyWith<$Res> implements $DependentNotesModelCopyWith<$Res> {
  factory _$DependentNotesModelCopyWith(_DependentNotesModel value, $Res Function(_DependentNotesModel) _then) = __$DependentNotesModelCopyWithImpl;
@override @useResult
$Res call({
 bool? hasGlutenAllergy, bool? hasLactoseIntolerance, bool? hasNutAllergy, bool? hasAsthma, bool? isClaustrophobic, bool? hasEpilepsy, bool? isSwimmer, String? otherNote
});




}
/// @nodoc
class __$DependentNotesModelCopyWithImpl<$Res>
    implements _$DependentNotesModelCopyWith<$Res> {
  __$DependentNotesModelCopyWithImpl(this._self, this._then);

  final _DependentNotesModel _self;
  final $Res Function(_DependentNotesModel) _then;

/// Create a copy of DependentNotesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasGlutenAllergy = freezed,Object? hasLactoseIntolerance = freezed,Object? hasNutAllergy = freezed,Object? hasAsthma = freezed,Object? isClaustrophobic = freezed,Object? hasEpilepsy = freezed,Object? isSwimmer = freezed,Object? otherNote = freezed,}) {
  return _then(_DependentNotesModel(
hasGlutenAllergy: freezed == hasGlutenAllergy ? _self.hasGlutenAllergy : hasGlutenAllergy // ignore: cast_nullable_to_non_nullable
as bool?,hasLactoseIntolerance: freezed == hasLactoseIntolerance ? _self.hasLactoseIntolerance : hasLactoseIntolerance // ignore: cast_nullable_to_non_nullable
as bool?,hasNutAllergy: freezed == hasNutAllergy ? _self.hasNutAllergy : hasNutAllergy // ignore: cast_nullable_to_non_nullable
as bool?,hasAsthma: freezed == hasAsthma ? _self.hasAsthma : hasAsthma // ignore: cast_nullable_to_non_nullable
as bool?,isClaustrophobic: freezed == isClaustrophobic ? _self.isClaustrophobic : isClaustrophobic // ignore: cast_nullable_to_non_nullable
as bool?,hasEpilepsy: freezed == hasEpilepsy ? _self.hasEpilepsy : hasEpilepsy // ignore: cast_nullable_to_non_nullable
as bool?,isSwimmer: freezed == isSwimmer ? _self.isSwimmer : isSwimmer // ignore: cast_nullable_to_non_nullable
as bool?,otherNote: freezed == otherNote ? _self.otherNote : otherNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
