// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return _Profile.fromJson(json);
}

/// @nodoc
mixin _$Profile {
  int? get pk => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_introduction')
  String? get generatedIntroduction => throw _privateConstructorUsedError;
  @JsonKey(name: "tag_list")
  List<Tag>? get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "linkedin_url")
  String? get linkedIn => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: "allow_meeting_request")
  bool? get allowMeetingRequest => throw _privateConstructorUsedError;
  @JsonKey(name: "can_connect")
  bool? get canConnect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res>;
  $Res call(
      {int? pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo,
      @JsonKey(name: "allow_meeting_request") bool? allowMeetingRequest,
      @JsonKey(name: "can_connect") bool? canConnect});
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res> implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  final Profile _value;
  // ignore: unused_field
  final $Res Function(Profile) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? introduction = freezed,
    Object? generatedIntroduction = freezed,
    Object? tag = freezed,
    Object? linkedIn = freezed,
    Object? photo = freezed,
    Object? allowMeetingRequest = freezed,
    Object? canConnect = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedIntroduction: generatedIntroduction == freezed
          ? _value.generatedIntroduction
          : generatedIntroduction // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      linkedIn: linkedIn == freezed
          ? _value.linkedIn
          : linkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMeetingRequest: allowMeetingRequest == freezed
          ? _value.allowMeetingRequest
          : allowMeetingRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      canConnect: canConnect == freezed
          ? _value.canConnect
          : canConnect // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$_ProfileCopyWith(
          _$_Profile value, $Res Function(_$_Profile) then) =
      __$$_ProfileCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk,
      String? uuid,
      String? name,
      String? introduction,
      @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
      @JsonKey(name: "tag_list") List<Tag>? tag,
      @JsonKey(name: "linkedin_url") String? linkedIn,
      String? photo,
      @JsonKey(name: "allow_meeting_request") bool? allowMeetingRequest,
      @JsonKey(name: "can_connect") bool? canConnect});
}

/// @nodoc
class __$$_ProfileCopyWithImpl<$Res> extends _$ProfileCopyWithImpl<$Res>
    implements _$$_ProfileCopyWith<$Res> {
  __$$_ProfileCopyWithImpl(_$_Profile _value, $Res Function(_$_Profile) _then)
      : super(_value, (v) => _then(v as _$_Profile));

  @override
  _$_Profile get _value => super._value as _$_Profile;

  @override
  $Res call({
    Object? pk = freezed,
    Object? uuid = freezed,
    Object? name = freezed,
    Object? introduction = freezed,
    Object? generatedIntroduction = freezed,
    Object? tag = freezed,
    Object? linkedIn = freezed,
    Object? photo = freezed,
    Object? allowMeetingRequest = freezed,
    Object? canConnect = freezed,
  }) {
    return _then(_$_Profile(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      generatedIntroduction: generatedIntroduction == freezed
          ? _value.generatedIntroduction
          : generatedIntroduction // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: tag == freezed
          ? _value._tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
      linkedIn: linkedIn == freezed
          ? _value.linkedIn
          : linkedIn // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      allowMeetingRequest: allowMeetingRequest == freezed
          ? _value.allowMeetingRequest
          : allowMeetingRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      canConnect: canConnect == freezed
          ? _value.canConnect
          : canConnect // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Profile implements _Profile {
  _$_Profile(
      {this.pk,
      this.uuid,
      this.name,
      this.introduction,
      @JsonKey(name: 'generated_introduction') this.generatedIntroduction,
      @JsonKey(name: "tag_list") final List<Tag>? tag,
      @JsonKey(name: "linkedin_url") this.linkedIn,
      this.photo,
      @JsonKey(name: "allow_meeting_request") this.allowMeetingRequest,
      @JsonKey(name: "can_connect") this.canConnect})
      : _tag = tag;

  factory _$_Profile.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileFromJson(json);

  @override
  final int? pk;
  @override
  final String? uuid;
  @override
  final String? name;
  @override
  final String? introduction;
  @override
  @JsonKey(name: 'generated_introduction')
  final String? generatedIntroduction;
  final List<Tag>? _tag;
  @override
  @JsonKey(name: "tag_list")
  List<Tag>? get tag {
    final value = _tag;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "linkedin_url")
  final String? linkedIn;
  @override
  final String? photo;
  @override
  @JsonKey(name: "allow_meeting_request")
  final bool? allowMeetingRequest;
  @override
  @JsonKey(name: "can_connect")
  final bool? canConnect;

  @override
  String toString() {
    return 'Profile(pk: $pk, uuid: $uuid, name: $name, introduction: $introduction, generatedIntroduction: $generatedIntroduction, tag: $tag, linkedIn: $linkedIn, photo: $photo, allowMeetingRequest: $allowMeetingRequest, canConnect: $canConnect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Profile &&
            const DeepCollectionEquality().equals(other.pk, pk) &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.introduction, introduction) &&
            const DeepCollectionEquality()
                .equals(other.generatedIntroduction, generatedIntroduction) &&
            const DeepCollectionEquality().equals(other._tag, _tag) &&
            const DeepCollectionEquality().equals(other.linkedIn, linkedIn) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality()
                .equals(other.allowMeetingRequest, allowMeetingRequest) &&
            const DeepCollectionEquality()
                .equals(other.canConnect, canConnect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pk),
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(introduction),
      const DeepCollectionEquality().hash(generatedIntroduction),
      const DeepCollectionEquality().hash(_tag),
      const DeepCollectionEquality().hash(linkedIn),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(allowMeetingRequest),
      const DeepCollectionEquality().hash(canConnect));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      __$$_ProfileCopyWithImpl<_$_Profile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileToJson(this);
  }
}

abstract class _Profile implements Profile {
  factory _Profile(
      {final int? pk,
      final String? uuid,
      final String? name,
      final String? introduction,
      @JsonKey(name: 'generated_introduction')
          final String? generatedIntroduction,
      @JsonKey(name: "tag_list")
          final List<Tag>? tag,
      @JsonKey(name: "linkedin_url")
          final String? linkedIn,
      final String? photo,
      @JsonKey(name: "allow_meeting_request")
          final bool? allowMeetingRequest,
      @JsonKey(name: "can_connect")
          final bool? canConnect}) = _$_Profile;

  factory _Profile.fromJson(Map<String, dynamic> json) = _$_Profile.fromJson;

  @override
  int? get pk;
  @override
  String? get uuid;
  @override
  String? get name;
  @override
  String? get introduction;
  @override
  @JsonKey(name: 'generated_introduction')
  String? get generatedIntroduction;
  @override
  @JsonKey(name: "tag_list")
  List<Tag>? get tag;
  @override
  @JsonKey(name: "linkedin_url")
  String? get linkedIn;
  @override
  String? get photo;
  @override
  @JsonKey(name: "allow_meeting_request")
  bool? get allowMeetingRequest;
  @override
  @JsonKey(name: "can_connect")
  bool? get canConnect;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileCopyWith<_$_Profile> get copyWith =>
      throw _privateConstructorUsedError;
}
