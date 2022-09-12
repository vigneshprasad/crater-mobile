// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'webinar_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WebinarRequest _$WebinarRequestFromJson(Map<String, dynamic> json) {
  return _WebinarRequest.fromJson(json);
}

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
abstract class _$$_WebinarRequestCopyWith<$Res>
    implements $WebinarRequestCopyWith<$Res> {
  factory _$$_WebinarRequestCopyWith(
          _$_WebinarRequest value, $Res Function(_$_WebinarRequest) then) =
      __$$_WebinarRequestCopyWithImpl<$Res>;
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
class __$$_WebinarRequestCopyWithImpl<$Res>
    extends _$WebinarRequestCopyWithImpl<$Res>
    implements _$$_WebinarRequestCopyWith<$Res> {
  __$$_WebinarRequestCopyWithImpl(
      _$_WebinarRequest _value, $Res Function(_$_WebinarRequest) _then)
      : super(_value, (v) => _then(v as _$_WebinarRequest));

  @override
  _$_WebinarRequest get _value => super._value as _$_WebinarRequest;

  @override
  $Res call({
    Object? description = freezed,
    Object? start = freezed,
    Object? categories = freezed,
    Object? title = freezed,
    Object? coverImage = freezed,
    Object? rtmpLink = freezed,
  }) {
    return _then(_$_WebinarRequest(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      categories: categories == freezed
          ? _value._categories
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
      required final List<int> categories,
      @JsonKey(name: 'topic_title') required this.title,
      @JsonKey(name: 'topic_image') required this.coverImage,
      @JsonKey(name: 'rtmp_link') this.rtmpLink})
      : _categories = categories;

  factory _$_WebinarRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WebinarRequestFromJson(json);

  @override
  final String? description;
  @override
  final String start;
  final List<int> _categories;
  @override
  List<int> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

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
        (other.runtimeType == runtimeType &&
            other is _$_WebinarRequest &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.coverImage, coverImage) &&
            const DeepCollectionEquality().equals(other.rtmpLink, rtmpLink));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(coverImage),
      const DeepCollectionEquality().hash(rtmpLink));

  @JsonKey(ignore: true)
  @override
  _$$_WebinarRequestCopyWith<_$_WebinarRequest> get copyWith =>
      __$$_WebinarRequestCopyWithImpl<_$_WebinarRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebinarRequestToJson(this);
  }
}

abstract class _WebinarRequest implements WebinarRequest {
  const factory _WebinarRequest(
      {final String? description,
      required final String start,
      required final List<int> categories,
      @JsonKey(name: 'topic_title') required final String title,
      @JsonKey(name: 'topic_image') required final String coverImage,
      @JsonKey(name: 'rtmp_link') final String? rtmpLink}) = _$_WebinarRequest;

  factory _WebinarRequest.fromJson(Map<String, dynamic> json) =
      _$_WebinarRequest.fromJson;

  @override
  String? get description;
  @override
  String get start;
  @override
  List<int> get categories;
  @override
  @JsonKey(name: 'topic_title')
  String get title;
  @override
  @JsonKey(name: 'topic_image')
  String get coverImage;
  @override
  @JsonKey(name: 'rtmp_link')
  String? get rtmpLink;
  @override
  @JsonKey(ignore: true)
  _$$_WebinarRequestCopyWith<_$_WebinarRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
