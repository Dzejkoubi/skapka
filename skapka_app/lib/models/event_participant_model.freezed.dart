// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_participant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventParticipantModel {

 String get eventId; String get dependentId; String get groupId; EventParticipantStatus get status; bool? get hasAttended; String? get note;
/// Create a copy of EventParticipantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventParticipantModelCopyWith<EventParticipantModel> get copyWith => _$EventParticipantModelCopyWithImpl<EventParticipantModel>(this as EventParticipantModel, _$identity);

  /// Serializes this EventParticipantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventParticipantModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.status, status) || other.status == status)&&(identical(other.hasAttended, hasAttended) || other.hasAttended == hasAttended)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,dependentId,groupId,status,hasAttended,note);

@override
String toString() {
  return 'EventParticipantModel(eventId: $eventId, dependentId: $dependentId, groupId: $groupId, status: $status, hasAttended: $hasAttended, note: $note)';
}


}

/// @nodoc
abstract mixin class $EventParticipantModelCopyWith<$Res>  {
  factory $EventParticipantModelCopyWith(EventParticipantModel value, $Res Function(EventParticipantModel) _then) = _$EventParticipantModelCopyWithImpl;
@useResult
$Res call({
 String eventId, String dependentId, String groupId, EventParticipantStatus status, bool? hasAttended, String? note
});




}
/// @nodoc
class _$EventParticipantModelCopyWithImpl<$Res>
    implements $EventParticipantModelCopyWith<$Res> {
  _$EventParticipantModelCopyWithImpl(this._self, this._then);

  final EventParticipantModel _self;
  final $Res Function(EventParticipantModel) _then;

/// Create a copy of EventParticipantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? dependentId = null,Object? groupId = null,Object? status = null,Object? hasAttended = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventParticipantStatus,hasAttended: freezed == hasAttended ? _self.hasAttended : hasAttended // ignore: cast_nullable_to_non_nullable
as bool?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventParticipantModel].
extension EventParticipantModelPatterns on EventParticipantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventParticipantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventParticipantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventParticipantModel value)  $default,){
final _that = this;
switch (_that) {
case _EventParticipantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventParticipantModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventParticipantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String dependentId,  String groupId,  EventParticipantStatus status,  bool? hasAttended,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventParticipantModel() when $default != null:
return $default(_that.eventId,_that.dependentId,_that.groupId,_that.status,_that.hasAttended,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String dependentId,  String groupId,  EventParticipantStatus status,  bool? hasAttended,  String? note)  $default,) {final _that = this;
switch (_that) {
case _EventParticipantModel():
return $default(_that.eventId,_that.dependentId,_that.groupId,_that.status,_that.hasAttended,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String dependentId,  String groupId,  EventParticipantStatus status,  bool? hasAttended,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _EventParticipantModel() when $default != null:
return $default(_that.eventId,_that.dependentId,_that.groupId,_that.status,_that.hasAttended,_that.note);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _EventParticipantModel implements EventParticipantModel {
  const _EventParticipantModel({required this.eventId, required this.dependentId, required this.groupId, required this.status, this.hasAttended = true, this.note});
  factory _EventParticipantModel.fromJson(Map<String, dynamic> json) => _$EventParticipantModelFromJson(json);

@override final  String eventId;
@override final  String dependentId;
@override final  String groupId;
@override final  EventParticipantStatus status;
@override@JsonKey() final  bool? hasAttended;
@override final  String? note;

/// Create a copy of EventParticipantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventParticipantModelCopyWith<_EventParticipantModel> get copyWith => __$EventParticipantModelCopyWithImpl<_EventParticipantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventParticipantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventParticipantModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.dependentId, dependentId) || other.dependentId == dependentId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.status, status) || other.status == status)&&(identical(other.hasAttended, hasAttended) || other.hasAttended == hasAttended)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,dependentId,groupId,status,hasAttended,note);

@override
String toString() {
  return 'EventParticipantModel(eventId: $eventId, dependentId: $dependentId, groupId: $groupId, status: $status, hasAttended: $hasAttended, note: $note)';
}


}

/// @nodoc
abstract mixin class _$EventParticipantModelCopyWith<$Res> implements $EventParticipantModelCopyWith<$Res> {
  factory _$EventParticipantModelCopyWith(_EventParticipantModel value, $Res Function(_EventParticipantModel) _then) = __$EventParticipantModelCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String dependentId, String groupId, EventParticipantStatus status, bool? hasAttended, String? note
});




}
/// @nodoc
class __$EventParticipantModelCopyWithImpl<$Res>
    implements _$EventParticipantModelCopyWith<$Res> {
  __$EventParticipantModelCopyWithImpl(this._self, this._then);

  final _EventParticipantModel _self;
  final $Res Function(_EventParticipantModel) _then;

/// Create a copy of EventParticipantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? dependentId = null,Object? groupId = null,Object? status = null,Object? hasAttended = freezed,Object? note = freezed,}) {
  return _then(_EventParticipantModel(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,dependentId: null == dependentId ? _self.dependentId : dependentId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventParticipantStatus,hasAttended: freezed == hasAttended ? _self.hasAttended : hasAttended // ignore: cast_nullable_to_non_nullable
as bool?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
