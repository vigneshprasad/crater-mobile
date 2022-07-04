// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
class _$ConversationTearOff {
  const _$ConversationTearOff();

  _Conversation call(
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
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel>? interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          bool? isSpeaker,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails}) {
    return _Conversation(
      id: id,
      host: host,
      speakers: speakers,
      attendees: attendees,
      topic: topic,
      description: description,
      interests: interests,
      start: start,
      end: end,
      maxSpeakers: maxSpeakers,
      privacy: privacy,
      medium: medium,
      closed: closed,
      relevancy: relevancy,
      closedAt: closedAt,
      topicDetail: topicDetail,
      hostDetail: hostDetail,
      interestsDetailList: interestsDetailList,
      speakersDetailList: speakersDetailList,
      attendeesDetailList: attendeesDetailList,
      isSpeaker: isSpeaker,
      isPast: isPast,
      recordingDetails: recordingDetails,
    );
  }

  Conversation fromJson(Map<String, Object> json) {
    return Conversation.fromJson(json);
  }
}

/// @nodoc
const $Conversation = _$ConversationTearOff();

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
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel>? get interestsDetailList =>
      throw _privateConstructorUsedError;
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
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel>? interestsDetailList,
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
    Object? interestsDetailList = freezed,
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
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList // ignore: cast_nullable_to_non_nullable
              as List<MeetingInterestModel>?,
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
abstract class _$ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(
          _Conversation value, $Res Function(_Conversation) then) =
      __$ConversationCopyWithImpl<$Res>;
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
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel>? interestsDetailList,
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
class __$ConversationCopyWithImpl<$Res> extends _$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(
      _Conversation _value, $Res Function(_Conversation) _then)
      : super(_value, (v) => _then(v as _Conversation));

  @override
  _Conversation get _value => super._value as _Conversation;

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
    Object? interestsDetailList = freezed,
    Object? speakersDetailList = freezed,
    Object? attendeesDetailList = freezed,
    Object? isSpeaker = freezed,
    Object? isPast = freezed,
    Object? recordingDetails = freezed,
  }) {
    return _then(_Conversation(
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
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList // ignore: cast_nullable_to_non_nullable
              as List<MeetingInterestModel>?,
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
}

/// @nodoc
@JsonSerializable()
class _$_Conversation implements _Conversation {
  _$_Conversation(
      {this.id,
      this.host,
      this.speakers,
      this.attendees,
      this.topic,
      this.description,
      this.interests,
      this.start,
      this.end,
      @JsonKey(name: 'max_speakers') this.maxSpeakers,
      this.privacy,
      this.medium,
      this.closed,
      this.relevancy,
      @JsonKey(name: 'closed_at') this.closedAt,
      @JsonKey(name: 'topic_detail') this.topicDetail,
      @JsonKey(name: 'host_detail') this.hostDetail,
      @JsonKey(name: 'interests_detail_list') this.interestsDetailList,
      @JsonKey(name: 'speakers_detail_list') this.speakersDetailList,
      @JsonKey(name: 'attendees_detail_list') this.attendeesDetailList,
      @JsonKey(name: 'is_speaker') this.isSpeaker,
      @JsonKey(name: 'is_past') this.isPast,
      @JsonKey(name: 'recording_details') this.recordingDetails});

  factory _$_Conversation.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationFromJson(json);

  @override
  final int? id;
  @override
  final String? host;
  @override
  final List<String>? speakers;
  @override
  final List<String>? attendees;
  @override
  final int? topic;
  @override
  final String? description;
  @override
  final List<int>? interests;
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
  @override
  @JsonKey(name: 'interests_detail_list')
  final List<MeetingInterestModel>? interestsDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  final List<ConversationUser>? speakersDetailList;
  @override
  @JsonKey(name: 'attendees_detail_list')
  final List<ConversationUser>? attendeesDetailList;
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
    return 'Conversation(id: $id, host: $host, speakers: $speakers, attendees: $attendees, topic: $topic, description: $description, interests: $interests, start: $start, end: $end, maxSpeakers: $maxSpeakers, privacy: $privacy, medium: $medium, closed: $closed, relevancy: $relevancy, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, interestsDetailList: $interestsDetailList, speakersDetailList: $speakersDetailList, attendeesDetailList: $attendeesDetailList, isSpeaker: $isSpeaker, isPast: $isPast, recordingDetails: $recordingDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Conversation &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.host, host) ||
                const DeepCollectionEquality().equals(other.host, host)) &&
            (identical(other.speakers, speakers) ||
                const DeepCollectionEquality()
                    .equals(other.speakers, speakers)) &&
            (identical(other.attendees, attendees) ||
                const DeepCollectionEquality()
                    .equals(other.attendees, attendees)) &&
            (identical(other.topic, topic) ||
                const DeepCollectionEquality().equals(other.topic, topic)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.interests, interests) ||
                const DeepCollectionEquality()
                    .equals(other.interests, interests)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)) &&
            (identical(other.maxSpeakers, maxSpeakers) ||
                const DeepCollectionEquality()
                    .equals(other.maxSpeakers, maxSpeakers)) &&
            (identical(other.privacy, privacy) ||
                const DeepCollectionEquality()
                    .equals(other.privacy, privacy)) &&
            (identical(other.medium, medium) ||
                const DeepCollectionEquality().equals(other.medium, medium)) &&
            (identical(other.closed, closed) ||
                const DeepCollectionEquality().equals(other.closed, closed)) &&
            (identical(other.relevancy, relevancy) ||
                const DeepCollectionEquality()
                    .equals(other.relevancy, relevancy)) &&
            (identical(other.closedAt, closedAt) ||
                const DeepCollectionEquality()
                    .equals(other.closedAt, closedAt)) &&
            (identical(other.topicDetail, topicDetail) ||
                const DeepCollectionEquality()
                    .equals(other.topicDetail, topicDetail)) &&
            (identical(other.hostDetail, hostDetail) ||
                const DeepCollectionEquality()
                    .equals(other.hostDetail, hostDetail)) &&
            (identical(other.interestsDetailList, interestsDetailList) ||
                const DeepCollectionEquality()
                    .equals(other.interestsDetailList, interestsDetailList)) &&
            (identical(other.speakersDetailList, speakersDetailList) ||
                const DeepCollectionEquality()
                    .equals(other.speakersDetailList, speakersDetailList)) &&
            (identical(other.attendeesDetailList, attendeesDetailList) ||
                const DeepCollectionEquality()
                    .equals(other.attendeesDetailList, attendeesDetailList)) &&
            (identical(other.isSpeaker, isSpeaker) ||
                const DeepCollectionEquality()
                    .equals(other.isSpeaker, isSpeaker)) &&
            (identical(other.isPast, isPast) ||
                const DeepCollectionEquality().equals(other.isPast, isPast)) &&
            (identical(other.recordingDetails, recordingDetails) ||
                const DeepCollectionEquality()
                    .equals(other.recordingDetails, recordingDetails)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(host) ^
      const DeepCollectionEquality().hash(speakers) ^
      const DeepCollectionEquality().hash(attendees) ^
      const DeepCollectionEquality().hash(topic) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(interests) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      const DeepCollectionEquality().hash(maxSpeakers) ^
      const DeepCollectionEquality().hash(privacy) ^
      const DeepCollectionEquality().hash(medium) ^
      const DeepCollectionEquality().hash(closed) ^
      const DeepCollectionEquality().hash(relevancy) ^
      const DeepCollectionEquality().hash(closedAt) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(hostDetail) ^
      const DeepCollectionEquality().hash(interestsDetailList) ^
      const DeepCollectionEquality().hash(speakersDetailList) ^
      const DeepCollectionEquality().hash(attendeesDetailList) ^
      const DeepCollectionEquality().hash(isSpeaker) ^
      const DeepCollectionEquality().hash(isPast) ^
      const DeepCollectionEquality().hash(recordingDetails);

  @JsonKey(ignore: true)
  @override
  _$ConversationCopyWith<_Conversation> get copyWith =>
      __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationToJson(this);
  }
}

abstract class _Conversation implements Conversation {
  factory _Conversation(
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
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel>? interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser>? speakersDetailList,
      @JsonKey(name: 'attendees_detail_list')
          List<ConversationUser>? attendeesDetailList,
      @JsonKey(name: 'is_speaker')
          bool? isSpeaker,
      @JsonKey(name: 'is_past')
          bool? isPast,
      @JsonKey(name: 'recording_details')
          RecordingDetails? recordingDetails}) = _$_Conversation;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$_Conversation.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String? get host => throw _privateConstructorUsedError;
  @override
  List<String>? get speakers => throw _privateConstructorUsedError;
  @override
  List<String>? get attendees => throw _privateConstructorUsedError;
  @override
  int? get topic => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  List<int>? get interests => throw _privateConstructorUsedError;
  @override
  DateTime? get start => throw _privateConstructorUsedError;
  @override
  DateTime? get end => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'max_speakers')
  int? get maxSpeakers => throw _privateConstructorUsedError;
  @override
  ConversationPrivacy? get privacy => throw _privateConstructorUsedError;
  @override
  ConversationMedium? get medium => throw _privateConstructorUsedError;
  @override
  bool? get closed => throw _privateConstructorUsedError;
  @override
  int? get relevancy => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'topic_detail')
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'host_detail')
  ConversationUser? get hostDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel>? get interestsDetailList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser>? get speakersDetailList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'attendees_detail_list')
  List<ConversationUser>? get attendeesDetailList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_speaker')
  bool? get isSpeaker => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_past')
  bool? get isPast => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'recording_details')
  RecordingDetails? get recordingDetails => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConversationCopyWith<_Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordingDetails _$RecordingDetailsFromJson(Map<String, dynamic> json) {
  return _RecordingDetails.fromJson(json);
}

/// @nodoc
class _$RecordingDetailsTearOff {
  const _$RecordingDetailsTearOff();

  _RecordingDetails call({String? recording}) {
    return _RecordingDetails(
      recording: recording,
    );
  }

  RecordingDetails fromJson(Map<String, Object> json) {
    return RecordingDetails.fromJson(json);
  }
}

/// @nodoc
const $RecordingDetails = _$RecordingDetailsTearOff();

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
abstract class _$RecordingDetailsCopyWith<$Res>
    implements $RecordingDetailsCopyWith<$Res> {
  factory _$RecordingDetailsCopyWith(
          _RecordingDetails value, $Res Function(_RecordingDetails) then) =
      __$RecordingDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String? recording});
}

/// @nodoc
class __$RecordingDetailsCopyWithImpl<$Res>
    extends _$RecordingDetailsCopyWithImpl<$Res>
    implements _$RecordingDetailsCopyWith<$Res> {
  __$RecordingDetailsCopyWithImpl(
      _RecordingDetails _value, $Res Function(_RecordingDetails) _then)
      : super(_value, (v) => _then(v as _RecordingDetails));

  @override
  _RecordingDetails get _value => super._value as _RecordingDetails;

  @override
  $Res call({
    Object? recording = freezed,
  }) {
    return _then(_RecordingDetails(
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
      _$_$_RecordingDetailsFromJson(json);

  @override
  final String? recording;

  @override
  String toString() {
    return 'RecordingDetails(recording: $recording)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RecordingDetails &&
            (identical(other.recording, recording) ||
                const DeepCollectionEquality()
                    .equals(other.recording, recording)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(recording);

  @JsonKey(ignore: true)
  @override
  _$RecordingDetailsCopyWith<_RecordingDetails> get copyWith =>
      __$RecordingDetailsCopyWithImpl<_RecordingDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RecordingDetailsToJson(this);
  }
}

abstract class _RecordingDetails implements RecordingDetails {
  factory _RecordingDetails({String? recording}) = _$_RecordingDetails;

  factory _RecordingDetails.fromJson(Map<String, dynamic> json) =
      _$_RecordingDetails.fromJson;

  @override
  String? get recording => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecordingDetailsCopyWith<_RecordingDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationUser _$ConversationUserFromJson(Map<String, dynamic> json) {
  return _ConversationUser.fromJson(json);
}

/// @nodoc
class _$ConversationUserTearOff {
  const _$ConversationUserTearOff();

  _ConversationUser call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: 'creator_detail') Creator? creatorDetail}) {
    return _ConversationUser(
      pk: pk,
      email: email,
      name: name,
      photo: photo,
      introduction: introduction,
      creatorDetail: creatorDetail,
    );
  }

  ConversationUser fromJson(Map<String, Object> json) {
    return ConversationUser.fromJson(json);
  }
}

/// @nodoc
const $ConversationUser = _$ConversationUserTearOff();

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
abstract class _$ConversationUserCopyWith<$Res>
    implements $ConversationUserCopyWith<$Res> {
  factory _$ConversationUserCopyWith(
          _ConversationUser value, $Res Function(_ConversationUser) then) =
      __$ConversationUserCopyWithImpl<$Res>;
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
class __$ConversationUserCopyWithImpl<$Res>
    extends _$ConversationUserCopyWithImpl<$Res>
    implements _$ConversationUserCopyWith<$Res> {
  __$ConversationUserCopyWithImpl(
      _ConversationUser _value, $Res Function(_ConversationUser) _then)
      : super(_value, (v) => _then(v as _ConversationUser));

  @override
  _ConversationUser get _value => super._value as _ConversationUser;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_ConversationUser(
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
      _$_$_ConversationUserFromJson(json);

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
        (other is _ConversationUser &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)) &&
            (identical(other.introduction, introduction) ||
                const DeepCollectionEquality()
                    .equals(other.introduction, introduction)) &&
            (identical(other.creatorDetail, creatorDetail) ||
                const DeepCollectionEquality()
                    .equals(other.creatorDetail, creatorDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(introduction) ^
      const DeepCollectionEquality().hash(creatorDetail);

  @JsonKey(ignore: true)
  @override
  _$ConversationUserCopyWith<_ConversationUser> get copyWith =>
      __$ConversationUserCopyWithImpl<_ConversationUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationUserToJson(this);
  }
}

abstract class _ConversationUser implements ConversationUser {
  factory _ConversationUser(
          {String? pk,
          String? email,
          String? name,
          String? photo,
          String? introduction,
          @JsonKey(name: 'creator_detail') Creator? creatorDetail}) =
      _$_ConversationUser;

  factory _ConversationUser.fromJson(Map<String, dynamic> json) =
      _$_ConversationUser.fromJson;

  @override
  String? get pk => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get photo => throw _privateConstructorUsedError;
  @override
  String? get introduction => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'creator_detail')
  Creator? get creatorDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConversationUserCopyWith<_ConversationUser> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationByDate _$ConversationByDateFromJson(Map<String, dynamic> json) {
  return _ConversationByDate.fromJson(json);
}

/// @nodoc
class _$ConversationByDateTearOff {
  const _$ConversationByDateTearOff();

  _ConversationByDate call(
      {DateTime? date, List<Conversation>? conversations}) {
    return _ConversationByDate(
      date: date,
      conversations: conversations,
    );
  }

  ConversationByDate fromJson(Map<String, Object> json) {
    return ConversationByDate.fromJson(json);
  }
}

/// @nodoc
const $ConversationByDate = _$ConversationByDateTearOff();

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
abstract class _$ConversationByDateCopyWith<$Res>
    implements $ConversationByDateCopyWith<$Res> {
  factory _$ConversationByDateCopyWith(
          _ConversationByDate value, $Res Function(_ConversationByDate) then) =
      __$ConversationByDateCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? date, List<Conversation>? conversations});
}

/// @nodoc
class __$ConversationByDateCopyWithImpl<$Res>
    extends _$ConversationByDateCopyWithImpl<$Res>
    implements _$ConversationByDateCopyWith<$Res> {
  __$ConversationByDateCopyWithImpl(
      _ConversationByDate _value, $Res Function(_ConversationByDate) _then)
      : super(_value, (v) => _then(v as _ConversationByDate));

  @override
  _ConversationByDate get _value => super._value as _ConversationByDate;

  @override
  $Res call({
    Object? date = freezed,
    Object? conversations = freezed,
  }) {
    return _then(_ConversationByDate(
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
@JsonSerializable()
class _$_ConversationByDate implements _ConversationByDate {
  _$_ConversationByDate({this.date, this.conversations});

  factory _$_ConversationByDate.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationByDateFromJson(json);

  @override
  final DateTime? date;
  @override
  final List<Conversation>? conversations;

  @override
  String toString() {
    return 'ConversationByDate(date: $date, conversations: $conversations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConversationByDate &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.conversations, conversations) ||
                const DeepCollectionEquality()
                    .equals(other.conversations, conversations)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(conversations);

  @JsonKey(ignore: true)
  @override
  _$ConversationByDateCopyWith<_ConversationByDate> get copyWith =>
      __$ConversationByDateCopyWithImpl<_ConversationByDate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConversationByDateToJson(this);
  }
}

abstract class _ConversationByDate implements ConversationByDate {
  factory _ConversationByDate(
      {DateTime? date,
      List<Conversation>? conversations}) = _$_ConversationByDate;

  factory _ConversationByDate.fromJson(Map<String, dynamic> json) =
      _$_ConversationByDate.fromJson;

  @override
  DateTime? get date => throw _privateConstructorUsedError;
  @override
  List<Conversation>? get conversations => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ConversationByDateCopyWith<_ConversationByDate> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) {
  return _UserPermission.fromJson(json);
}

/// @nodoc
class _$UserPermissionTearOff {
  const _$UserPermissionTearOff();

  _UserPermission call(
      {@JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') bool? allowChat}) {
    return _UserPermission(
      allowCreateStream: allowCreateStream,
      allowChat: allowChat,
    );
  }

  UserPermission fromJson(Map<String, Object> json) {
    return UserPermission.fromJson(json);
  }
}

/// @nodoc
const $UserPermission = _$UserPermissionTearOff();

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
abstract class _$UserPermissionCopyWith<$Res>
    implements $UserPermissionCopyWith<$Res> {
  factory _$UserPermissionCopyWith(
          _UserPermission value, $Res Function(_UserPermission) then) =
      __$UserPermissionCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') bool? allowChat});
}

/// @nodoc
class __$UserPermissionCopyWithImpl<$Res>
    extends _$UserPermissionCopyWithImpl<$Res>
    implements _$UserPermissionCopyWith<$Res> {
  __$UserPermissionCopyWithImpl(
      _UserPermission _value, $Res Function(_UserPermission) _then)
      : super(_value, (v) => _then(v as _UserPermission));

  @override
  _UserPermission get _value => super._value as _UserPermission;

  @override
  $Res call({
    Object? allowCreateStream = freezed,
    Object? allowChat = freezed,
  }) {
    return _then(_UserPermission(
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
      _$_$_UserPermissionFromJson(json);

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
        (other is _UserPermission &&
            (identical(other.allowCreateStream, allowCreateStream) ||
                const DeepCollectionEquality()
                    .equals(other.allowCreateStream, allowCreateStream)) &&
            (identical(other.allowChat, allowChat) ||
                const DeepCollectionEquality()
                    .equals(other.allowChat, allowChat)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(allowCreateStream) ^
      const DeepCollectionEquality().hash(allowChat);

  @JsonKey(ignore: true)
  @override
  _$UserPermissionCopyWith<_UserPermission> get copyWith =>
      __$UserPermissionCopyWithImpl<_UserPermission>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserPermissionToJson(this);
  }
}

abstract class _UserPermission implements UserPermission {
  factory _UserPermission(
      {@JsonKey(name: 'allow_create_stream') bool? allowCreateStream,
      @JsonKey(name: 'allow_chat') bool? allowChat}) = _$_UserPermission;

  factory _UserPermission.fromJson(Map<String, dynamic> json) =
      _$_UserPermission.fromJson;

  @override
  @JsonKey(name: 'allow_create_stream')
  bool? get allowCreateStream => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'allow_chat')
  bool? get allowChat => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserPermissionCopyWith<_UserPermission> get copyWith =>
      throw _privateConstructorUsedError;
}
