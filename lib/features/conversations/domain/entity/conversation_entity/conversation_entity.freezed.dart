// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  int? get id => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  List<String>? get speakers => throw _privateConstructorUsedError;
  List<String>? get attendees => throw _privateConstructorUsedError;
  int? get topic => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<int>? get interests => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  DateTime? get end => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_speakers')
  int? get maxSpeakers => throw _privateConstructorUsedError;
  ConversationPrivacy? get privacy => throw _privateConstructorUsedError;
  ConversationMedium? get medium => throw _privateConstructorUsedError;
  bool? get closed => throw _privateConstructorUsedError;
  int? get relevancy => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_detail')
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'host_detail')
  ConversationUser? get hostDetail => throw _privateConstructorUsedError;
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'attendees_detail_list')
  List<ConversationUser>? get attendeesDetailList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'is_speaker')
  bool? get isSpeaker => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_past')
  bool? get isPast => throw _privateConstructorUsedError;
  @JsonKey(name: 'recording_details')
  RecordingDetails? get recordingDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? host,
      List<String>? speakers,
      List<String>? attendees,
      int? topic,
      String? description,
      List<int>? interests,
      DateTime? start,
      DateTime? end,
      @JsonKey(name: 'max_speakers')
          int? maxSpeakers,
      ConversationPrivacy? privacy,
      ConversationMedium? medium,
      bool? closed,
      int? relevancy,
      @JsonKey(name: 'closed_at')
          DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser? hostDetail,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          bool? isSpeaker,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails});

  $TopicCopyWith<$Res>? get topicDetail;
  $ConversationUserCopyWith<$Res>? get hostDetail;
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  final Conversation _value;
  // ignore: unused_field
  final $Res Function(Conversation) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? speakers = freezed,
    Object? attendees = freezed,
    Object? topic = freezed,
    Object? description = freezed,
    Object? interests = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? maxSpeakers = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? relevancy = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? speakersDetailList = freezed,
    Object? attendeesDetailList = freezed,
    Object? isSpeaker = freezed,
    Object? isPast = freezed,
    Object? recordingDetails = freezed,
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
      speakers: speakers == freezed
          ? _value.speakers
          : speakers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attendees: attendees == freezed
          ? _value.attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: interests == freezed
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxSpeakers: maxSpeakers == freezed
          ? _value.maxSpeakers
          : maxSpeakers // ignore: cast_nullable_to_non_nullable
              as int?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as ConversationPrivacy?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ConversationMedium?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      relevancy: relevancy == freezed
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as int?,
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
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
      attendeesDetailList: attendeesDetailList == freezed
          ? _value.attendeesDetailList
          : attendeesDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
      isSpeaker: isSpeaker == freezed
          ? _value.isSpeaker
          : isSpeaker // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
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
abstract class _$$_ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$_ConversationCopyWith(
          _$_Conversation value, $Res Function(_$_Conversation) then) =
      __$$_ConversationCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? host,
      List<String>? speakers,
      List<String>? attendees,
      int? topic,
      String? description,
      List<int>? interests,
      DateTime? start,
      DateTime? end,
      @JsonKey(name: 'max_speakers')
          int? maxSpeakers,
      ConversationPrivacy? privacy,
      ConversationMedium? medium,
      bool? closed,
      int? relevancy,
      @JsonKey(name: 'closed_at')
          DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser? hostDetail,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          bool? isSpeaker,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
  @override
  $ConversationUserCopyWith<$Res>? get hostDetail;
  @override
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
}

/// @nodoc
class __$$_ConversationCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res>
    implements _$$_ConversationCopyWith<$Res> {
  __$$_ConversationCopyWithImpl(
      _$_Conversation _value, $Res Function(_$_Conversation) _then)
      : super(_value, (v) => _then(v as _$_Conversation));

  @override
  _$_Conversation get _value => super._value as _$_Conversation;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? speakers = freezed,
    Object? attendees = freezed,
    Object? topic = freezed,
    Object? description = freezed,
    Object? interests = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? maxSpeakers = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? relevancy = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? speakersDetailList = freezed,
    Object? attendeesDetailList = freezed,
    Object? isSpeaker = freezed,
    Object? isPast = freezed,
    Object? recordingDetails = freezed,
  }) {
    return _then(_$_Conversation(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      speakers: speakers == freezed
          ? _value._speakers
          : speakers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      attendees: attendees == freezed
          ? _value._attendees
          : attendees // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      interests: interests == freezed
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: end == freezed
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maxSpeakers: maxSpeakers == freezed
          ? _value.maxSpeakers
          : maxSpeakers // ignore: cast_nullable_to_non_nullable
              as int?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as ConversationPrivacy?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as ConversationMedium?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      relevancy: relevancy == freezed
          ? _value.relevancy
          : relevancy // ignore: cast_nullable_to_non_nullable
              as int?,
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
      speakersDetailList: speakersDetailList == freezed
          ? _value._speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
      attendeesDetailList: attendeesDetailList == freezed
          ? _value._attendeesDetailList
          : attendeesDetailList // ignore: cast_nullable_to_non_nullable
              as List<ConversationUser>?,
      isSpeaker: isSpeaker == freezed
          ? _value.isSpeaker
          : isSpeaker // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Conversation implements _Conversation {
  _$_Conversation(
      {this.id,
      this.host,
      final List<String>? speakers,
      final List<String>? attendees,
      this.topic,
      this.description,
      final List<int>? interests,
      this.start,
      this.end,
      @JsonKey(name: 'max_speakers')
          this.maxSpeakers,
      this.privacy,
      this.medium,
      this.closed,
      this.relevancy,
      @JsonKey(name: 'closed_at')
          this.closedAt,
      @JsonKey(name: 'topic_detail')
          this.topicDetail,
      @JsonKey(name: 'host_detail')
          this.hostDetail,
      @JsonKey(name: 'speakers_detail_list')
          final List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          final List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          this.isSpeaker,
      @JsonKey(name: 'is_past')
          this.isPast,
      @JsonKey(name: 'recording_details')
          this.recordingDetails})
      : _speakers = speakers,
        _attendees = attendees,
        _interests = interests,
        _speakersDetailList = speakersDetailList,
        _attendeesDetailList = attendeesDetailList;

  factory _$_Conversation.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationFromJson(json);

  @override
  final int? id;
  @override
  final String? host;
  final List<String>? _speakers;
  @override
  List<String>? get speakers {
    final value = _speakers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _attendees;
  @override
  List<String>? get attendees {
    final value = _attendees;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? topic;
  @override
  final String? description;
  final List<int>? _interests;
  @override
  List<int>? get interests {
    final value = _interests;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  @JsonKey(name: 'max_speakers')
  final int? maxSpeakers;
  @override
  final ConversationPrivacy? privacy;
  @override
  final ConversationMedium? medium;
  @override
  final bool? closed;
  @override
  final int? relevancy;
  @override
  @JsonKey(name: 'closed_at')
  final DateTime? closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  final Topic? topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  final ConversationUser? hostDetail;
  final List<ConversationUser>? _speakersDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList {
    final value = _speakersDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ConversationUser>? _attendeesDetailList;
  @override
  @JsonKey(name: 'attendees_detail_list')
  List<ConversationUser>? get attendeesDetailList {
    final value = _attendeesDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_speaker')
  final bool? isSpeaker;
  @override
  @JsonKey(name: 'is_past')
  final bool? isPast;
  @override
  @JsonKey(name: 'recording_details')
  final RecordingDetails? recordingDetails;

  @override
  String toString() {
    return 'Conversation(id: $id, host: $host, speakers: $speakers, attendees: $attendees, topic: $topic, description: $description, interests: $interests, start: $start, end: $end, maxSpeakers: $maxSpeakers, privacy: $privacy, medium: $medium, closed: $closed, relevancy: $relevancy, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, speakersDetailList: $speakersDetailList, attendeesDetailList: $attendeesDetailList, isSpeaker: $isSpeaker, isPast: $isPast, recordingDetails: $recordingDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Conversation &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.host, host) &&
            const DeepCollectionEquality().equals(other._speakers, _speakers) &&
            const DeepCollectionEquality()
                .equals(other._attendees, _attendees) &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.end, end) &&
            const DeepCollectionEquality()
                .equals(other.maxSpeakers, maxSpeakers) &&
            const DeepCollectionEquality().equals(other.privacy, privacy) &&
            const DeepCollectionEquality().equals(other.medium, medium) &&
            const DeepCollectionEquality().equals(other.closed, closed) &&
            const DeepCollectionEquality().equals(other.relevancy, relevancy) &&
            const DeepCollectionEquality().equals(other.closedAt, closedAt) &&
            const DeepCollectionEquality()
                .equals(other.topicDetail, topicDetail) &&
            const DeepCollectionEquality()
                .equals(other.hostDetail, hostDetail) &&
            const DeepCollectionEquality()
                .equals(other._speakersDetailList, _speakersDetailList) &&
            const DeepCollectionEquality()
                .equals(other._attendeesDetailList, _attendeesDetailList) &&
            const DeepCollectionEquality().equals(other.isSpeaker, isSpeaker) &&
            const DeepCollectionEquality().equals(other.isPast, isPast) &&
            const DeepCollectionEquality()
                .equals(other.recordingDetails, recordingDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(host),
        const DeepCollectionEquality().hash(_speakers),
        const DeepCollectionEquality().hash(_attendees),
        const DeepCollectionEquality().hash(topic),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(_interests),
        const DeepCollectionEquality().hash(start),
        const DeepCollectionEquality().hash(end),
        const DeepCollectionEquality().hash(maxSpeakers),
        const DeepCollectionEquality().hash(privacy),
        const DeepCollectionEquality().hash(medium),
        const DeepCollectionEquality().hash(closed),
        const DeepCollectionEquality().hash(relevancy),
        const DeepCollectionEquality().hash(closedAt),
        const DeepCollectionEquality().hash(topicDetail),
        const DeepCollectionEquality().hash(hostDetail),
        const DeepCollectionEquality().hash(_speakersDetailList),
        const DeepCollectionEquality().hash(_attendeesDetailList),
        const DeepCollectionEquality().hash(isSpeaker),
        const DeepCollectionEquality().hash(isPast),
        const DeepCollectionEquality().hash(recordingDetails)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_ConversationCopyWith<_$_Conversation> get copyWith =>
      __$$_ConversationCopyWithImpl<_$_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationToJson(this);
  }
}

abstract class _Conversation implements Conversation {
  factory _Conversation(
      {final int? id,
      final String? host,
      final List<String>? speakers,
      final List<String>? attendees,
      final int? topic,
      final String? description,
      final List<int>? interests,
      final DateTime? start,
      final DateTime? end,
      @JsonKey(name: 'max_speakers')
          final int? maxSpeakers,
      final ConversationPrivacy? privacy,
      final ConversationMedium? medium,
      final bool? closed,
      final int? relevancy,
      @JsonKey(name: 'closed_at')
          final DateTime? closedAt,
      @JsonKey(name: 'topic_detail')
          final Topic? topicDetail,
      @JsonKey(name: 'host_detail')
          final ConversationUser? hostDetail,
      @JsonKey(name: 'speakers_detail_list')
          final List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          final List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          final bool? isSpeaker,
      @JsonKey(name: 'is_past')
          final bool? isPast,
      @JsonKey(name: 'recording_details')
          final RecordingDetails? recordingDetails}) = _$_Conversation;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$_Conversation.fromJson;

  @override
  int? get id;
  @override
  String? get host;
  @override
  List<String>? get speakers;
  @override
  List<String>? get attendees;
  @override
  int? get topic;
  @override
  String? get description;
  @override
  List<int>? get interests;
  @override
  DateTime? get start;
  @override
  DateTime? get end;
  @override
  @JsonKey(name: 'max_speakers')
  int? get maxSpeakers;
  @override
  ConversationPrivacy? get privacy;
  @override
  ConversationMedium? get medium;
  @override
  bool? get closed;
  @override
  int? get relevancy;
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
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList;
  @override
  @JsonKey(name: 'attendees_detail_list')
  List<ConversationUser>? get attendeesDetailList;
  @override
  @JsonKey(name: 'is_speaker')
  bool? get isSpeaker;
  @override
  @JsonKey(name: 'is_past')
  bool? get isPast;
  @override
  @JsonKey(name: 'recording_details')
  RecordingDetails? get recordingDetails;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationCopyWith<_$_Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordingDetails _$RecordingDetailsFromJson(Map<String, dynamic> json) {
  return _RecordingDetails.fromJson(json);
}

/// @nodoc
mixin _$RecordingDetails {
  String? get recording => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordingDetailsCopyWith<RecordingDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingDetailsCopyWith<$Res> {
  factory $RecordingDetailsCopyWith(
          RecordingDetails value, $Res Function(RecordingDetails) then) =
      _$RecordingDetailsCopyWithImpl<$Res>;
  $Res call({String? recording});
}

/// @nodoc
class _$RecordingDetailsCopyWithImpl<$Res>
    implements $RecordingDetailsCopyWith<$Res> {
  _$RecordingDetailsCopyWithImpl(this._value, this._then);

  final RecordingDetails _value;
  // ignore: unused_field
  final $Res Function(RecordingDetails) _then;

  @override
  $Res call({
    Object? recording = freezed,
  }) {
    return _then(_value.copyWith(
      recording: recording == freezed
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_RecordingDetailsCopyWith<$Res>
    implements $RecordingDetailsCopyWith<$Res> {
  factory _$$_RecordingDetailsCopyWith(
          _$_RecordingDetails value, $Res Function(_$_RecordingDetails) then) =
      __$$_RecordingDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String? recording});
}

/// @nodoc
class __$$_RecordingDetailsCopyWithImpl<$Res>
    extends _$RecordingDetailsCopyWithImpl<$Res>
    implements _$$_RecordingDetailsCopyWith<$Res> {
  __$$_RecordingDetailsCopyWithImpl(
      _$_RecordingDetails _value, $Res Function(_$_RecordingDetails) _then)
      : super(_value, (v) => _then(v as _$_RecordingDetails));

  @override
  _$_RecordingDetails get _value => super._value as _$_RecordingDetails;

  @override
  $Res call({
    Object? recording = freezed,
  }) {
    return _then(_$_RecordingDetails(
      recording: recording == freezed
          ? _value.recording
          : recording // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecordingDetails implements _RecordingDetails {
  _$_RecordingDetails({this.recording});

  factory _$_RecordingDetails.fromJson(Map<String, dynamic> json) =>
      _$$_RecordingDetailsFromJson(json);

  @override
  final String? recording;

  @override
  String toString() {
    return 'RecordingDetails(recording: $recording)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordingDetails &&
            const DeepCollectionEquality().equals(other.recording, recording));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(recording));

  @JsonKey(ignore: true)
  @override
  _$$_RecordingDetailsCopyWith<_$_RecordingDetails> get copyWith =>
      __$$_RecordingDetailsCopyWithImpl<_$_RecordingDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordingDetailsToJson(this);
  }
}

abstract class _RecordingDetails implements RecordingDetails {
  factory _RecordingDetails({final String? recording}) = _$_RecordingDetails;

  factory _RecordingDetails.fromJson(Map<String, dynamic> json) =
      _$_RecordingDetails.fromJson;

  @override
  String? get recording;
  @override
  @JsonKey(ignore: true)
  _$$_RecordingDetailsCopyWith<_$_RecordingDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationUser _$ConversationUserFromJson(Map<String, dynamic> json) {
  return _ConversationUser.fromJson(json);
}

/// @nodoc
mixin _$ConversationUser {
  String? get pk => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator_detail')
  Creator? get creatorDetail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationUserCopyWith<ConversationUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationUserCopyWith<$Res> {
  factory $ConversationUserCopyWith(
          ConversationUser value, $Res Function(ConversationUser) then) =
      _$ConversationUserCopyWithImpl<$Res>;
  $Res call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: 'creator_detail') Creator? creatorDetail});

  $CreatorCopyWith<$Res>? get creatorDetail;
}

/// @nodoc
class _$ConversationUserCopyWithImpl<$Res>
    implements $ConversationUserCopyWith<$Res> {
  _$ConversationUserCopyWithImpl(this._value, this._then);

  final ConversationUser _value;
  // ignore: unused_field
  final $Res Function(ConversationUser) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorDetail: creatorDetail == freezed
          ? _value.creatorDetail
          : creatorDetail // ignore: cast_nullable_to_non_nullable
              as Creator?,
    ));
  }

  @override
  $CreatorCopyWith<$Res>? get creatorDetail {
    if (_value.creatorDetail == null) {
      return null;
    }

    return $CreatorCopyWith<$Res>(_value.creatorDetail!, (value) {
      return _then(_value.copyWith(creatorDetail: value));
    });
  }
}

/// @nodoc
abstract class _$$_ConversationUserCopyWith<$Res>
    implements $ConversationUserCopyWith<$Res> {
  factory _$$_ConversationUserCopyWith(
          _$_ConversationUser value, $Res Function(_$_ConversationUser) then) =
      __$$_ConversationUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: 'creator_detail') Creator? creatorDetail});

  @override
  $CreatorCopyWith<$Res>? get creatorDetail;
}

/// @nodoc
class __$$_ConversationUserCopyWithImpl<$Res>
    extends _$ConversationUserCopyWithImpl<$Res>
    implements _$$_ConversationUserCopyWith<$Res> {
  __$$_ConversationUserCopyWithImpl(
      _$_ConversationUser _value, $Res Function(_$_ConversationUser) _then)
      : super(_value, (v) => _then(v as _$_ConversationUser));

  @override
  _$_ConversationUser get _value => super._value as _$_ConversationUser;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_$_ConversationUser(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorDetail: creatorDetail == freezed
          ? _value.creatorDetail
          : creatorDetail // ignore: cast_nullable_to_non_nullable
              as Creator?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationUser implements _ConversationUser {
  _$_ConversationUser(
      {this.pk,
      this.email,
      this.name,
      this.photo,
      this.introduction,
      @JsonKey(name: 'creator_detail') this.creatorDetail});

  factory _$_ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationUserFromJson(json);

  @override
  final String? pk;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? photo;
  @override
  final String? introduction;
  @override
  @JsonKey(name: 'creator_detail')
  final Creator? creatorDetail;

  @override
  String toString() {
    return 'ConversationUser(pk: $pk, email: $email, name: $name, photo: $photo, introduction: $introduction, creatorDetail: $creatorDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationUser &&
            const DeepCollectionEquality().equals(other.pk, pk) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality()
                .equals(other.introduction, introduction) &&
            const DeepCollectionEquality()
                .equals(other.creatorDetail, creatorDetail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pk),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(introduction),
      const DeepCollectionEquality().hash(creatorDetail));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationUserCopyWith<_$_ConversationUser> get copyWith =>
      __$$_ConversationUserCopyWithImpl<_$_ConversationUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationUserToJson(this);
  }
}

abstract class _ConversationUser implements ConversationUser {
  factory _ConversationUser(
          {final String? pk,
          final String? email,
          final String? name,
          final String? photo,
          final String? introduction,
          @JsonKey(name: 'creator_detail') final Creator? creatorDetail}) =
      _$_ConversationUser;

  factory _ConversationUser.fromJson(Map<String, dynamic> json) =
      _$_ConversationUser.fromJson;

  @override
  String? get pk;
  @override
  String? get email;
  @override
  String? get name;
  @override
  String? get photo;
  @override
  String? get introduction;
  @override
  @JsonKey(name: 'creator_detail')
  Creator? get creatorDetail;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationUserCopyWith<_$_ConversationUser> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationByDate _$ConversationByDateFromJson(Map<String, dynamic> json) {
  return _ConversationByDate.fromJson(json);
}

/// @nodoc
mixin _$ConversationByDate {
  DateTime? get date => throw _privateConstructorUsedError;
  List<Conversation>? get conversations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationByDateCopyWith<ConversationByDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationByDateCopyWith<$Res> {
  factory $ConversationByDateCopyWith(
          ConversationByDate value, $Res Function(ConversationByDate) then) =
      _$ConversationByDateCopyWithImpl<$Res>;
  $Res call({DateTime? date, List<Conversation>? conversations});
}

/// @nodoc
class _$ConversationByDateCopyWithImpl<$Res>
    implements $ConversationByDateCopyWith<$Res> {
  _$ConversationByDateCopyWithImpl(this._value, this._then);

  final ConversationByDate _value;
  // ignore: unused_field
  final $Res Function(ConversationByDate) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? conversations = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ConversationByDateCopyWith<$Res>
    implements $ConversationByDateCopyWith<$Res> {
  factory _$$_ConversationByDateCopyWith(_$_ConversationByDate value,
          $Res Function(_$_ConversationByDate) then) =
      __$$_ConversationByDateCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? date, List<Conversation>? conversations});
}

/// @nodoc
class __$$_ConversationByDateCopyWithImpl<$Res>
    extends _$ConversationByDateCopyWithImpl<$Res>
    implements _$$_ConversationByDateCopyWith<$Res> {
  __$$_ConversationByDateCopyWithImpl(
      _$_ConversationByDate _value, $Res Function(_$_ConversationByDate) _then)
      : super(_value, (v) => _then(v as _$_ConversationByDate));

  @override
  _$_ConversationByDate get _value => super._value as _$_ConversationByDate;

  @override
  $Res call({
    Object? date = freezed,
    Object? conversations = freezed,
  }) {
    return _then(_$_ConversationByDate(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conversations: conversations == freezed
          ? _value._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationByDate implements _ConversationByDate {
  _$_ConversationByDate({this.date, final List<Conversation>? conversations})
      : _conversations = conversations;

  factory _$_ConversationByDate.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationByDateFromJson(json);

  @override
  final DateTime? date;
  final List<Conversation>? _conversations;
  @override
  List<Conversation>? get conversations {
    final value = _conversations;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConversationByDate(date: $date, conversations: $conversations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationByDate &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(_conversations));

  @JsonKey(ignore: true)
  @override
  _$$_ConversationByDateCopyWith<_$_ConversationByDate> get copyWith =>
      __$$_ConversationByDateCopyWithImpl<_$_ConversationByDate>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationByDateToJson(this);
  }
}

abstract class _ConversationByDate implements ConversationByDate {
  factory _ConversationByDate(
      {final DateTime? date,
      final List<Conversation>? conversations}) = _$_ConversationByDate;

  factory _ConversationByDate.fromJson(Map<String, dynamic> json) =
      _$_ConversationByDate.fromJson;

  @override
  DateTime? get date;
  @override
  List<Conversation>? get conversations;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationByDateCopyWith<_$_ConversationByDate> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) {
  return _UserPermission.fromJson(json);
}

/// @nodoc
mixin _$UserPermission {
  @JsonKey(name: 'allow_create_stream')
  bool? get allowCreateStream => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_chat')
  bool? get allowChat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPermissionCopyWith<UserPermission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPermissionCopyWith<$Res> {
  factory $UserPermissionCopyWith(
          UserPermission value, $Res Function(UserPermission) then) =
      _$UserPermissionCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') bool? allowChat});
}

/// @nodoc
class _$UserPermissionCopyWithImpl<$Res>
    implements $UserPermissionCopyWith<$Res> {
  _$UserPermissionCopyWithImpl(this._value, this._then);

  final UserPermission _value;
  // ignore: unused_field
  final $Res Function(UserPermission) _then;

  @override
  $Res call({
    Object? allowCreateStream = freezed,
    Object? allowChat = freezed,
  }) {
    return _then(_value.copyWith(
      allowCreateStream: allowCreateStream == freezed
          ? _value.allowCreateStream
          : allowCreateStream // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowChat: allowChat == freezed
          ? _value.allowChat
          : allowChat // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserPermissionCopyWith<$Res>
    implements $UserPermissionCopyWith<$Res> {
  factory _$$_UserPermissionCopyWith(
          _$_UserPermission value, $Res Function(_$_UserPermission) then) =
      __$$_UserPermissionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') bool? allowChat});
}

/// @nodoc
class __$$_UserPermissionCopyWithImpl<$Res>
    extends _$UserPermissionCopyWithImpl<$Res>
    implements _$$_UserPermissionCopyWith<$Res> {
  __$$_UserPermissionCopyWithImpl(
      _$_UserPermission _value, $Res Function(_$_UserPermission) _then)
      : super(_value, (v) => _then(v as _$_UserPermission));

  @override
  _$_UserPermission get _value => super._value as _$_UserPermission;

  @override
  $Res call({
    Object? allowCreateStream = freezed,
    Object? allowChat = freezed,
  }) {
    return _then(_$_UserPermission(
      allowCreateStream: allowCreateStream == freezed
          ? _value.allowCreateStream
          : allowCreateStream // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowChat: allowChat == freezed
          ? _value.allowChat
          : allowChat // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserPermission implements _UserPermission {
  _$_UserPermission(
      {@JsonKey(name: 'allow_create_stream') this.allowCreateStream,
      @JsonKey(name: 'allow_chat') this.allowChat});

  factory _$_UserPermission.fromJson(Map<String, dynamic> json) =>
      _$$_UserPermissionFromJson(json);

  @override
  @JsonKey(name: 'allow_create_stream')
  final bool? allowCreateStream;
  @override
  @JsonKey(name: 'allow_chat')
  final bool? allowChat;

  @override
  String toString() {
    return 'UserPermission(allowCreateStream: $allowCreateStream, allowChat: $allowChat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserPermission &&
            const DeepCollectionEquality()
                .equals(other.allowCreateStream, allowCreateStream) &&
            const DeepCollectionEquality().equals(other.allowChat, allowChat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allowCreateStream),
      const DeepCollectionEquality().hash(allowChat));

  @JsonKey(ignore: true)
  @override
  _$$_UserPermissionCopyWith<_$_UserPermission> get copyWith =>
      __$$_UserPermissionCopyWithImpl<_$_UserPermission>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserPermissionToJson(this);
  }
}

abstract class _UserPermission implements UserPermission {
  factory _UserPermission(
      {@JsonKey(name: 'allow_create_stream') final bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') final bool? allowChat}) = _$_UserPermission;

  factory _UserPermission.fromJson(Map<String, dynamic> json) =
      _$_UserPermission.fromJson;

  @override
  @JsonKey(name: 'allow_create_stream')
  bool? get allowCreateStream;
  @override
  @JsonKey(name: 'allow_chat')
  bool? get allowChat;
  @override
  @JsonKey(ignore: true)
  _$$_UserPermissionCopyWith<_$_UserPermission> get copyWith =>
      throw _privateConstructorUsedError;
}
