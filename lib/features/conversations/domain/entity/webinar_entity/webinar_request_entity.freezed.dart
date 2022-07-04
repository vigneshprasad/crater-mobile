// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'webinar_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WebinarRequest _$WebinarRequestFromJson(Map<String, dynamic> json) {
  return _WebinarRequest.fromJson(json);
}

/// @nodoc
class _$WebinarRequestTearOff {
  const _$WebinarRequestTearOff();

  _WebinarRequest call(
      {String? description,
      required String start,
      required List<int> categories,
      @JsonKey(name: 'topic_title') required String title,
      @JsonKey(name: 'topic_image') required String coverImage,
      @JsonKey(name: 'rtmp_link') String? rtmpLink}) {
    return _WebinarRequest(
      description: description,
      start: start,
      categories: categories,
      title: title,
      coverImage: coverImage,
      rtmpLink: rtmpLink,
    );
  }

  WebinarRequest fromJson(Map<String, Object> json) {
    return WebinarRequest.fromJson(json);
  }
}

/// @nodoc
const $WebinarRequest = _$WebinarRequestTearOff();

/// @nodoc
mixin _$WebinarRequest {
  String? get description => throw _privateConstructorUsedError;
  String get start => throw _privateConstructorUsedError;
  List<int> get categories => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_image')
  String get coverImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'rtmp_link')
  String? get rtmpLink => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebinarRequestCopyWith<WebinarRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebinarRequestCopyWith<$Res> {
  factory $WebinarRequestCopyWith(
          WebinarRequest value, $Res Function(WebinarRequest) then) =
      _$WebinarRequestCopyWithImpl<$Res>;
  $Res call(
      {String? description,
      String start,
      List<int> categories,
      @JsonKey(name: 'topic_title') String title,
      @JsonKey(name: 'topic_image') String coverImage,
      @JsonKey(name: 'rtmp_link') String? rtmpLink});
}

/// @nodoc
class _$WebinarRequestCopyWithImpl<$Res>
    implements $WebinarRequestCopyWith<$Res> {
  _$WebinarRequestCopyWithImpl(this._value, this._then);

  final WebinarRequest _value;
  // ignore: unused_field
  final $Res Function(WebinarRequest) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? start = freezed,
    Object? categories = freezed,
    Object? title = freezed,
    Object? coverImage = freezed,
    Object? rtmpLink = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: coverImage == freezed
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      rtmpLink: rtmpLink == freezed
          ? _value.rtmpLink
          : rtmpLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$WebinarRequestCopyWith<$Res>
    implements $WebinarRequestCopyWith<$Res> {
  factory _$WebinarRequestCopyWith(
          _WebinarRequest value, $Res Function(_WebinarRequest) then) =
      __$WebinarRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? description,
      String start,
      List<int> categories,
      @JsonKey(name: 'topic_title') String title,
      @JsonKey(name: 'topic_image') String coverImage,
      @JsonKey(name: 'rtmp_link') String? rtmpLink});
}

/// @nodoc
class __$WebinarRequestCopyWithImpl<$Res>
    extends _$WebinarRequestCopyWithImpl<$Res>
    implements _$WebinarRequestCopyWith<$Res> {
  __$WebinarRequestCopyWithImpl(
      _WebinarRequest _value, $Res Function(_WebinarRequest) _then)
      : super(_value, (v) => _then(v as _WebinarRequest));

  @override
  _WebinarRequest get _value => super._value as _WebinarRequest;

  @override
  $Res call({
    Object? description = freezed,
    Object? start = freezed,
    Object? categories = freezed,
    Object? title = freezed,
    Object? coverImage = freezed,
    Object? rtmpLink = freezed,
  }) {
    return _then(_WebinarRequest(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverImage: coverImage == freezed
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String,
      rtmpLink: rtmpLink == freezed
          ? _value.rtmpLink
          : rtmpLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WebinarRequest implements _WebinarRequest {
  const _$_WebinarRequest(
      {this.description,
      required this.start,
      required this.categories,
      @JsonKey(name: 'topic_title') required this.title,
      @JsonKey(name: 'topic_image') required this.coverImage,
      @JsonKey(name: 'rtmp_link') this.rtmpLink});

  factory _$_WebinarRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_WebinarRequestFromJson(json);

  @override
  final String? description;
  @override
  final String start;
  @override
  final List<int> categories;
  @override
  @JsonKey(name: 'topic_title')
  final String title;
  @override
  @JsonKey(name: 'topic_image')
  final String coverImage;
  @override
  @JsonKey(name: 'rtmp_link')
  final String? rtmpLink;

  @override
  String toString() {
    return 'WebinarRequest(description: $description, start: $start, categories: $categories, title: $title, coverImage: $coverImage, rtmpLink: $rtmpLink)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WebinarRequest &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.coverImage, coverImage) ||
                const DeepCollectionEquality()
                    .equals(other.coverImage, coverImage)) &&
            (identical(other.rtmpLink, rtmpLink) ||
                const DeepCollectionEquality()
                    .equals(other.rtmpLink, rtmpLink)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(coverImage) ^
      const DeepCollectionEquality().hash(rtmpLink);

  @JsonKey(ignore: true)
  @override
  _$WebinarRequestCopyWith<_WebinarRequest> get copyWith =>
      __$WebinarRequestCopyWithImpl<_WebinarRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_WebinarRequestToJson(this);
  }
}

abstract class _WebinarRequest implements WebinarRequest {
  const factory _WebinarRequest(
      {String? description,
      required String start,
      required List<int> categories,
      @JsonKey(name: 'topic_title') required String title,
      @JsonKey(name: 'topic_image') required String coverImage,
      @JsonKey(name: 'rtmp_link') String? rtmpLink}) = _$_WebinarRequest;

  factory _WebinarRequest.fromJson(Map<String, dynamic> json) =
      _$_WebinarRequest.fromJson;

  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String get start => throw _privateConstructorUsedError;
  @override
  List<int> get categories => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'topic_title')
  String get title => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'topic_image')
  String get coverImage => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'rtmp_link')
  String? get rtmpLink => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WebinarRequestCopyWith<_WebinarRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
