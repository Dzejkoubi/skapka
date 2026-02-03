// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventModel {

 String get eventId; String get title; String? get instructions; DateTime? get openSignUp; DateTime? get closeSignUp; DateTime? get startDate; DateTime? get endDate; String? get meetingPlace; String? get leavingPlace; String? get photoAlbumLink; String get groupId; List<String>? get targetPatrolsIds; String? get lastEditedBy; bool get isDraft;
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventModelCopyWith<EventModel> get copyWith => _$EventModelCopyWithImpl<EventModel>(this as EventModel, _$identity);

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.openSignUp, openSignUp) || other.openSignUp == openSignUp)&&(identical(other.closeSignUp, closeSignUp) || other.closeSignUp == closeSignUp)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.leavingPlace, leavingPlace) || other.leavingPlace == leavingPlace)&&(identical(other.photoAlbumLink, photoAlbumLink) || other.photoAlbumLink == photoAlbumLink)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other.targetPatrolsIds, targetPatrolsIds)&&(identical(other.lastEditedBy, lastEditedBy) || other.lastEditedBy == lastEditedBy)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,title,instructions,openSignUp,closeSignUp,startDate,endDate,meetingPlace,leavingPlace,photoAlbumLink,groupId,const DeepCollectionEquality().hash(targetPatrolsIds),lastEditedBy,isDraft);

@override
String toString() {
  return 'EventModel(eventId: $eventId, title: $title, instructions: $instructions, openSignUp: $openSignUp, closeSignUp: $closeSignUp, startDate: $startDate, endDate: $endDate, meetingPlace: $meetingPlace, leavingPlace: $leavingPlace, photoAlbumLink: $photoAlbumLink, groupId: $groupId, targetPatrolsIds: $targetPatrolsIds, lastEditedBy: $lastEditedBy, isDraft: $isDraft)';
}


}

/// @nodoc
abstract mixin class $EventModelCopyWith<$Res>  {
  factory $EventModelCopyWith(EventModel value, $Res Function(EventModel) _then) = _$EventModelCopyWithImpl;
@useResult
$Res call({
 String eventId, String title, String? instructions, DateTime? openSignUp, DateTime? closeSignUp, DateTime? startDate, DateTime? endDate, String? meetingPlace, String? leavingPlace, String? photoAlbumLink, String groupId, List<String>? targetPatrolsIds, String? lastEditedBy, bool isDraft
});




}
/// @nodoc
class _$EventModelCopyWithImpl<$Res>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._self, this._then);

  final EventModel _self;
  final $Res Function(EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? title = null,Object? instructions = freezed,Object? openSignUp = freezed,Object? closeSignUp = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? meetingPlace = freezed,Object? leavingPlace = freezed,Object? photoAlbumLink = freezed,Object? groupId = null,Object? targetPatrolsIds = freezed,Object? lastEditedBy = freezed,Object? isDraft = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,openSignUp: freezed == openSignUp ? _self.openSignUp : openSignUp // ignore: cast_nullable_to_non_nullable
as DateTime?,closeSignUp: freezed == closeSignUp ? _self.closeSignUp : closeSignUp // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,meetingPlace: freezed == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String?,leavingPlace: freezed == leavingPlace ? _self.leavingPlace : leavingPlace // ignore: cast_nullable_to_non_nullable
as String?,photoAlbumLink: freezed == photoAlbumLink ? _self.photoAlbumLink : photoAlbumLink // ignore: cast_nullable_to_non_nullable
as String?,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,targetPatrolsIds: freezed == targetPatrolsIds ? _self.targetPatrolsIds : targetPatrolsIds // ignore: cast_nullable_to_non_nullable
as List<String>?,lastEditedBy: freezed == lastEditedBy ? _self.lastEditedBy : lastEditedBy // ignore: cast_nullable_to_non_nullable
as String?,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventModel].
extension EventModelPatterns on EventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventModel value)  $default,){
final _that = this;
switch (_that) {
case _EventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  String title,  String? instructions,  DateTime? openSignUp,  DateTime? closeSignUp,  DateTime? startDate,  DateTime? endDate,  String? meetingPlace,  String? leavingPlace,  String? photoAlbumLink,  String groupId,  List<String>? targetPatrolsIds,  String? lastEditedBy,  bool isDraft)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.eventId,_that.title,_that.instructions,_that.openSignUp,_that.closeSignUp,_that.startDate,_that.endDate,_that.meetingPlace,_that.leavingPlace,_that.photoAlbumLink,_that.groupId,_that.targetPatrolsIds,_that.lastEditedBy,_that.isDraft);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  String title,  String? instructions,  DateTime? openSignUp,  DateTime? closeSignUp,  DateTime? startDate,  DateTime? endDate,  String? meetingPlace,  String? leavingPlace,  String? photoAlbumLink,  String groupId,  List<String>? targetPatrolsIds,  String? lastEditedBy,  bool isDraft)  $default,) {final _that = this;
switch (_that) {
case _EventModel():
return $default(_that.eventId,_that.title,_that.instructions,_that.openSignUp,_that.closeSignUp,_that.startDate,_that.endDate,_that.meetingPlace,_that.leavingPlace,_that.photoAlbumLink,_that.groupId,_that.targetPatrolsIds,_that.lastEditedBy,_that.isDraft);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  String title,  String? instructions,  DateTime? openSignUp,  DateTime? closeSignUp,  DateTime? startDate,  DateTime? endDate,  String? meetingPlace,  String? leavingPlace,  String? photoAlbumLink,  String groupId,  List<String>? targetPatrolsIds,  String? lastEditedBy,  bool isDraft)?  $default,) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.eventId,_that.title,_that.instructions,_that.openSignUp,_that.closeSignUp,_that.startDate,_that.endDate,_that.meetingPlace,_that.leavingPlace,_that.photoAlbumLink,_that.groupId,_that.targetPatrolsIds,_that.lastEditedBy,_that.isDraft);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _EventModel implements EventModel {
  const _EventModel({required this.eventId, required this.title, required this.instructions, required this.openSignUp, required this.closeSignUp, required this.startDate, required this.endDate, required this.meetingPlace, required this.leavingPlace, required this.photoAlbumLink, required this.groupId, required final  List<String>? targetPatrolsIds, required this.lastEditedBy, required this.isDraft}): _targetPatrolsIds = targetPatrolsIds;
  factory _EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

@override final  String eventId;
@override final  String title;
@override final  String? instructions;
@override final  DateTime? openSignUp;
@override final  DateTime? closeSignUp;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  String? meetingPlace;
@override final  String? leavingPlace;
@override final  String? photoAlbumLink;
@override final  String groupId;
 final  List<String>? _targetPatrolsIds;
@override List<String>? get targetPatrolsIds {
  final value = _targetPatrolsIds;
  if (value == null) return null;
  if (_targetPatrolsIds is EqualUnmodifiableListView) return _targetPatrolsIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? lastEditedBy;
@override final  bool isDraft;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventModelCopyWith<_EventModel> get copyWith => __$EventModelCopyWithImpl<_EventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventModel&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.title, title) || other.title == title)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.openSignUp, openSignUp) || other.openSignUp == openSignUp)&&(identical(other.closeSignUp, closeSignUp) || other.closeSignUp == closeSignUp)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.meetingPlace, meetingPlace) || other.meetingPlace == meetingPlace)&&(identical(other.leavingPlace, leavingPlace) || other.leavingPlace == leavingPlace)&&(identical(other.photoAlbumLink, photoAlbumLink) || other.photoAlbumLink == photoAlbumLink)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other._targetPatrolsIds, _targetPatrolsIds)&&(identical(other.lastEditedBy, lastEditedBy) || other.lastEditedBy == lastEditedBy)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,title,instructions,openSignUp,closeSignUp,startDate,endDate,meetingPlace,leavingPlace,photoAlbumLink,groupId,const DeepCollectionEquality().hash(_targetPatrolsIds),lastEditedBy,isDraft);

@override
String toString() {
  return 'EventModel(eventId: $eventId, title: $title, instructions: $instructions, openSignUp: $openSignUp, closeSignUp: $closeSignUp, startDate: $startDate, endDate: $endDate, meetingPlace: $meetingPlace, leavingPlace: $leavingPlace, photoAlbumLink: $photoAlbumLink, groupId: $groupId, targetPatrolsIds: $targetPatrolsIds, lastEditedBy: $lastEditedBy, isDraft: $isDraft)';
}


}

/// @nodoc
abstract mixin class _$EventModelCopyWith<$Res> implements $EventModelCopyWith<$Res> {
  factory _$EventModelCopyWith(_EventModel value, $Res Function(_EventModel) _then) = __$EventModelCopyWithImpl;
@override @useResult
$Res call({
 String eventId, String title, String? instructions, DateTime? openSignUp, DateTime? closeSignUp, DateTime? startDate, DateTime? endDate, String? meetingPlace, String? leavingPlace, String? photoAlbumLink, String groupId, List<String>? targetPatrolsIds, String? lastEditedBy, bool isDraft
});




}
/// @nodoc
class __$EventModelCopyWithImpl<$Res>
    implements _$EventModelCopyWith<$Res> {
  __$EventModelCopyWithImpl(this._self, this._then);

  final _EventModel _self;
  final $Res Function(_EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? title = null,Object? instructions = freezed,Object? openSignUp = freezed,Object? closeSignUp = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? meetingPlace = freezed,Object? leavingPlace = freezed,Object? photoAlbumLink = freezed,Object? groupId = null,Object? targetPatrolsIds = freezed,Object? lastEditedBy = freezed,Object? isDraft = null,}) {
  return _then(_EventModel(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,openSignUp: freezed == openSignUp ? _self.openSignUp : openSignUp // ignore: cast_nullable_to_non_nullable
as DateTime?,closeSignUp: freezed == closeSignUp ? _self.closeSignUp : closeSignUp // ignore: cast_nullable_to_non_nullable
as DateTime?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,meetingPlace: freezed == meetingPlace ? _self.meetingPlace : meetingPlace // ignore: cast_nullable_to_non_nullable
as String?,leavingPlace: freezed == leavingPlace ? _self.leavingPlace : leavingPlace // ignore: cast_nullable_to_non_nullable
as String?,photoAlbumLink: freezed == photoAlbumLink ? _self.photoAlbumLink : photoAlbumLink // ignore: cast_nullable_to_non_nullable
as String?,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,targetPatrolsIds: freezed == targetPatrolsIds ? _self._targetPatrolsIds : targetPatrolsIds // ignore: cast_nullable_to_non_nullable
as List<String>?,lastEditedBy: freezed == lastEditedBy ? _self.lastEditedBy : lastEditedBy // ignore: cast_nullable_to_non_nullable
as String?,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
