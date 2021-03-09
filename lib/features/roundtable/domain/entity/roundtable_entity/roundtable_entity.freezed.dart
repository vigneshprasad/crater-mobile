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
      RoundTableUser host,
      List<RoundTableUser> speakers,
      Topic topic,
      String description,
      List<MeetingInterestModel> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers') int maxSpeakers,
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at') DateTime closedAt}) {
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
  RoundTableUser get host;
  List<RoundTableUser> get speakers;
  Topic get topic;
  String get description;
  List<MeetingInterestModel> get interests;
  DateTime get start;
  DateTime get end;
  @JsonKey(name: 'max_speakers')
  int get maxSpeakers;
  int get privacy;
  int get medium;
  bool get closed;
  @JsonKey(name: 'closed_at')
  DateTime get closedAt;

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
      RoundTableUser host,
      List<RoundTableUser> speakers,
      Topic topic,
      String description,
      List<MeetingInterestModel> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers') int maxSpeakers,
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at') DateTime closedAt});

  $RoundTableUserCopyWith<$Res> get host;
  $TopicCopyWith<$Res> get topic;
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
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      host: host == freezed ? _value.host : host as RoundTableUser,
      speakers: speakers == freezed
          ? _value.speakers
          : speakers as List<RoundTableUser>,
      topic: topic == freezed ? _value.topic : topic as Topic,
      description:
          description == freezed ? _value.description : description as String,
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterestModel>,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      maxSpeakers:
          maxSpeakers == freezed ? _value.maxSpeakers : maxSpeakers as int,
      privacy: privacy == freezed ? _value.privacy : privacy as int,
      medium: medium == freezed ? _value.medium : medium as int,
      closed: closed == freezed ? _value.closed : closed as bool,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
    ));
  }

  @override
  $RoundTableUserCopyWith<$Res> get host {
    if (_value.host == null) {
      return null;
    }
    return $RoundTableUserCopyWith<$Res>(_value.host, (value) {
      return _then(_value.copyWith(host: value));
    });
  }

  @override
  $TopicCopyWith<$Res> get topic {
    if (_value.topic == null) {
      return null;
    }
    return $TopicCopyWith<$Res>(_value.topic, (value) {
      return _then(_value.copyWith(topic: value));
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
      RoundTableUser host,
      List<RoundTableUser> speakers,
      Topic topic,
      String description,
      List<MeetingInterestModel> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers') int maxSpeakers,
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at') DateTime closedAt});

  @override
  $RoundTableUserCopyWith<$Res> get host;
  @override
  $TopicCopyWith<$Res> get topic;
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
  }) {
    return _then(_RoundTable(
      id: id == freezed ? _value.id : id as int,
      host: host == freezed ? _value.host : host as RoundTableUser,
      speakers: speakers == freezed
          ? _value.speakers
          : speakers as List<RoundTableUser>,
      topic: topic == freezed ? _value.topic : topic as Topic,
      description:
          description == freezed ? _value.description : description as String,
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterestModel>,
      start: start == freezed ? _value.start : start as DateTime,
      end: end == freezed ? _value.end : end as DateTime,
      maxSpeakers:
          maxSpeakers == freezed ? _value.maxSpeakers : maxSpeakers as int,
      privacy: privacy == freezed ? _value.privacy : privacy as int,
      medium: medium == freezed ? _value.medium : medium as int,
      closed: closed == freezed ? _value.closed : closed as bool,
      closedAt: closedAt == freezed ? _value.closedAt : closedAt as DateTime,
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
      @JsonKey(name: 'closed_at') this.closedAt});

  factory _$_RoundTable.fromJson(Map<String, dynamic> json) =>
      _$_$_RoundTableFromJson(json);

  @override
  final int id;
  @override
  final RoundTableUser host;
  @override
  final List<RoundTableUser> speakers;
  @override
  final Topic topic;
  @override
  final String description;
  @override
  final List<MeetingInterestModel> interests;
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
  String toString() {
    return 'RoundTable(id: $id, host: $host, speakers: $speakers, topic: $topic, description: $description, interests: $interests, start: $start, end: $end, maxSpeakers: $maxSpeakers, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt)';
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
                    .equals(other.closedAt, closedAt)));
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
      const DeepCollectionEquality().hash(closedAt);

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
      RoundTableUser host,
      List<RoundTableUser> speakers,
      Topic topic,
      String description,
      List<MeetingInterestModel> interests,
      DateTime start,
      DateTime end,
      @JsonKey(name: 'max_speakers') int maxSpeakers,
      int privacy,
      int medium,
      bool closed,
      @JsonKey(name: 'closed_at') DateTime closedAt}) = _$_RoundTable;

  factory _RoundTable.fromJson(Map<String, dynamic> json) =
      _$_RoundTable.fromJson;

  @override
  int get id;
  @override
  RoundTableUser get host;
  @override
  List<RoundTableUser> get speakers;
  @override
  Topic get topic;
  @override
  String get description;
  @override
  List<MeetingInterestModel> get interests;
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
  _RoundTableUser call({String pk, String email, String name, String photo}) {
    return _RoundTableUser(
      pk: pk,
      email: email,
      name: name,
      photo: photo,
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

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $RoundTableUserCopyWith<RoundTableUser> get copyWith;
}

/// @nodoc
abstract class $RoundTableUserCopyWith<$Res> {
  factory $RoundTableUserCopyWith(
          RoundTableUser value, $Res Function(RoundTableUser) then) =
      _$RoundTableUserCopyWithImpl<$Res>;
  $Res call({String pk, String email, String name, String photo});
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
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed ? _value.pk : pk as String,
      email: email == freezed ? _value.email : email as String,
      name: name == freezed ? _value.name : name as String,
      photo: photo == freezed ? _value.photo : photo as String,
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
  $Res call({String pk, String email, String name, String photo});
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
  }) {
    return _then(_RoundTableUser(
      pk: pk == freezed ? _value.pk : pk as String,
      email: email == freezed ? _value.email : email as String,
      name: name == freezed ? _value.name : name as String,
      photo: photo == freezed ? _value.photo : photo as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_RoundTableUser implements _RoundTableUser {
  _$_RoundTableUser({this.pk, this.email, this.name, this.photo});

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
  String toString() {
    return 'RoundTableUser(pk: $pk, email: $email, name: $name, photo: $photo)';
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
                const DeepCollectionEquality().equals(other.photo, photo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(photo);

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
      {String pk, String email, String name, String photo}) = _$_RoundTableUser;

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
  @JsonKey(ignore: true)
  _$RoundTableUserCopyWith<_RoundTableUser> get copyWith;
}
