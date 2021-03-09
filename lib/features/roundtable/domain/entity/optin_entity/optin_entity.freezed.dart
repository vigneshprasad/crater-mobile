// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'optin_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Optin _$OptinFromJson(Map<String, dynamic> json) {
  return _Optin.fromJson(json);
}

/// @nodoc
class _$OptinTearOff {
  const _$OptinTearOff();

// ignore: unused_element
  _Optin call(
      {int pk,
      String user,
      int meeting,
      @JsonKey(name: 'number_of_meetings')
          int numberOfMeetings,
      @JsonKey(name: 'number_of_meetings_per_month')
          int numberOfMeetingsPerMonth,
      List<MeetingObjectiveModel> objectives,
      List<MeetingInterestModel> interests,
      @JsonKey(name: 'time_slots')
          List<TimeSlotModel> timeSlots}) {
    return _Optin(
      pk: pk,
      user: user,
      meeting: meeting,
      numberOfMeetings: numberOfMeetings,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth,
      objectives: objectives,
      interests: interests,
      timeSlots: timeSlots,
    );
  }

// ignore: unused_element
  Optin fromJson(Map<String, Object> json) {
    return Optin.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Optin = _$OptinTearOff();

/// @nodoc
mixin _$Optin {
  int get pk;
  String get user;
  int get meeting;
  @JsonKey(name: 'number_of_meetings')
  int get numberOfMeetings;
  @JsonKey(name: 'number_of_meetings_per_month')
  int get numberOfMeetingsPerMonth;
  List<MeetingObjectiveModel> get objectives;
  List<MeetingInterestModel> get interests;
  @JsonKey(name: 'time_slots')
  List<TimeSlotModel> get timeSlots;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $OptinCopyWith<Optin> get copyWith;
}

/// @nodoc
abstract class $OptinCopyWith<$Res> {
  factory $OptinCopyWith(Optin value, $Res Function(Optin) then) =
      _$OptinCopyWithImpl<$Res>;
  $Res call(
      {int pk,
      String user,
      int meeting,
      @JsonKey(name: 'number_of_meetings')
          int numberOfMeetings,
      @JsonKey(name: 'number_of_meetings_per_month')
          int numberOfMeetingsPerMonth,
      List<MeetingObjectiveModel> objectives,
      List<MeetingInterestModel> interests,
      @JsonKey(name: 'time_slots')
          List<TimeSlotModel> timeSlots});
}

/// @nodoc
class _$OptinCopyWithImpl<$Res> implements $OptinCopyWith<$Res> {
  _$OptinCopyWithImpl(this._value, this._then);

  final Optin _value;
  // ignore: unused_field
  final $Res Function(Optin) _then;

  @override
  $Res call({
    Object pk = freezed,
    Object user = freezed,
    Object meeting = freezed,
    Object numberOfMeetings = freezed,
    Object numberOfMeetingsPerMonth = freezed,
    Object objectives = freezed,
    Object interests = freezed,
    Object timeSlots = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed ? _value.pk : pk as int,
      user: user == freezed ? _value.user : user as String,
      meeting: meeting == freezed ? _value.meeting : meeting as int,
      numberOfMeetings: numberOfMeetings == freezed
          ? _value.numberOfMeetings
          : numberOfMeetings as int,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth == freezed
          ? _value.numberOfMeetingsPerMonth
          : numberOfMeetingsPerMonth as int,
      objectives: objectives == freezed
          ? _value.objectives
          : objectives as List<MeetingObjectiveModel>,
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterestModel>,
      timeSlots: timeSlots == freezed
          ? _value.timeSlots
          : timeSlots as List<TimeSlotModel>,
    ));
  }
}

/// @nodoc
abstract class _$OptinCopyWith<$Res> implements $OptinCopyWith<$Res> {
  factory _$OptinCopyWith(_Optin value, $Res Function(_Optin) then) =
      __$OptinCopyWithImpl<$Res>;
  @override
  $Res call(
      {int pk,
      String user,
      int meeting,
      @JsonKey(name: 'number_of_meetings')
          int numberOfMeetings,
      @JsonKey(name: 'number_of_meetings_per_month')
          int numberOfMeetingsPerMonth,
      List<MeetingObjectiveModel> objectives,
      List<MeetingInterestModel> interests,
      @JsonKey(name: 'time_slots')
          List<TimeSlotModel> timeSlots});
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
    Object pk = freezed,
    Object user = freezed,
    Object meeting = freezed,
    Object numberOfMeetings = freezed,
    Object numberOfMeetingsPerMonth = freezed,
    Object objectives = freezed,
    Object interests = freezed,
    Object timeSlots = freezed,
  }) {
    return _then(_Optin(
      pk: pk == freezed ? _value.pk : pk as int,
      user: user == freezed ? _value.user : user as String,
      meeting: meeting == freezed ? _value.meeting : meeting as int,
      numberOfMeetings: numberOfMeetings == freezed
          ? _value.numberOfMeetings
          : numberOfMeetings as int,
      numberOfMeetingsPerMonth: numberOfMeetingsPerMonth == freezed
          ? _value.numberOfMeetingsPerMonth
          : numberOfMeetingsPerMonth as int,
      objectives: objectives == freezed
          ? _value.objectives
          : objectives as List<MeetingObjectiveModel>,
      interests: interests == freezed
          ? _value.interests
          : interests as List<MeetingInterestModel>,
      timeSlots: timeSlots == freezed
          ? _value.timeSlots
          : timeSlots as List<TimeSlotModel>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Optin implements _Optin {
  _$_Optin(
      {this.pk,
      this.user,
      this.meeting,
      @JsonKey(name: 'number_of_meetings')
          this.numberOfMeetings,
      @JsonKey(name: 'number_of_meetings_per_month')
          this.numberOfMeetingsPerMonth,
      this.objectives,
      this.interests,
      @JsonKey(name: 'time_slots')
          this.timeSlots});

  factory _$_Optin.fromJson(Map<String, dynamic> json) =>
      _$_$_OptinFromJson(json);

  @override
  final int pk;
  @override
  final String user;
  @override
  final int meeting;
  @override
  @JsonKey(name: 'number_of_meetings')
  final int numberOfMeetings;
  @override
  @JsonKey(name: 'number_of_meetings_per_month')
  final int numberOfMeetingsPerMonth;
  @override
  final List<MeetingObjectiveModel> objectives;
  @override
  final List<MeetingInterestModel> interests;
  @override
  @JsonKey(name: 'time_slots')
  final List<TimeSlotModel> timeSlots;

  @override
  String toString() {
    return 'Optin(pk: $pk, user: $user, meeting: $meeting, numberOfMeetings: $numberOfMeetings, numberOfMeetingsPerMonth: $numberOfMeetingsPerMonth, objectives: $objectives, interests: $interests, timeSlots: $timeSlots)';
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
            (identical(other.timeSlots, timeSlots) ||
                const DeepCollectionEquality()
                    .equals(other.timeSlots, timeSlots)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(meeting) ^
      const DeepCollectionEquality().hash(numberOfMeetings) ^
      const DeepCollectionEquality().hash(numberOfMeetingsPerMonth) ^
      const DeepCollectionEquality().hash(objectives) ^
      const DeepCollectionEquality().hash(interests) ^
      const DeepCollectionEquality().hash(timeSlots);

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
      {int pk,
      String user,
      int meeting,
      @JsonKey(name: 'number_of_meetings')
          int numberOfMeetings,
      @JsonKey(name: 'number_of_meetings_per_month')
          int numberOfMeetingsPerMonth,
      List<MeetingObjectiveModel> objectives,
      List<MeetingInterestModel> interests,
      @JsonKey(name: 'time_slots')
          List<TimeSlotModel> timeSlots}) = _$_Optin;

  factory _Optin.fromJson(Map<String, dynamic> json) = _$_Optin.fromJson;

  @override
  int get pk;
  @override
  String get user;
  @override
  int get meeting;
  @override
  @JsonKey(name: 'number_of_meetings')
  int get numberOfMeetings;
  @override
  @JsonKey(name: 'number_of_meetings_per_month')
  int get numberOfMeetingsPerMonth;
  @override
  List<MeetingObjectiveModel> get objectives;
  @override
  List<MeetingInterestModel> get interests;
  @override
  @JsonKey(name: 'time_slots')
  List<TimeSlotModel> get timeSlots;
  @override
  @JsonKey(ignore: true)
  _$OptinCopyWith<_Optin> get copyWith;
}
