// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'roundtable_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RoundTable _$RoundTableFromJson(Map<String, dynamic> json) {
  return _RoundTable.fromJson(json);
}

/// @nodoc
class _$RoundTableTearOff {
  const _$RoundTableTearOff();

// ignore: unused_element
  _RoundTable call(
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
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          RoundTableUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<RoundTableUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker}) {
    return _RoundTable(
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
      closedAt: closedAt,
      topicDetail: topicDetail,
      hostDetail: hostDetail,
      interestsDetailList: interestsDetailList,
      speakersDetailList: speakersDetailList,
      isSpeaker: isSpeaker,
    );
  }

// ignore: unused_element
  RoundTable fromJson(Map<String, Object> json) {
    return RoundTable.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RoundTable = _$RoundTableTearOff();

/// @nodoc
mixin _$RoundTable {
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
  int get privacy;
  int get medium;
  bool get closed;
  @JsonKey(name: 'closed_at')
  DateTime get closedAt;
  @JsonKey(name: 'topic_detail')
  Topic get topicDetail;
  @JsonKey(name: 'host_detail')
  RoundTableUser get hostDetail;
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel> get interestsDetailList;
  @JsonKey(name: 'speakers_detail_list')
  List<RoundTableUser> get speakersDetailList;
  @JsonKey(name: 'is_speaker')
  bool get isSpeaker;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundTableCopyWith<RoundTable> get copyWith;
}

/// @nodoc
abstract class $RoundTableCopyWith<$Res> {
  factory $RoundTableCopyWith(
          RoundTable value, $Res Function(RoundTable) then) =
      _$RoundTableCopyWithImpl<$Res>;
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
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          RoundTableUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<RoundTableUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker});

  $TopicCopyWith<$Res> get topicDetail;
  $RoundTableUserCopyWith<$Res> get hostDetail;
}

/// @nodoc
class _$RoundTableCopyWithImpl<$Res> implements $RoundTableCopyWith<$Res> {
  _$RoundTableCopyWithImpl(this._value, this._then);

  final RoundTable _value;
  // ignore: unused_field
  final $Res Function(RoundTable) _then;

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
    Object closedAt = freezed,
    Object topicDetail = freezed,
    Object hostDetail = freezed,
    Object interestsDetailList = freezed,
    Object speakersDetailList = freezed,
    Object isSpeaker = freezed,
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
      privacy: privacy == freezed ? _value.privacy : privacy as int,
      medium: medium == freezed ? _value.medium : medium as int,
      closed: closed == freezed ? _value.closed : closed as bool,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
      topicDetail:
          topicDetail == freezed ? _value.topicDetail : topicDetail as Topic,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail as RoundTableUser,
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList as List<MeetingInterestModel>,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList as List<RoundTableUser>,
      isSpeaker: isSpeaker == freezed ? _value.isSpeaker : isSpeaker as bool,
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
  $RoundTableUserCopyWith<$Res> get hostDetail {
    if (_value.hostDetail == null) {
      return null;
    }
    return $RoundTableUserCopyWith<$Res>(_value.hostDetail, (value) {
      return _then(_value.copyWith(hostDetail: value));
    });
  }
}

/// @nodoc
abstract class _$RoundTableCopyWith<$Res> implements $RoundTableCopyWith<$Res> {
  factory _$RoundTableCopyWith(
          _RoundTable value, $Res Function(_RoundTable) then) =
      __$RoundTableCopyWithImpl<$Res>;
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
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          RoundTableUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<RoundTableUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker});

  @override
  $TopicCopyWith<$Res> get topicDetail;
  @override
  $RoundTableUserCopyWith<$Res> get hostDetail;
}

/// @nodoc
class __$RoundTableCopyWithImpl<$Res> extends _$RoundTableCopyWithImpl<$Res>
    implements _$RoundTableCopyWith<$Res> {
  __$RoundTableCopyWithImpl(
      _RoundTable _value, $Res Function(_RoundTable) _then)
      : super(_value, (v) => _then(v as _RoundTable));

  @override
  _RoundTable get _value => super._value as _RoundTable;

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
    Object closedAt = freezed,
    Object topicDetail = freezed,
    Object hostDetail = freezed,
    Object interestsDetailList = freezed,
    Object speakersDetailList = freezed,
    Object isSpeaker = freezed,
  }) {
    return _then(_RoundTable(
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
      privacy: privacy == freezed ? _value.privacy : privacy as int,
      medium: medium == freezed ? _value.medium : medium as int,
      closed: closed == freezed ? _value.closed : closed as bool,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
      topicDetail:
          topicDetail == freezed ? _value.topicDetail : topicDetail as Topic,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail as RoundTableUser,
      interestsDetailList: interestsDetailList == freezed
          ? _value.interestsDetailList
          : interestsDetailList as List<MeetingInterestModel>,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList as List<RoundTableUser>,
      isSpeaker: isSpeaker == freezed ? _value.isSpeaker : isSpeaker as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_RoundTable implements _RoundTable {
  _$_RoundTable(
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
      @JsonKey(name: 'closed_at') this.closedAt,
      @JsonKey(name: 'topic_detail') this.topicDetail,
      @JsonKey(name: 'host_detail') this.hostDetail,
      @JsonKey(name: 'interests_detail_list') this.interestsDetailList,
      @JsonKey(name: 'speakers_detail_list') this.speakersDetailList,
      @JsonKey(name: 'is_speaker') this.isSpeaker});

  factory _$_RoundTable.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundTableFromJson(json);

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
  final int privacy;
  @override
  final int medium;
  @override
  final bool closed;
  @override
  @JsonKey(name: 'closed_at')
  final DateTime closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  final Topic topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  final RoundTableUser hostDetail;
  @override
  @JsonKey(name: 'interests_detail_list')
  final List<MeetingInterestModel> interestsDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  final List<RoundTableUser> speakersDetailList;
  @override
  @JsonKey(name: 'is_speaker')
  final bool isSpeaker;

  @override
  String toString() {
    return 'RoundTable(id: $id, host: $host, speakers: $speakers, topic: $topic, description: $description, interests: $interests, start: $start, end: $end, maxSpeakers: $maxSpeakers, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, interestsDetailList: $interestsDetailList, speakersDetailList: $speakersDetailList, isSpeaker: $isSpeaker)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundTable &&
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
                    .equals(other.isSpeaker, isSpeaker)));
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
      const DeepCollectionEquality().hash(closedAt) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(hostDetail) ^
      const DeepCollectionEquality().hash(interestsDetailList) ^
      const DeepCollectionEquality().hash(speakersDetailList) ^
      const DeepCollectionEquality().hash(isSpeaker);

  @JsonKey(ignore: true)
  @override
  _$RoundTableCopyWith<_RoundTable> get copyWith =>
      __$RoundTableCopyWithImpl<_RoundTable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoundTableToJson(this);
  }
}

abstract class _RoundTable implements RoundTable {
  factory _RoundTable(
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
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at')
          DateTime closedAt,
      @JsonKey(name: 'topic_detail')
          Topic topicDetail,
      @JsonKey(name: 'host_detail')
          RoundTableUser hostDetail,
      @JsonKey(name: 'interests_detail_list')
          List<MeetingInterestModel> interestsDetailList,
      @JsonKey(name: 'speakers_detail_list')
          List<RoundTableUser> speakersDetailList,
      @JsonKey(name: 'is_speaker')
          bool isSpeaker}) = _$_RoundTable;

  factory _RoundTable.fromJson(Map<String, dynamic> json) =
      _$_RoundTable.fromJson;

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
  int get privacy;
  @override
  int get medium;
  @override
  bool get closed;
  @override
  @JsonKey(name: 'closed_at')
  DateTime get closedAt;
  @override
  @JsonKey(name: 'topic_detail')
  Topic get topicDetail;
  @override
  @JsonKey(name: 'host_detail')
  RoundTableUser get hostDetail;
  @override
  @JsonKey(name: 'interests_detail_list')
  List<MeetingInterestModel> get interestsDetailList;
  @override
  @JsonKey(name: 'speakers_detail_list')
  List<RoundTableUser> get speakersDetailList;
  @override
  @JsonKey(name: 'is_speaker')
  bool get isSpeaker;
  @override
  @JsonKey(ignore: true)
  _$RoundTableCopyWith<_RoundTable> get copyWith;
}

RoundTableUser _$RoundTableUserFromJson(Map<String, dynamic> json) {
  return _RoundTableUser.fromJson(json);
}

/// @nodoc
class _$RoundTableUserTearOff {
  const _$RoundTableUserTearOff();

// ignore: unused_element
  _RoundTableUser call(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction}) {
    return _RoundTableUser(
      pk: pk,
      email: email,
      name: name,
      photo: photo,
      introduction: introduction,
    );
  }

// ignore: unused_element
  RoundTableUser fromJson(Map<String, Object> json) {
    return RoundTableUser.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RoundTableUser = _$RoundTableUserTearOff();

/// @nodoc
mixin _$RoundTableUser {
  String get pk;
  String get email;
  String get name;
  String get photo;
  String get introduction;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundTableUserCopyWith<RoundTableUser> get copyWith;
}

/// @nodoc
abstract class $RoundTableUserCopyWith<$Res> {
  factory $RoundTableUserCopyWith(
          RoundTableUser value, $Res Function(RoundTableUser) then) =
      _$RoundTableUserCopyWithImpl<$Res>;
  $Res call(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction});
}

/// @nodoc
class _$RoundTableUserCopyWithImpl<$Res>
    implements $RoundTableUserCopyWith<$Res> {
  _$RoundTableUserCopyWithImpl(this._value, this._then);

  final RoundTableUser _value;
  // ignore: unused_field
  final $Res Function(RoundTableUser) _then;

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
abstract class _$RoundTableUserCopyWith<$Res>
    implements $RoundTableUserCopyWith<$Res> {
  factory _$RoundTableUserCopyWith(
          _RoundTableUser value, $Res Function(_RoundTableUser) then) =
      __$RoundTableUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction});
}

/// @nodoc
class __$RoundTableUserCopyWithImpl<$Res>
    extends _$RoundTableUserCopyWithImpl<$Res>
    implements _$RoundTableUserCopyWith<$Res> {
  __$RoundTableUserCopyWithImpl(
      _RoundTableUser _value, $Res Function(_RoundTableUser) _then)
      : super(_value, (v) => _then(v as _RoundTableUser));

  @override
  _RoundTableUser get _value => super._value as _RoundTableUser;

  @override
  $Res call({
    Object pk = freezed,
    Object email = freezed,
    Object name = freezed,
    Object photo = freezed,
    Object introduction = freezed,
  }) {
    return _then(_RoundTableUser(
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
class _$_RoundTableUser implements _RoundTableUser {
  _$_RoundTableUser(
      {this.pk, this.email, this.name, this.photo, this.introduction});

  factory _$_RoundTableUser.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundTableUserFromJson(json);

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
    return 'RoundTableUser(pk: $pk, email: $email, name: $name, photo: $photo, introduction: $introduction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RoundTableUser &&
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
  _$RoundTableUserCopyWith<_RoundTableUser> get copyWith =>
      __$RoundTableUserCopyWithImpl<_RoundTableUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RoundTableUserToJson(this);
  }
}

abstract class _RoundTableUser implements RoundTableUser {
  factory _RoundTableUser(
      {String pk,
      String email,
      String name,
      String photo,
      String introduction}) = _$_RoundTableUser;

  factory _RoundTableUser.fromJson(Map<String, dynamic> json) =
      _$_RoundTableUser.fromJson;

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
  _$RoundTableUserCopyWith<_RoundTableUser> get copyWith;
}
