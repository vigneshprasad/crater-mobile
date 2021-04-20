// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'push_notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ConversationNotificationData _$ConversationNotificationDataFromJson(
    Map<String, dynamic> json) {
  return _ConversationNotificationData.fromJson(json);
}

/// @nodoc
class _$ConversationNotificationDataTearOff {
  const _$ConversationNotificationDataTearOff();

// ignore: unused_element
  _ConversationNotificationData call(
      {@JsonKey(name: 'obj_type') PushType type,
      @JsonKey(name: 'group_id') dynamic groupId = PushType.conversation}) {
    return _ConversationNotificationData(
      type: type,
      groupId: groupId,
    );
  }

// ignore: unused_element
  ConversationNotificationData fromJson(Map<String, Object> json) {
    return ConversationNotificationData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ConversationNotificationData = _$ConversationNotificationDataTearOff();

/// @nodoc
mixin _$ConversationNotificationData {
  @JsonKey(name: 'obj_type')
  PushType get type;
  @JsonKey(name: 'group_id')
  dynamic get groupId;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ConversationNotificationDataCopyWith<ConversationNotificationData>
      get copyWith;
}

/// @nodoc
abstract class $ConversationNotificationDataCopyWith<$Res> {
  factory $ConversationNotificationDataCopyWith(
          ConversationNotificationData value,
          $Res Function(ConversationNotificationData) then) =
      _$ConversationNotificationDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'obj_type') PushType type,
      @JsonKey(name: 'group_id') dynamic groupId});
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
    Object type = freezed,
    Object groupId = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as PushType,
      groupId: groupId == freezed ? _value.groupId : groupId as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$ConversationNotificationDataCopyWith<$Res>
    implements $ConversationNotificationDataCopyWith<$Res> {
  factory _$ConversationNotificationDataCopyWith(
          _ConversationNotificationData value,
          $Res Function(_ConversationNotificationData) then) =
      __$ConversationNotificationDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'obj_type') PushType type,
      @JsonKey(name: 'group_id') dynamic groupId});
}

/// @nodoc
class __$ConversationNotificationDataCopyWithImpl<$Res>
    extends _$ConversationNotificationDataCopyWithImpl<$Res>
    implements _$ConversationNotificationDataCopyWith<$Res> {
  __$ConversationNotificationDataCopyWithImpl(
      _ConversationNotificationData _value,
      $Res Function(_ConversationNotificationData) _then)
      : super(_value, (v) => _then(v as _ConversationNotificationData));

  @override
  _ConversationNotificationData get _value =>
      super._value as _ConversationNotificationData;

  @override
  $Res call({
    Object type = freezed,
    Object groupId = freezed,
  }) {
    return _then(_ConversationNotificationData(
      type: type == freezed ? _value.type : type as PushType,
      groupId: groupId == freezed ? _value.groupId : groupId,
    ));
  }
}

@JsonSerializable()
@Implements(PushNotificationBase)

/// @nodoc
class _$_ConversationNotificationData implements _ConversationNotificationData {
  _$_ConversationNotificationData(
      {@JsonKey(name: 'obj_type') this.type,
      @JsonKey(name: 'group_id') this.groupId = PushType.conversation})
      : assert(groupId != null);

  factory _$_ConversationNotificationData.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationNotificationDataFromJson(json);

  @override
  @JsonKey(name: 'obj_type')
  final PushType type;
  @override
  @JsonKey(name: 'group_id')
  final dynamic groupId;

  @override
  String toString() {
    return 'ConversationNotificationData(type: $type, groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConversationNotificationData &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.groupId, groupId) ||
                const DeepCollectionEquality().equals(other.groupId, groupId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(groupId);

  @JsonKey(ignore: true)
  @override
  _$ConversationNotificationDataCopyWith<_ConversationNotificationData>
      get copyWith => __$ConversationNotificationDataCopyWithImpl<
          _ConversationNotificationData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationNotificationDataToJson(this);
  }
}

abstract class _ConversationNotificationData
    implements ConversationNotificationData, PushNotificationBase {
  factory _ConversationNotificationData(
          {@JsonKey(name: 'obj_type') PushType type,
          @JsonKey(name: 'group_id') dynamic groupId}) =
      _$_ConversationNotificationData;

  factory _ConversationNotificationData.fromJson(Map<String, dynamic> json) =
      _$_ConversationNotificationData.fromJson;

  @override
  @JsonKey(name: 'obj_type')
  PushType get type;
  @override
  @JsonKey(name: 'group_id')
  dynamic get groupId;
  @override
  @JsonKey(ignore: true)
  _$ConversationNotificationDataCopyWith<_ConversationNotificationData>
      get copyWith;
}
