// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'webinar_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Webinar _$WebinarFromJson(Map<String, dynamic> json) {
  return _Webinar.fromJson(json);
}

/// @nodoc
mixin _$Webinar {
  int? get id => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  int? get privacy => throw _privateConstructorUsedError;
  int? get medium => throw _privateConstructorUsedError;
  bool? get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_detail')
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'host_detail')
  ConversationUser? get hostDetail => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_live')
  bool? get isLive => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_past')
  bool? get isPast => throw _privateConstructorUsedError;
  @JsonKey(name: 'recording_details')
  RecordingDetails? get recordingDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList =>
      throw _privateConstructorUsedError;
  int? get liveCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_rsvp')
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
      @JsonKey(name: 'closed_at')
          DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser? hostDetail,
      int? type,
      @JsonKey(name: 'is_live')
          bool? isLive,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      int? liveCount,
      @JsonKey(name: 'has_rsvp')
          bool? rsvp});

  $TopicCopyWith<$Res>? get topicDetail;
  $ConversationUserCopyWith<$Res>? get hostDetail;
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
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
    Object? isPast = freezed,
    Object? recordingDetails = freezed,
    Object? speakersDetailList = freezed,
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
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
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

  @override
  $RecordingDetailsCopyWith<$Res>? get recordingDetails {
    if (_value.recordingDetails == null) {
      return null;
    }

    return $RecordingDetailsCopyWith<$Res>(_value.recordingDetails!, (value) {
      return _then(_value.copyWith(recordingDetails: value));
    });
  }
}

/// @nodoc
abstract class _$$_WebinarCopyWith<$Res> implements $WebinarCopyWith<$Res> {
  factory _$$_WebinarCopyWith(
          _$_Webinar value, $Res Function(_$_Webinar) then) =
      __$$_WebinarCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? host,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      @JsonKey(name: 'closed_at')
          DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser? hostDetail,
      int? type,
      @JsonKey(name: 'is_live')
          bool? isLive,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      int? liveCount,
      @JsonKey(name: 'has_rsvp')
          bool? rsvp});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
  @override
  $ConversationUserCopyWith<$Res>? get hostDetail;
  @override
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
}

/// @nodoc
class __$$_WebinarCopyWithImpl<$Res> extends _$WebinarCopyWithImpl<$Res>
    implements _$$_WebinarCopyWith<$Res> {
  __$$_WebinarCopyWithImpl(_$_Webinar _value, $Res Function(_$_Webinar) _then)
      : super(_value, (v) => _then(v as _$_Webinar));

  @override
  _$_Webinar get _value => super._value as _$_Webinar;

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
    Object? isPast = freezed,
    Object? recordingDetails = freezed,
    Object? speakersDetailList = freezed,
    Object? liveCount = freezed,
    Object? rsvp = freezed,
  }) {
    return _then(_$_Webinar(
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
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
      speakersDetailList: speakersDetailList == freezed
          ? _value._speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
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
      @JsonKey(name: 'closed_at')
          this.closedAt,
      @JsonKey(name: 'topic_detail')
          this.topicDetail,
      @JsonKey(name: 'host_detail')
          this.hostDetail,
      this.type,
      @JsonKey(name: 'is_live')
          this.isLive,
      @JsonKey(name: 'is_past')
          this.isPast,
      @JsonKey(name: 'recording_details')
          this.recordingDetails,
      @JsonKey(name: 'speakers_detail_list')
          final List<ConversationUser>? speakersDetailList,
      this.liveCount,
      @JsonKey(name: 'has_rsvp')
          this.rsvp})
      : _speakersDetailList = speakersDetailList;

  factory _$_Webinar.fromJson(Map<String, dynamic> json) =>
      _$$_WebinarFromJson(json);

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
  @JsonKey(name: 'closed_at')
  final DateTime? closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  final Topic? topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  final ConversationUser? hostDetail;
  @override
  final int? type;
  @override
  @JsonKey(name: 'is_live')
  final bool? isLive;
  @override
  @JsonKey(name: 'is_past')
  final bool? isPast;
  @override
  @JsonKey(name: 'recording_details')
  final RecordingDetails? recordingDetails;
  final List<ConversationUser>? _speakersDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList {
    final value = _speakersDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? liveCount;
  @override
  @JsonKey(name: 'has_rsvp')
  final bool? rsvp;

  @override
  String toString() {
    return 'Webinar(id: $id, host: $host, description: $description, start: $start, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, type: $type, isLive: $isLive, isPast: $isPast, recordingDetails: $recordingDetails, speakersDetailList: $speakersDetailList, liveCount: $liveCount, rsvp: $rsvp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Webinar &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.host, host) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.privacy, privacy) &&
            const DeepCollectionEquality().equals(other.medium, medium) &&
            const DeepCollectionEquality().equals(other.closed, closed) &&
            const DeepCollectionEquality().equals(other.closedAt, closedAt) &&
            const DeepCollectionEquality()
                .equals(other.topicDetail, topicDetail) &&
            const DeepCollectionEquality()
                .equals(other.hostDetail, hostDetail) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.isLive, isLive) &&
            const DeepCollectionEquality().equals(other.isPast, isPast) &&
            const DeepCollectionEquality()
                .equals(other.recordingDetails, recordingDetails) &&
            const DeepCollectionEquality()
                .equals(other._speakersDetailList, _speakersDetailList) &&
            const DeepCollectionEquality().equals(other.liveCount, liveCount) &&
            const DeepCollectionEquality().equals(other.rsvp, rsvp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(host),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(privacy),
      const DeepCollectionEquality().hash(medium),
      const DeepCollectionEquality().hash(closed),
      const DeepCollectionEquality().hash(closedAt),
      const DeepCollectionEquality().hash(topicDetail),
      const DeepCollectionEquality().hash(hostDetail),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isLive),
      const DeepCollectionEquality().hash(isPast),
      const DeepCollectionEquality().hash(recordingDetails),
      const DeepCollectionEquality().hash(_speakersDetailList),
      const DeepCollectionEquality().hash(liveCount),
      const DeepCollectionEquality().hash(rsvp));

  @JsonKey(ignore: true)
  @override
  _$$_WebinarCopyWith<_$_Webinar> get copyWith =>
      __$$_WebinarCopyWithImpl<_$_Webinar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebinarToJson(this);
  }
}

abstract class _Webinar implements Webinar {
  const factory _Webinar(
      {final int? id,
      final String? host,
      final String? description,
      final DateTime? start,
      final int? privacy,
      final int? medium,
      final bool? closed,
      @JsonKey(name: 'closed_at')
          final DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          final Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          final ConversationUser? hostDetail,
      final int? type,
      @JsonKey(name: 'is_live')
          final bool? isLive,
      @JsonKey(name: 'is_past')
          final bool? isPast,
      @JsonKey(name: 'recording_details')
          final RecordingDetails? recordingDetails,
      @JsonKey(name: 'speakers_detail_list')
          final List<ConversationUser>? speakersDetailList,
      final int? liveCount,
      @JsonKey(name: 'has_rsvp')
          final bool? rsvp}) = _$_Webinar;

  factory _Webinar.fromJson(Map<String, dynamic> json) = _$_Webinar.fromJson;

  @override
  int? get id;
  @override
  String? get host;
  @override
  String? get description;
  @override
  DateTime? get start;
  @override
  int? get privacy;
  @override
  int? get medium;
  @override
  bool? get closed;
  @override
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  Topic? get topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  ConversationUser? get hostDetail;
  @override
  int? get type;
  @override
  @JsonKey(name: 'is_live')
  bool? get isLive;
  @override
  @JsonKey(name: 'is_past')
  bool? get isPast;
  @override
  @JsonKey(name: 'recording_details')
  RecordingDetails? get recordingDetails;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList;
  @override
  int? get liveCount;
  @override
  @JsonKey(name: 'has_rsvp')
  bool? get rsvp;
  @override
  @JsonKey(ignore: true)
  _$$_WebinarCopyWith<_$_Webinar> get copyWith =>
      throw _privateConstructorUsedError;
}
