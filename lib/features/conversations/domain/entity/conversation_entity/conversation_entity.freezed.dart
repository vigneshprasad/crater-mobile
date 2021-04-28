// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
class _$ConversationTearOff {
  const _$ConversationTearOff();

// ignore: unused_element
  _Conversation call(
      {int id,
      String host,
      List<String> speakers,
      int topic,
      String description,
      List<int> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers')
          int maxSpeakers,
      ConversationPrivacy privacy,
      ConversationMedium medium,
      bool closed,
      int relevancy,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker,
      @JsonKey(name: 'is_past')
          bool isPast}) {
    return _Conversation(
      id: id,
      host: host,
      speakers: speakers,
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
      isSpeaker: isSpeaker,
      isPast: isPast,
    );
  }

// ignore: unused_element
  Conversation fromJson(Map<String, Object> json) {
    return Conversation.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Conversation = _$ConversationTearOff();

/// @nodoc
mixin _$Conversation {
  int get id;
  String get host;
  List<String> get speakers;
  int get topic;
  String get description;
  List<int> get interests;
  DateTime get start;
  DateTime get end;
  @JsonKey(name: 'max_speakers')
  int get maxSpeakers;
  ConversationPrivacy get privacy;
  ConversationMedium get medium;
  bool get closed;
  int get relevancy;
  @JsonKey(name: 'closed_at')
  DateTime get closedAt;
  @JsonKey(name: 'topic_detail')
  Topic get topicDetail;
  @JsonKey(name: 'host_detail')
  ConversationUser get hostDetail;
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel> get interestsDetailList;
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser> get speakersDetailList;
  @JsonKey(name: 'is_speaker')
  bool get isSpeaker;
  @JsonKey(name: 'is_past')
  bool get isPast;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String host,
      List<String> speakers,
      int topic,
      String description,
      List<int> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers')
          int maxSpeakers,
      ConversationPrivacy privacy,
      ConversationMedium medium,
      bool closed,
      int relevancy,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker,
      @JsonKey(name: 'is_past')
          bool isPast});

  $TopicCopyWith<$Res> get topicDetail;
  $ConversationUserCopyWith<$Res> get hostDetail;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  final Conversation _value;
  // ignore: unused_field
  final $Res Function(Conversation) _then;

  @override
  $Res call({
    Object id = freezed,
    Object host = freezed,
    Object speakers = freezed,
    Object topic = freezed,
    Object description = freezed,
    Object interests = freezed,
    Object start = freezed,
    Object end = freezed,
    Object maxSpeakers = freezed,
    Object privacy = freezed,
    Object medium = freezed,
    Object closed = freezed,
    Object relevancy = freezed,
    Object closedAt = freezed,
    Object topicDetail = freezed,
    Object hostDetail = freezed,
    Object interestsDetailList = freezed,
    Object speakersDetailList = freezed,
    Object isSpeaker = freezed,
    Object isPast = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      host: host == freezed ? _value.host : host as String,
      speakers:
          speakers == freezed ? _value.speakers : speakers as List<String>,
      topic: topic == freezed ? _value.topic : topic as int,
      description:
          description == freezed ? _value.description : description as String,
      interests:
          interests == freezed ? _value.interests : interests as List<int>,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      maxSpeakers:
          maxSpeakers == freezed ? _value.maxSpeakers : maxSpeakers as int,
      privacy:
          privacy == freezed ? _value.privacy : privacy as ConversationPrivacy,
      medium: medium == freezed ? _value.medium : medium as ConversationMedium,
      closed: closed == freezed ? _value.closed : closed as bool,
      relevancy: relevancy == freezed ? _value.relevancy : relevancy as int,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
      topicDetail:
          topicDetail == freezed ? _value.topicDetail : topicDetail as Topic,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail as ConversationUser,
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList as List<MeetingInterestModel>,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList as List<ConversationUser>,
      isSpeaker: isSpeaker == freezed ? _value.isSpeaker : isSpeaker as bool,
      isPast: isPast == freezed ? _value.isPast : isPast as bool,
    ));
  }

  @override
  $TopicCopyWith<$Res> get topicDetail {
    if (_value.topicDetail == null) {
      return null;
    }
    return $TopicCopyWith<$Res>(_value.topicDetail, (value) {
      return _then(_value.copyWith(topicDetail: value));
    });
  }

  @override
  $ConversationUserCopyWith<$Res> get hostDetail {
    if (_value.hostDetail == null) {
      return null;
    }
    return $ConversationUserCopyWith<$Res>(_value.hostDetail, (value) {
      return _then(_value.copyWith(hostDetail: value));
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
      {int id,
      String host,
      List<String> speakers,
      int topic,
      String description,
      List<int> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers')
          int maxSpeakers,
      ConversationPrivacy privacy,
      ConversationMedium medium,
      bool closed,
      int relevancy,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker,
      @JsonKey(name: 'is_past')
          bool isPast});

  @override
  $TopicCopyWith<$Res> get topicDetail;
  @override
  $ConversationUserCopyWith<$Res> get hostDetail;
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
    Object id = freezed,
    Object host = freezed,
    Object speakers = freezed,
    Object topic = freezed,
    Object description = freezed,
    Object interests = freezed,
    Object start = freezed,
    Object end = freezed,
    Object maxSpeakers = freezed,
    Object privacy = freezed,
    Object medium = freezed,
    Object closed = freezed,
    Object relevancy = freezed,
    Object closedAt = freezed,
    Object topicDetail = freezed,
    Object hostDetail = freezed,
    Object interestsDetailList = freezed,
    Object speakersDetailList = freezed,
    Object isSpeaker = freezed,
    Object isPast = freezed,
  }) {
    return _then(_Conversation(
      id: id == freezed ? _value.id : id as int,
      host: host == freezed ? _value.host : host as String,
      speakers:
          speakers == freezed ? _value.speakers : speakers as List<String>,
      topic: topic == freezed ? _value.topic : topic as int,
      description:
          description == freezed ? _value.description : description as String,
      interests:
          interests == freezed ? _value.interests : interests as List<int>,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      maxSpeakers:
          maxSpeakers == freezed ? _value.maxSpeakers : maxSpeakers as int,
      privacy:
          privacy == freezed ? _value.privacy : privacy as ConversationPrivacy,
      medium: medium == freezed ? _value.medium : medium as ConversationMedium,
      closed: closed == freezed ? _value.closed : closed as bool,
      relevancy: relevancy == freezed ? _value.relevancy : relevancy as int,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
      topicDetail:
          topicDetail == freezed ? _value.topicDetail : topicDetail as Topic,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail as ConversationUser,
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList as List<MeetingInterestModel>,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList as List<ConversationUser>,
      isSpeaker: isSpeaker == freezed ? _value.isSpeaker : isSpeaker as bool,
      isPast: isPast == freezed ? _value.isPast : isPast as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Conversation implements _Conversation {
  _$_Conversation(
      {this.id,
      this.host,
      this.speakers,
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
      @JsonKey(name: 'is_speaker') this.isSpeaker,
      @JsonKey(name: 'is_past') this.isPast});

  factory _$_Conversation.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationFromJson(json);

  @override
  final int id;
  @override
  final String host;
  @override
  final List<String> speakers;
  @override
  final int topic;
  @override
  final String description;
  @override
  final List<int> interests;
  @override
  final DateTime start;
  @override
  final DateTime end;
  @override
  @JsonKey(name: 'max_speakers')
  final int maxSpeakers;
  @override
  final ConversationPrivacy privacy;
  @override
  final ConversationMedium medium;
  @override
  final bool closed;
  @override
  final int relevancy;
  @override
  @JsonKey(name: 'closed_at')
  final DateTime closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  final Topic topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  final ConversationUser hostDetail;
  @override
  @JsonKey(name: 'interests_detail_list')
  final List<MeetingInterestModel> interestsDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  final List<ConversationUser> speakersDetailList;
  @override
  @JsonKey(name: 'is_speaker')
  final bool isSpeaker;
  @override
  @JsonKey(name: 'is_past')
  final bool isPast;

  @override
  String toString() {
    return 'Conversation(id: $id, host: $host, speakers: $speakers, topic: $topic, description: $description, interests: $interests, start: $start, end: $end, maxSpeakers: $maxSpeakers, privacy: $privacy, medium: $medium, closed: $closed, relevancy: $relevancy, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, interestsDetailList: $interestsDetailList, speakersDetailList: $speakersDetailList, isSpeaker: $isSpeaker, isPast: $isPast)';
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
            (identical(other.isSpeaker, isSpeaker) ||
                const DeepCollectionEquality()
                    .equals(other.isSpeaker, isSpeaker)) &&
            (identical(other.isPast, isPast) ||
                const DeepCollectionEquality().equals(other.isPast, isPast)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(host) ^
      const DeepCollectionEquality().hash(speakers) ^
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
      const DeepCollectionEquality().hash(isSpeaker) ^
      const DeepCollectionEquality().hash(isPast);

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
      {int id,
      String host,
      List<String> speakers,
      int topic,
      String description,
      List<int> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers')
          int maxSpeakers,
      ConversationPrivacy privacy,
      ConversationMedium medium,
      bool closed,
      int relevancy,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          ConversationUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<ConversationUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker,
      @JsonKey(name: 'is_past')
          bool isPast}) = _$_Conversation;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$_Conversation.fromJson;

  @override
  int get id;
  @override
  String get host;
  @override
  List<String> get speakers;
  @override
  int get topic;
  @override
  String get description;
  @override
  List<int> get interests;
  @override
  DateTime get start;
  @override
  DateTime get end;
  @override
  @JsonKey(name: 'max_speakers')
  int get maxSpeakers;
  @override
  ConversationPrivacy get privacy;
  @override
  ConversationMedium get medium;
  @override
  bool get closed;
  @override
  int get relevancy;
  @override
  @JsonKey(name: 'closed_at')
  DateTime get closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  Topic get topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  ConversationUser get hostDetail;
  @override
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel> get interestsDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<ConversationUser> get speakersDetailList;
  @override
  @JsonKey(name: 'is_speaker')
  bool get isSpeaker;
  @override
  @JsonKey(name: 'is_past')
  bool get isPast;
  @override
  @JsonKey(ignore: true)
  _$ConversationCopyWith<_Conversation> get copyWith;
}

ConversationUser _$ConversationUserFromJson(Map<String, dynamic> json) {
  return _ConversationUser.fromJson(json);
}

/// @nodoc
class _$ConversationUserTearOff {
  const _$ConversationUserTearOff();

// ignore: unused_element
  _ConversationUser call(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction}) {
    return _ConversationUser(
      pk: pk,
      email: email,
      name: name,
      photo: photo,
      introduction: introduction,
    );
  }

// ignore: unused_element
  ConversationUser fromJson(Map<String, Object> json) {
    return ConversationUser.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ConversationUser = _$ConversationUserTearOff();

/// @nodoc
mixin _$ConversationUser {
  String get pk;
  String get email;
  String get name;
  String get photo;
  String get introduction;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ConversationUserCopyWith<ConversationUser> get copyWith;
}

/// @nodoc
abstract class $ConversationUserCopyWith<$Res> {
  factory $ConversationUserCopyWith(
          ConversationUser value, $Res Function(ConversationUser) then) =
      _$ConversationUserCopyWithImpl<$Res>;
  $Res call(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction});
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
    Object pk = freezed,
    Object email = freezed,
    Object name = freezed,
    Object photo = freezed,
    Object introduction = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed ? _value.pk : pk as String,
      email: email == freezed ? _value.email : email as String,
      name: name == freezed ? _value.name : name as String,
      photo: photo == freezed ? _value.photo : photo as String,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction as String,
    ));
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
      {String pk,
      String email,
      String name,
      String photo,
      String introduction});
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
    Object pk = freezed,
    Object email = freezed,
    Object name = freezed,
    Object photo = freezed,
    Object introduction = freezed,
  }) {
    return _then(_ConversationUser(
      pk: pk == freezed ? _value.pk : pk as String,
      email: email == freezed ? _value.email : email as String,
      name: name == freezed ? _value.name : name as String,
      photo: photo == freezed ? _value.photo : photo as String,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ConversationUser implements _ConversationUser {
  _$_ConversationUser(
      {this.pk, this.email, this.name, this.photo, this.introduction});

  factory _$_ConversationUser.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationUserFromJson(json);

  @override
  final String pk;
  @override
  final String email;
  @override
  final String name;
  @override
  final String photo;
  @override
  final String introduction;

  @override
  String toString() {
    return 'ConversationUser(pk: $pk, email: $email, name: $name, photo: $photo, introduction: $introduction)';
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
                    .equals(other.introduction, introduction)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(introduction);

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
      {String pk,
      String email,
      String name,
      String photo,
      String introduction}) = _$_ConversationUser;

  factory _ConversationUser.fromJson(Map<String, dynamic> json) =
      _$_ConversationUser.fromJson;

  @override
  String get pk;
  @override
  String get email;
  @override
  String get name;
  @override
  String get photo;
  @override
  String get introduction;
  @override
  @JsonKey(ignore: true)
  _$ConversationUserCopyWith<_ConversationUser> get copyWith;
}

ConversationByDate _$ConversationByDateFromJson(Map<String, dynamic> json) {
  return _ConversationByDate.fromJson(json);
}

/// @nodoc
class _$ConversationByDateTearOff {
  const _$ConversationByDateTearOff();

// ignore: unused_element
  _ConversationByDate call({DateTime date, List<Conversation> conversations}) {
    return _ConversationByDate(
      date: date,
      conversations: conversations,
    );
  }

// ignore: unused_element
  ConversationByDate fromJson(Map<String, Object> json) {
    return ConversationByDate.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ConversationByDate = _$ConversationByDateTearOff();

/// @nodoc
mixin _$ConversationByDate {
  DateTime get date;
  List<Conversation> get conversations;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $ConversationByDateCopyWith<ConversationByDate> get copyWith;
}

/// @nodoc
abstract class $ConversationByDateCopyWith<$Res> {
  factory $ConversationByDateCopyWith(
          ConversationByDate value, $Res Function(ConversationByDate) then) =
      _$ConversationByDateCopyWithImpl<$Res>;
  $Res call({DateTime date, List<Conversation> conversations});
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
    Object date = freezed,
    Object conversations = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed ? _value.date : date as DateTime,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations as List<Conversation>,
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
  $Res call({DateTime date, List<Conversation> conversations});
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
    Object date = freezed,
    Object conversations = freezed,
  }) {
    return _then(_ConversationByDate(
      date: date == freezed ? _value.date : date as DateTime,
      conversations: conversations == freezed
          ? _value.conversations
          : conversations as List<Conversation>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ConversationByDate implements _ConversationByDate {
  _$_ConversationByDate({this.date, this.conversations});

  factory _$_ConversationByDate.fromJson(Map<String, dynamic> json) =>
      _$_$_ConversationByDateFromJson(json);

  @override
  final DateTime date;
  @override
  final List<Conversation> conversations;

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
      {DateTime date,
      List<Conversation> conversations}) = _$_ConversationByDate;

  factory _ConversationByDate.fromJson(Map<String, dynamic> json) =
      _$_ConversationByDate.fromJson;

  @override
  DateTime get date;
  @override
  List<Conversation> get conversations;
  @override
  @JsonKey(ignore: true)
  _$ConversationByDateCopyWith<_ConversationByDate> get copyWith;
}
