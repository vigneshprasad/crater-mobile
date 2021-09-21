// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'webinar_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Webinar _$WebinarFromJson(Map<String, dynamic> json) {
  return _Webinar.fromJson(json);
}

/// @nodoc
class _$WebinarTearOff {
  const _$WebinarTearOff();

  _Webinar call(
      {int? id,
      String? host,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      DateTime? closedAt,
      Topic? topicDetail,
      ConversationUser? hostDetail,
      int? type,
      bool? isLive,
      int? liveCount,
      bool? rsvp}) {
    return _Webinar(
      id: id,
      host: host,
      description: description,
      start: start,
      privacy: privacy,
      medium: medium,
      closed: closed,
      closedAt: closedAt,
      topicDetail: topicDetail,
      hostDetail: hostDetail,
      type: type,
      isLive: isLive,
      liveCount: liveCount,
      rsvp: rsvp,
    );
  }

  Webinar fromJson(Map<String, Object> json) {
    return Webinar.fromJson(json);
  }
}

/// @nodoc
const $Webinar = _$WebinarTearOff();

/// @nodoc
mixin _$Webinar {
  int? get id => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  int? get privacy => throw _privateConstructorUsedError;
  int? get medium => throw _privateConstructorUsedError;
  bool? get closed => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  Topic? get topicDetail => throw _privateConstructorUsedError;
  ConversationUser? get hostDetail => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  bool? get isLive => throw _privateConstructorUsedError;
  int? get liveCount => throw _privateConstructorUsedError;
  bool? get rsvp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebinarCopyWith<Webinar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebinarCopyWith<$Res> {
  factory $WebinarCopyWith(Webinar value, $Res Function(Webinar) then) =
      _$WebinarCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? host,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      DateTime? closedAt,
      Topic? topicDetail,
      ConversationUser? hostDetail,
      int? type,
      bool? isLive,
      int? liveCount,
      bool? rsvp});

  $TopicCopyWith<$Res>? get topicDetail;
  $ConversationUserCopyWith<$Res>? get hostDetail;
}

/// @nodoc
class _$WebinarCopyWithImpl<$Res> implements $WebinarCopyWith<$Res> {
  _$WebinarCopyWithImpl(this._value, this._then);

  final Webinar _value;
  // ignore: unused_field
  final $Res Function(Webinar) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? type = freezed,
    Object? isLive = freezed,
    Object? liveCount = freezed,
    Object? rsvp = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as int?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      closedAt: closedAt == freezed
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as ConversationUser?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      liveCount: liveCount == freezed
          ? _value.liveCount
          : liveCount // ignore: cast_nullable_to_non_nullable
              as int?,
      rsvp: rsvp == freezed
          ? _value.rsvp
          : rsvp // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $TopicCopyWith<$Res>? get topicDetail {
    if (_value.topicDetail == null) {
      return null;
    }

    return $TopicCopyWith<$Res>(_value.topicDetail!, (value) {
      return _then(_value.copyWith(topicDetail: value));
    });
  }

  @override
  $ConversationUserCopyWith<$Res>? get hostDetail {
    if (_value.hostDetail == null) {
      return null;
    }

    return $ConversationUserCopyWith<$Res>(_value.hostDetail!, (value) {
      return _then(_value.copyWith(hostDetail: value));
    });
  }
}

/// @nodoc
abstract class _$WebinarCopyWith<$Res> implements $WebinarCopyWith<$Res> {
  factory _$WebinarCopyWith(_Webinar value, $Res Function(_Webinar) then) =
      __$WebinarCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? host,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      DateTime? closedAt,
      Topic? topicDetail,
      ConversationUser? hostDetail,
      int? type,
      bool? isLive,
      int? liveCount,
      bool? rsvp});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
  @override
  $ConversationUserCopyWith<$Res>? get hostDetail;
}

/// @nodoc
class __$WebinarCopyWithImpl<$Res> extends _$WebinarCopyWithImpl<$Res>
    implements _$WebinarCopyWith<$Res> {
  __$WebinarCopyWithImpl(_Webinar _value, $Res Function(_Webinar) _then)
      : super(_value, (v) => _then(v as _Webinar));

  @override
  _Webinar get _value => super._value as _Webinar;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? type = freezed,
    Object? isLive = freezed,
    Object? liveCount = freezed,
    Object? rsvp = freezed,
  }) {
    return _then(_Webinar(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as int?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      closedAt: closedAt == freezed
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as ConversationUser?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      liveCount: liveCount == freezed
          ? _value.liveCount
          : liveCount // ignore: cast_nullable_to_non_nullable
              as int?,
      rsvp: rsvp == freezed
          ? _value.rsvp
          : rsvp // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Webinar implements _Webinar {
  const _$_Webinar(
      {this.id,
      this.host,
      this.description,
      this.start,
      this.privacy,
      this.medium,
      this.closed,
      this.closedAt,
      this.topicDetail,
      this.hostDetail,
      this.type,
      this.isLive,
      this.liveCount,
      this.rsvp});

  factory _$_Webinar.fromJson(Map<String, dynamic> json) =>
      _$_$_WebinarFromJson(json);

  @override
  final int? id;
  @override
  final String? host;
  @override
  final String? description;
  @override
  final DateTime? start;
  @override
  final int? privacy;
  @override
  final int? medium;
  @override
  final bool? closed;
  @override
  final DateTime? closedAt;
  @override
  final Topic? topicDetail;
  @override
  final ConversationUser? hostDetail;
  @override
  final int? type;
  @override
  final bool? isLive;
  @override
  final int? liveCount;
  @override
  final bool? rsvp;

  @override
  String toString() {
    return 'Webinar(id: $id, host: $host, description: $description, start: $start, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, type: $type, isLive: $isLive, liveCount: $liveCount, rsvp: $rsvp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Webinar &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.host, host) ||
                const DeepCollectionEquality().equals(other.host, host)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.privacy, privacy) ||
                const DeepCollectionEquality()
                    .equals(other.privacy, privacy)) &&
            (identical(other.medium, medium) ||
                const DeepCollectionEquality().equals(other.medium, medium)) &&
            (identical(other.closed, closed) ||
                const DeepCollectionEquality().equals(other.closed, closed)) &&
            (identical(other.closedAt, closedAt) ||
                const DeepCollectionEquality()
                    .equals(other.closedAt, closedAt)) &&
            (identical(other.topicDetail, topicDetail) ||
                const DeepCollectionEquality()
                    .equals(other.topicDetail, topicDetail)) &&
            (identical(other.hostDetail, hostDetail) ||
                const DeepCollectionEquality()
                    .equals(other.hostDetail, hostDetail)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isLive, isLive) ||
                const DeepCollectionEquality().equals(other.isLive, isLive)) &&
            (identical(other.liveCount, liveCount) ||
                const DeepCollectionEquality()
                    .equals(other.liveCount, liveCount)) &&
            (identical(other.rsvp, rsvp) ||
                const DeepCollectionEquality().equals(other.rsvp, rsvp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(host) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(privacy) ^
      const DeepCollectionEquality().hash(medium) ^
      const DeepCollectionEquality().hash(closed) ^
      const DeepCollectionEquality().hash(closedAt) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(hostDetail) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isLive) ^
      const DeepCollectionEquality().hash(liveCount) ^
      const DeepCollectionEquality().hash(rsvp);

  @JsonKey(ignore: true)
  @override
  _$WebinarCopyWith<_Webinar> get copyWith =>
      __$WebinarCopyWithImpl<_Webinar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WebinarToJson(this);
  }
}

abstract class _Webinar implements Webinar {
  const factory _Webinar(
      {int? id,
      String? host,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      DateTime? closedAt,
      Topic? topicDetail,
      ConversationUser? hostDetail,
      int? type,
      bool? isLive,
      int? liveCount,
      bool? rsvp}) = _$_Webinar;

  factory _Webinar.fromJson(Map<String, dynamic> json) = _$_Webinar.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String? get host => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  DateTime? get start => throw _privateConstructorUsedError;
  @override
  int? get privacy => throw _privateConstructorUsedError;
  @override
  int? get medium => throw _privateConstructorUsedError;
  @override
  bool? get closed => throw _privateConstructorUsedError;
  @override
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @override
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @override
  ConversationUser? get hostDetail => throw _privateConstructorUsedError;
  @override
  int? get type => throw _privateConstructorUsedError;
  @override
  bool? get isLive => throw _privateConstructorUsedError;
  @override
  int? get liveCount => throw _privateConstructorUsedError;
  @override
  bool? get rsvp => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WebinarCopyWith<_Webinar> get copyWith =>
      throw _privateConstructorUsedError;
}
