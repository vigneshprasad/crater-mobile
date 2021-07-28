// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'optin_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Optin _$OptinFromJson(Map<String, dynamic> json) {
  return _Optin.fromJson(json);
}

/// @nodoc
class _$OptinTearOff {
  const _$OptinTearOff();

  _Optin call(
      {int? pk,
      String? user,
      int? meeting,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "number_of_meetings")
          int? numberOfMeetings,
      @JsonKey(name: "number_of_meetings_per_month")
          int? numberOfMeetingsPerMonth,
      List<int>? objectives,
      List<int>? interests,
      @JsonKey(name: "interest_list")
          List<MeetingInterestModel>? interestList,
      @JsonKey(name: "time_slots")
          List<int>? timeSlots,
      @JsonKey(name: "time_slot_list")
          List<TimeSlotModel>? timeSlotList}) {
    return _Optin(
      pk: pk,
      user: user,
      meeting: meeting,
      topic: topic,
      topicDetail: topicDetail,
      numberOfMeetings: numberOfMeetings,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth,
      objectives: objectives,
      interests: interests,
      interestList: interestList,
      timeSlots: timeSlots,
      timeSlotList: timeSlotList,
    );
  }

  Optin fromJson(Map<String, Object> json) {
    return Optin.fromJson(json);
  }
}

/// @nodoc
const $Optin = _$OptinTearOff();

/// @nodoc
mixin _$Optin {
  int? get pk => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  int? get meeting => throw _privateConstructorUsedError;
  int? get topic => throw _privateConstructorUsedError;
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @JsonKey(name: "number_of_meetings")
  int? get numberOfMeetings => throw _privateConstructorUsedError;
  @JsonKey(name: "number_of_meetings_per_month")
  int? get numberOfMeetingsPerMonth => throw _privateConstructorUsedError;
  List<int>? get objectives => throw _privateConstructorUsedError;
  List<int>? get interests => throw _privateConstructorUsedError;
  @JsonKey(name: "interest_list")
  List<MeetingInterestModel>? get interestList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "time_slots")
  List<int>? get timeSlots => throw _privateConstructorUsedError;
  @JsonKey(name: "time_slot_list")
  List<TimeSlotModel>? get timeSlotList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptinCopyWith<Optin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptinCopyWith<$Res> {
  factory $OptinCopyWith(Optin value, $Res Function(Optin) then) =
      _$OptinCopyWithImpl<$Res>;
  $Res call(
      {int? pk,
      String? user,
      int? meeting,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "number_of_meetings")
          int? numberOfMeetings,
      @JsonKey(name: "number_of_meetings_per_month")
          int? numberOfMeetingsPerMonth,
      List<int>? objectives,
      List<int>? interests,
      @JsonKey(name: "interest_list")
          List<MeetingInterestModel>? interestList,
      @JsonKey(name: "time_slots")
          List<int>? timeSlots,
      @JsonKey(name: "time_slot_list")
          List<TimeSlotModel>? timeSlotList});

  $TopicCopyWith<$Res>? get topicDetail;
}

/// @nodoc
class _$OptinCopyWithImpl<$Res> implements $OptinCopyWith<$Res> {
  _$OptinCopyWithImpl(this._value, this._then);

  final Optin _value;
  // ignore: unused_field
  final $Res Function(Optin) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? user = freezed,
    Object? meeting = freezed,
    Object? topic = freezed,
    Object? topicDetail = freezed,
    Object? numberOfMeetings = freezed,
    Object? numberOfMeetingsPerMonth = freezed,
    Object? objectives = freezed,
    Object? interests = freezed,
    Object? interestList = freezed,
    Object? timeSlots = freezed,
    Object? timeSlotList = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      meeting: meeting == freezed
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as int?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      numberOfMeetings: numberOfMeetings == freezed
          ? _value.numberOfMeetings
          : numberOfMeetings // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth == freezed
          ? _value.numberOfMeetingsPerMonth
          : numberOfMeetingsPerMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      objectives: objectives == freezed
          ? _value.objectives
          : objectives // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      interests: interests == freezed
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      interestList: interestList == freezed
          ? _value.interestList
          : interestList // ignore: cast_nullable_to_non_nullable
              as List<MeetingInterestModel>?,
      timeSlots: timeSlots == freezed
          ? _value.timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      timeSlotList: timeSlotList == freezed
          ? _value.timeSlotList
          : timeSlotList // ignore: cast_nullable_to_non_nullable
              as List<TimeSlotModel>?,
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
}

/// @nodoc
abstract class _$OptinCopyWith<$Res> implements $OptinCopyWith<$Res> {
  factory _$OptinCopyWith(_Optin value, $Res Function(_Optin) then) =
      __$OptinCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk,
      String? user,
      int? meeting,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "number_of_meetings")
          int? numberOfMeetings,
      @JsonKey(name: "number_of_meetings_per_month")
          int? numberOfMeetingsPerMonth,
      List<int>? objectives,
      List<int>? interests,
      @JsonKey(name: "interest_list")
          List<MeetingInterestModel>? interestList,
      @JsonKey(name: "time_slots")
          List<int>? timeSlots,
      @JsonKey(name: "time_slot_list")
          List<TimeSlotModel>? timeSlotList});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
}

/// @nodoc
class __$OptinCopyWithImpl<$Res> extends _$OptinCopyWithImpl<$Res>
    implements _$OptinCopyWith<$Res> {
  __$OptinCopyWithImpl(_Optin _value, $Res Function(_Optin) _then)
      : super(_value, (v) => _then(v as _Optin));

  @override
  _Optin get _value => super._value as _Optin;

  @override
  $Res call({
    Object? pk = freezed,
    Object? user = freezed,
    Object? meeting = freezed,
    Object? topic = freezed,
    Object? topicDetail = freezed,
    Object? numberOfMeetings = freezed,
    Object? numberOfMeetingsPerMonth = freezed,
    Object? objectives = freezed,
    Object? interests = freezed,
    Object? interestList = freezed,
    Object? timeSlots = freezed,
    Object? timeSlotList = freezed,
  }) {
    return _then(_Optin(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      meeting: meeting == freezed
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as int?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      numberOfMeetings: numberOfMeetings == freezed
          ? _value.numberOfMeetings
          : numberOfMeetings // ignore: cast_nullable_to_non_nullable
              as int?,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth == freezed
          ? _value.numberOfMeetingsPerMonth
          : numberOfMeetingsPerMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      objectives: objectives == freezed
          ? _value.objectives
          : objectives // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      interests: interests == freezed
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      interestList: interestList == freezed
          ? _value.interestList
          : interestList // ignore: cast_nullable_to_non_nullable
              as List<MeetingInterestModel>?,
      timeSlots: timeSlots == freezed
          ? _value.timeSlots
          : timeSlots // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      timeSlotList: timeSlotList == freezed
          ? _value.timeSlotList
          : timeSlotList // ignore: cast_nullable_to_non_nullable
              as List<TimeSlotModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Optin implements _Optin {
  _$_Optin(
      {this.pk,
      this.user,
      this.meeting,
      this.topic,
      @JsonKey(name: "topic_detail")
          this.topicDetail,
      @JsonKey(name: "number_of_meetings")
          this.numberOfMeetings,
      @JsonKey(name: "number_of_meetings_per_month")
          this.numberOfMeetingsPerMonth,
      this.objectives,
      this.interests,
      @JsonKey(name: "interest_list")
          this.interestList,
      @JsonKey(name: "time_slots")
          this.timeSlots,
      @JsonKey(name: "time_slot_list")
          this.timeSlotList});

  factory _$_Optin.fromJson(Map<String, dynamic> json) =>
      _$_$_OptinFromJson(json);

  @override
  final int? pk;
  @override
  final String? user;
  @override
  final int? meeting;
  @override
  final int? topic;
  @override
  @JsonKey(name: "topic_detail")
  final Topic? topicDetail;
  @override
  @JsonKey(name: "number_of_meetings")
  final int? numberOfMeetings;
  @override
  @JsonKey(name: "number_of_meetings_per_month")
  final int? numberOfMeetingsPerMonth;
  @override
  final List<int>? objectives;
  @override
  final List<int>? interests;
  @override
  @JsonKey(name: "interest_list")
  final List<MeetingInterestModel>? interestList;
  @override
  @JsonKey(name: "time_slots")
  final List<int>? timeSlots;
  @override
  @JsonKey(name: "time_slot_list")
  final List<TimeSlotModel>? timeSlotList;

  @override
  String toString() {
    return 'Optin(pk: $pk, user: $user, meeting: $meeting, topic: $topic, topicDetail: $topicDetail, numberOfMeetings: $numberOfMeetings, numberOfMeetingsPerMonth: $numberOfMeetingsPerMonth, objectives: $objectives, interests: $interests, interestList: $interestList, timeSlots: $timeSlots, timeSlotList: $timeSlotList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Optin &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.meeting, meeting) ||
                const DeepCollectionEquality()
                    .equals(other.meeting, meeting)) &&
            (identical(other.topic, topic) ||
                const DeepCollectionEquality().equals(other.topic, topic)) &&
            (identical(other.topicDetail, topicDetail) ||
                const DeepCollectionEquality()
                    .equals(other.topicDetail, topicDetail)) &&
            (identical(other.numberOfMeetings, numberOfMeetings) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfMeetings, numberOfMeetings)) &&
            (identical(
                    other.numberOfMeetingsPerMonth, numberOfMeetingsPerMonth) ||
                const DeepCollectionEquality().equals(
                    other.numberOfMeetingsPerMonth,
                    numberOfMeetingsPerMonth)) &&
            (identical(other.objectives, objectives) ||
                const DeepCollectionEquality()
                    .equals(other.objectives, objectives)) &&
            (identical(other.interests, interests) ||
                const DeepCollectionEquality()
                    .equals(other.interests, interests)) &&
            (identical(other.interestList, interestList) ||
                const DeepCollectionEquality()
                    .equals(other.interestList, interestList)) &&
            (identical(other.timeSlots, timeSlots) ||
                const DeepCollectionEquality()
                    .equals(other.timeSlots, timeSlots)) &&
            (identical(other.timeSlotList, timeSlotList) ||
                const DeepCollectionEquality()
                    .equals(other.timeSlotList, timeSlotList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(meeting) ^
      const DeepCollectionEquality().hash(topic) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(numberOfMeetings) ^
      const DeepCollectionEquality().hash(numberOfMeetingsPerMonth) ^
      const DeepCollectionEquality().hash(objectives) ^
      const DeepCollectionEquality().hash(interests) ^
      const DeepCollectionEquality().hash(interestList) ^
      const DeepCollectionEquality().hash(timeSlots) ^
      const DeepCollectionEquality().hash(timeSlotList);

  @JsonKey(ignore: true)
  @override
  _$OptinCopyWith<_Optin> get copyWith =>
      __$OptinCopyWithImpl<_Optin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OptinToJson(this);
  }
}

abstract class _Optin implements Optin {
  factory _Optin(
      {int? pk,
      String? user,
      int? meeting,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "number_of_meetings")
          int? numberOfMeetings,
      @JsonKey(name: "number_of_meetings_per_month")
          int? numberOfMeetingsPerMonth,
      List<int>? objectives,
      List<int>? interests,
      @JsonKey(name: "interest_list")
          List<MeetingInterestModel>? interestList,
      @JsonKey(name: "time_slots")
          List<int>? timeSlots,
      @JsonKey(name: "time_slot_list")
          List<TimeSlotModel>? timeSlotList}) = _$_Optin;

  factory _Optin.fromJson(Map<String, dynamic> json) = _$_Optin.fromJson;

  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  String? get user => throw _privateConstructorUsedError;
  @override
  int? get meeting => throw _privateConstructorUsedError;
  @override
  int? get topic => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "number_of_meetings")
  int? get numberOfMeetings => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "number_of_meetings_per_month")
  int? get numberOfMeetingsPerMonth => throw _privateConstructorUsedError;
  @override
  List<int>? get objectives => throw _privateConstructorUsedError;
  @override
  List<int>? get interests => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "interest_list")
  List<MeetingInterestModel>? get interestList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "time_slots")
  List<int>? get timeSlots => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "time_slot_list")
  List<TimeSlotModel>? get timeSlotList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OptinCopyWith<_Optin> get copyWith => throw _privateConstructorUsedError;
}

OptinsByDate _$OptinsByDateFromJson(Map<String, dynamic> json) {
  return _OptinsByDate.fromJson(json);
}

/// @nodoc
class _$OptinsByDateTearOff {
  const _$OptinsByDateTearOff();

  _OptinsByDate call({DateTime? date, List<Optin>? optins}) {
    return _OptinsByDate(
      date: date,
      optins: optins,
    );
  }

  OptinsByDate fromJson(Map<String, Object> json) {
    return OptinsByDate.fromJson(json);
  }
}

/// @nodoc
const $OptinsByDate = _$OptinsByDateTearOff();

/// @nodoc
mixin _$OptinsByDate {
  DateTime? get date => throw _privateConstructorUsedError;
  List<Optin>? get optins => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OptinsByDateCopyWith<OptinsByDate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptinsByDateCopyWith<$Res> {
  factory $OptinsByDateCopyWith(
          OptinsByDate value, $Res Function(OptinsByDate) then) =
      _$OptinsByDateCopyWithImpl<$Res>;
  $Res call({DateTime? date, List<Optin>? optins});
}

/// @nodoc
class _$OptinsByDateCopyWithImpl<$Res> implements $OptinsByDateCopyWith<$Res> {
  _$OptinsByDateCopyWithImpl(this._value, this._then);

  final OptinsByDate _value;
  // ignore: unused_field
  final $Res Function(OptinsByDate) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? optins = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      optins: optins == freezed
          ? _value.optins
          : optins // ignore: cast_nullable_to_non_nullable
              as List<Optin>?,
    ));
  }
}

/// @nodoc
abstract class _$OptinsByDateCopyWith<$Res>
    implements $OptinsByDateCopyWith<$Res> {
  factory _$OptinsByDateCopyWith(
          _OptinsByDate value, $Res Function(_OptinsByDate) then) =
      __$OptinsByDateCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? date, List<Optin>? optins});
}

/// @nodoc
class __$OptinsByDateCopyWithImpl<$Res> extends _$OptinsByDateCopyWithImpl<$Res>
    implements _$OptinsByDateCopyWith<$Res> {
  __$OptinsByDateCopyWithImpl(
      _OptinsByDate _value, $Res Function(_OptinsByDate) _then)
      : super(_value, (v) => _then(v as _OptinsByDate));

  @override
  _OptinsByDate get _value => super._value as _OptinsByDate;

  @override
  $Res call({
    Object? date = freezed,
    Object? optins = freezed,
  }) {
    return _then(_OptinsByDate(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      optins: optins == freezed
          ? _value.optins
          : optins // ignore: cast_nullable_to_non_nullable
              as List<Optin>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OptinsByDate implements _OptinsByDate {
  _$_OptinsByDate({this.date, this.optins});

  factory _$_OptinsByDate.fromJson(Map<String, dynamic> json) =>
      _$_$_OptinsByDateFromJson(json);

  @override
  final DateTime? date;
  @override
  final List<Optin>? optins;

  @override
  String toString() {
    return 'OptinsByDate(date: $date, optins: $optins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _OptinsByDate &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.optins, optins) ||
                const DeepCollectionEquality().equals(other.optins, optins)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(optins);

  @JsonKey(ignore: true)
  @override
  _$OptinsByDateCopyWith<_OptinsByDate> get copyWith =>
      __$OptinsByDateCopyWithImpl<_OptinsByDate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_OptinsByDateToJson(this);
  }
}

abstract class _OptinsByDate implements OptinsByDate {
  factory _OptinsByDate({DateTime? date, List<Optin>? optins}) =
      _$_OptinsByDate;

  factory _OptinsByDate.fromJson(Map<String, dynamic> json) =
      _$_OptinsByDate.fromJson;

  @override
  DateTime? get date => throw _privateConstructorUsedError;
  @override
  List<Optin>? get optins => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$OptinsByDateCopyWith<_OptinsByDate> get copyWith =>
      throw _privateConstructorUsedError;
}
