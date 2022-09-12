// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'push_notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationNotificationData _$ConversationNotificationDataFromJson(
    Map<String, dynamic> json) {
  return _ConversationNotificationData.fromJson(json);
}

/// @nodoc
mixin _$ConversationNotificationData {
  @JsonKey(name: "obj_type")
  PushType get type => throw _privateConstructorUsedError;
  @JsonKey(name: "group_id")
  dynamic get groupId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationNotificationDataCopyWith<ConversationNotificationData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationNotificationDataCopyWith<$Res> {
  factory $ConversationNotificationDataCopyWith(
          ConversationNotificationData value,
          $Res Function(ConversationNotificationData) then) =
      _$ConversationNotificationDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "obj_type") PushType type,
      @JsonKey(name: "group_id") dynamic groupId});
}

/// @nodoc
class _$ConversationNotificationDataCopyWithImpl<$Res>
    implements $ConversationNotificationDataCopyWith<$Res> {
  _$ConversationNotificationDataCopyWithImpl(this._value, this._then);

  final ConversationNotificationData _value;
  // ignore: unused_field
  final $Res Function(ConversationNotificationData) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PushType,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ConversationNotificationDataCopyWith<$Res>
    implements $ConversationNotificationDataCopyWith<$Res> {
  factory _$$_ConversationNotificationDataCopyWith(
          _$_ConversationNotificationData value,
          $Res Function(_$_ConversationNotificationData) then) =
      __$$_ConversationNotificationDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "obj_type") PushType type,
      @JsonKey(name: "group_id") dynamic groupId});
}

/// @nodoc
class __$$_ConversationNotificationDataCopyWithImpl<$Res>
    extends _$ConversationNotificationDataCopyWithImpl<$Res>
    implements _$$_ConversationNotificationDataCopyWith<$Res> {
  __$$_ConversationNotificationDataCopyWithImpl(
      _$_ConversationNotificationData _value,
      $Res Function(_$_ConversationNotificationData) _then)
      : super(_value, (v) => _then(v as _$_ConversationNotificationData));

  @override
  _$_ConversationNotificationData get _value =>
      super._value as _$_ConversationNotificationData;

  @override
  $Res call({
    Object? type = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_$_ConversationNotificationData(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PushType,
      groupId: groupId == freezed ? _value.groupId : groupId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationNotificationData implements _ConversationNotificationData {
  _$_ConversationNotificationData(
      {@JsonKey(name: "obj_type") required this.type,
      @JsonKey(name: "group_id") this.groupId = PushType.conversation});

  factory _$_ConversationNotificationData.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationNotificationDataFromJson(json);

  @override
  @JsonKey(name: "obj_type")
  final PushType type;
  @override
  @JsonKey(name: "group_id")
  final dynamic groupId;

  @override
  String toString() {
    return 'ConversationNotificationData(type: $type, groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationNotificationData &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.groupId, groupId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(groupId));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationNotificationDataCopyWith<_$_ConversationNotificationData>
      get copyWith => __$$_ConversationNotificationDataCopyWithImpl<
          _$_ConversationNotificationData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationNotificationDataToJson(this);
  }
}

abstract class _ConversationNotificationData
    implements ConversationNotificationData {
  factory _ConversationNotificationData(
          {@JsonKey(name: "obj_type") required final PushType type,
          @JsonKey(name: "group_id") final dynamic groupId}) =
      _$_ConversationNotificationData;

  factory _ConversationNotificationData.fromJson(Map<String, dynamic> json) =
      _$_ConversationNotificationData.fromJson;

  @override
  @JsonKey(name: "obj_type")
  PushType get type;
  @override
  @JsonKey(name: "group_id")
  dynamic get groupId;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationNotificationDataCopyWith<_$_ConversationNotificationData>
      get copyWith => throw _privateConstructorUsedError;
}
