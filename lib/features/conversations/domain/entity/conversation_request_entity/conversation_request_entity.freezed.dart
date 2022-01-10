// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'conversation_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationRequest _$ConversationRequestFromJson(Map<String, dynamic> json) {
  return _ConversationRequest.fromJson(json);
}

/// @nodoc
class _$ConversationRequestTearOff {
  const _$ConversationRequestTearOff();

  _ConversationRequest call(
      {int? pk,
      int? group,
      @JsonKey(name: "group_detail") Conversation? groupDetail,
      @JsonKey(name: "participant_type") ParticpantType? participantType,
      RequestStatus? status}) {
    return _ConversationRequest(
      pk: pk,
      group: group,
      groupDetail: groupDetail,
      participantType: participantType,
      status: status,
    );
  }

  ConversationRequest fromJson(Map<String, Object> json) {
    return ConversationRequest.fromJson(json);
  }
}

/// @nodoc
const $ConversationRequest = _$ConversationRequestTearOff();

/// @nodoc
mixin _$ConversationRequest {
  int? get pk => throw _privateConstructorUsedError;
  int? get group => throw _privateConstructorUsedError;
  @JsonKey(name: "group_detail")
  Conversation? get groupDetail => throw _privateConstructorUsedError;
  @JsonKey(name: "participant_type")
  ParticpantType? get participantType => throw _privateConstructorUsedError;
  RequestStatus? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationRequestCopyWith<ConversationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationRequestCopyWith<$Res> {
  factory $ConversationRequestCopyWith(
          ConversationRequest value, $Res Function(ConversationRequest) then) =
      _$ConversationRequestCopyWithImpl<$Res>;
  $Res call(
      {int? pk,
      int? group,
      @JsonKey(name: "group_detail") Conversation? groupDetail,
      @JsonKey(name: "participant_type") ParticpantType? participantType,
      RequestStatus? status});

  $ConversationCopyWith<$Res>? get groupDetail;
}

/// @nodoc
class _$ConversationRequestCopyWithImpl<$Res>
    implements $ConversationRequestCopyWith<$Res> {
  _$ConversationRequestCopyWithImpl(this._value, this._then);

  final ConversationRequest _value;
  // ignore: unused_field
  final $Res Function(ConversationRequest) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? group = freezed,
    Object? groupDetail = freezed,
    Object? participantType = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      group: group == freezed
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int?,
      groupDetail: groupDetail == freezed
          ? _value.groupDetail
          : groupDetail // ignore: cast_nullable_to_non_nullable
              as Conversation?,
      participantType: participantType == freezed
          ? _value.participantType
          : participantType // ignore: cast_nullable_to_non_nullable
              as ParticpantType?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus?,
    ));
  }

  @override
  $ConversationCopyWith<$Res>? get groupDetail {
    if (_value.groupDetail == null) {
      return null;
    }

    return $ConversationCopyWith<$Res>(_value.groupDetail!, (value) {
      return _then(_value.copyWith(groupDetail: value));
    });
  }
}

/// @nodoc
abstract class _$ConversationRequestCopyWith<$Res>
    implements $ConversationRequestCopyWith<$Res> {
  factory _$ConversationRequestCopyWith(_ConversationRequest value,
          $Res Function(_ConversationRequest) then) =
      __$ConversationRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk,
      int? group,
      @JsonKey(name: "group_detail") Conversation? groupDetail,
      @JsonKey(name: "participant_type") ParticpantType? participantType,
      RequestStatus? status});

  @override
  $ConversationCopyWith<$Res>? get groupDetail;
}

/// @nodoc
class __$ConversationRequestCopyWithImpl<$Res>
    extends _$ConversationRequestCopyWithImpl<$Res>
    implements _$ConversationRequestCopyWith<$Res> {
  __$ConversationRequestCopyWithImpl(
      _ConversationRequest _value, $Res Function(_ConversationRequest) _then)
      : super(_value, (v) => _then(v as _ConversationRequest));

  @override
  _ConversationRequest get _value => super._value as _ConversationRequest;

  @override
  $Res call({
    Object? pk = freezed,
    Object? group = freezed,
    Object? groupDetail = freezed,
    Object? participantType = freezed,
    Object? status = freezed,
  }) {
    return _then(_ConversationRequest(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      group: group == freezed
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as int?,
      groupDetail: groupDetail == freezed
          ? _value.groupDetail
          : groupDetail // ignore: cast_nullable_to_non_nullable
              as Conversation?,
      participantType: participantType == freezed
          ? _value.participantType
          : participantType // ignore: cast_nullable_to_non_nullable
              as ParticpantType?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationRequest implements _ConversationRequest {
  _$_ConversationRequest(
      {this.pk,
      this.group,
      @JsonKey(name: "group_detail") this.groupDetail,
      @JsonKey(name: "participant_type") this.participantType,
      this.status});

  factory _$_ConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationRequestFromJson(json);

  @override
  final int? pk;
  @override
  final int? group;
  @override
  @JsonKey(name: "group_detail")
  final Conversation? groupDetail;
  @override
  @JsonKey(name: "participant_type")
  final ParticpantType? participantType;
  @override
  final RequestStatus? status;

  @override
  String toString() {
    return 'ConversationRequest(pk: $pk, group: $group, groupDetail: $groupDetail, participantType: $participantType, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConversationRequest &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.group, group) ||
                const DeepCollectionEquality().equals(other.group, group)) &&
            (identical(other.groupDetail, groupDetail) ||
                const DeepCollectionEquality()
                    .equals(other.groupDetail, groupDetail)) &&
            (identical(other.participantType, participantType) ||
                const DeepCollectionEquality()
                    .equals(other.participantType, participantType)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(group) ^
      const DeepCollectionEquality().hash(groupDetail) ^
      const DeepCollectionEquality().hash(participantType) ^
      const DeepCollectionEquality().hash(status);

  @JsonKey(ignore: true)
  @override
  _$ConversationRequestCopyWith<_ConversationRequest> get copyWith =>
      __$ConversationRequestCopyWithImpl<_ConversationRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationRequestToJson(this);
  }
}

abstract class _ConversationRequest implements ConversationRequest {
  factory _ConversationRequest(
      {int? pk,
      int? group,
      @JsonKey(name: "group_detail") Conversation? groupDetail,
      @JsonKey(name: "participant_type") ParticpantType? participantType,
      RequestStatus? status}) = _$_ConversationRequest;

  factory _ConversationRequest.fromJson(Map<String, dynamic> json) =
      _$_ConversationRequest.fromJson;

  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  int? get group => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "group_detail")
  Conversation? get groupDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "participant_type")
  ParticpantType? get participantType => throw _privateConstructorUsedError;
  @override
  RequestStatus? get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConversationRequestCopyWith<_ConversationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
