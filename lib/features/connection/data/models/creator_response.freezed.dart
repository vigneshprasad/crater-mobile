// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'creator_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatorResponse _$CreatorResponseFromJson(Map<String, dynamic> json) {
  return _CreatorResponse.fromJson(json);
}

/// @nodoc
mixin _$CreatorResponse {
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<Creator> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorResponseCopyWith<CreatorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorResponseCopyWith<$Res> {
  factory $CreatorResponseCopyWith(
          CreatorResponse value, $Res Function(CreatorResponse) then) =
      _$CreatorResponseCopyWithImpl<$Res>;
  $Res call(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Creator> results});
}

/// @nodoc
class _$CreatorResponseCopyWithImpl<$Res>
    implements $CreatorResponseCopyWith<$Res> {
  _$CreatorResponseCopyWithImpl(this._value, this._then);

  final CreatorResponse _value;
  // ignore: unused_field
  final $Res Function(CreatorResponse) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? currentPage = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Creator>,
    ));
  }
}

/// @nodoc
abstract class _$$_CreatorResponseCopyWith<$Res>
    implements $CreatorResponseCopyWith<$Res> {
  factory _$$_CreatorResponseCopyWith(
          _$_CreatorResponse value, $Res Function(_$_CreatorResponse) then) =
      __$$_CreatorResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Creator> results});
}

/// @nodoc
class __$$_CreatorResponseCopyWithImpl<$Res>
    extends _$CreatorResponseCopyWithImpl<$Res>
    implements _$$_CreatorResponseCopyWith<$Res> {
  __$$_CreatorResponseCopyWithImpl(
      _$_CreatorResponse _value, $Res Function(_$_CreatorResponse) _then)
      : super(_value, (v) => _then(v as _$_CreatorResponse));

  @override
  _$_CreatorResponse get _value => super._value as _$_CreatorResponse;

  @override
  $Res call({
    Object? count = freezed,
    Object? currentPage = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_$_CreatorResponse(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Creator>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatorResponse implements _CreatorResponse {
  const _$_CreatorResponse(
      {this.count = 0,
      @JsonKey(name: 'current_page') this.currentPage = 0,
      this.next,
      this.previous,
      final List<Creator> results = const []})
      : _results = results;

  factory _$_CreatorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorResponseFromJson(json);

  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  final String? next;
  @override
  final String? previous;
  final List<Creator> _results;
  @override
  @JsonKey()
  List<Creator> get results {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'CreatorResponse(count: $count, currentPage: $currentPage, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatorResponse &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality()
                .equals(other.currentPage, currentPage) &&
            const DeepCollectionEquality().equals(other.next, next) &&
            const DeepCollectionEquality().equals(other.previous, previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(currentPage),
      const DeepCollectionEquality().hash(next),
      const DeepCollectionEquality().hash(previous),
      const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  _$$_CreatorResponseCopyWith<_$_CreatorResponse> get copyWith =>
      __$$_CreatorResponseCopyWithImpl<_$_CreatorResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorResponseToJson(this);
  }
}

abstract class _CreatorResponse implements CreatorResponse {
  const factory _CreatorResponse(
      {final int count,
      @JsonKey(name: 'current_page') final int currentPage,
      final String? next,
      final String? previous,
      final List<Creator> results}) = _$_CreatorResponse;

  factory _CreatorResponse.fromJson(Map<String, dynamic> json) =
      _$_CreatorResponse.fromJson;

  @override
  int get count;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<Creator> get results;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorResponseCopyWith<_$_CreatorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

FollowCreatorResponse _$FollowCreatorResponseFromJson(
    Map<String, dynamic> json) {
  return _FollowCreatorResponse.fromJson(json);
}

/// @nodoc
mixin _$FollowCreatorResponse {
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<Webinar> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FollowCreatorResponseCopyWith<FollowCreatorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowCreatorResponseCopyWith<$Res> {
  factory $FollowCreatorResponseCopyWith(FollowCreatorResponse value,
          $Res Function(FollowCreatorResponse) then) =
      _$FollowCreatorResponseCopyWithImpl<$Res>;
  $Res call(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Webinar> results});
}

/// @nodoc
class _$FollowCreatorResponseCopyWithImpl<$Res>
    implements $FollowCreatorResponseCopyWith<$Res> {
  _$FollowCreatorResponseCopyWithImpl(this._value, this._then);

  final FollowCreatorResponse _value;
  // ignore: unused_field
  final $Res Function(FollowCreatorResponse) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? currentPage = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Webinar>,
    ));
  }
}

/// @nodoc
abstract class _$$_FollowCreatorResponseCopyWith<$Res>
    implements $FollowCreatorResponseCopyWith<$Res> {
  factory _$$_FollowCreatorResponseCopyWith(_$_FollowCreatorResponse value,
          $Res Function(_$_FollowCreatorResponse) then) =
      __$$_FollowCreatorResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Webinar> results});
}

/// @nodoc
class __$$_FollowCreatorResponseCopyWithImpl<$Res>
    extends _$FollowCreatorResponseCopyWithImpl<$Res>
    implements _$$_FollowCreatorResponseCopyWith<$Res> {
  __$$_FollowCreatorResponseCopyWithImpl(_$_FollowCreatorResponse _value,
      $Res Function(_$_FollowCreatorResponse) _then)
      : super(_value, (v) => _then(v as _$_FollowCreatorResponse));

  @override
  _$_FollowCreatorResponse get _value =>
      super._value as _$_FollowCreatorResponse;

  @override
  $Res call({
    Object? count = freezed,
    Object? currentPage = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_$_FollowCreatorResponse(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: currentPage == freezed
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      next: next == freezed
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: previous == freezed
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: results == freezed
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Webinar>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FollowCreatorResponse implements _FollowCreatorResponse {
  const _$_FollowCreatorResponse(
      {this.count = 0,
      @JsonKey(name: 'current_page') this.currentPage = 0,
      this.next,
      this.previous,
      final List<Webinar> results = const []})
      : _results = results;

  factory _$_FollowCreatorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_FollowCreatorResponseFromJson(json);

  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  final String? next;
  @override
  final String? previous;
  final List<Webinar> _results;
  @override
  @JsonKey()
  List<Webinar> get results {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'FollowCreatorResponse(count: $count, currentPage: $currentPage, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FollowCreatorResponse &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality()
                .equals(other.currentPage, currentPage) &&
            const DeepCollectionEquality().equals(other.next, next) &&
            const DeepCollectionEquality().equals(other.previous, previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(currentPage),
      const DeepCollectionEquality().hash(next),
      const DeepCollectionEquality().hash(previous),
      const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  _$$_FollowCreatorResponseCopyWith<_$_FollowCreatorResponse> get copyWith =>
      __$$_FollowCreatorResponseCopyWithImpl<_$_FollowCreatorResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FollowCreatorResponseToJson(this);
  }
}

abstract class _FollowCreatorResponse implements FollowCreatorResponse {
  const factory _FollowCreatorResponse(
      {final int count,
      @JsonKey(name: 'current_page') final int currentPage,
      final String? next,
      final String? previous,
      final List<Webinar> results}) = _$_FollowCreatorResponse;

  factory _FollowCreatorResponse.fromJson(Map<String, dynamic> json) =
      _$_FollowCreatorResponse.fromJson;

  @override
  int get count;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<Webinar> get results;
  @override
  @JsonKey(ignore: true)
  _$$_FollowCreatorResponseCopyWith<_$_FollowCreatorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return _Creator.fromJson(json);
}

/// @nodoc
mixin _$Creator {
  int get id => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_of_subscribers')
  int? get numberOfSubscribers => throw _privateConstructorUsedError;
  bool get certified => throw _privateConstructorUsedError;
  @JsonKey(name: 'follower_count')
  int? get followerCount =>
      throw _privateConstructorUsedError; // @Default(0)dynamic type,
  int get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_community')
  CreatorCommunity? get defaultCommunity => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_detail')
  Profile? get profileDetail => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_follower')
  bool? get isFollower => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_club_members')
  bool? get showClubMembers => throw _privateConstructorUsedError;
  String? get video => throw _privateConstructorUsedError;
  @JsonKey(name: 'video_poster')
  String? get videoPoster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorCopyWith<Creator> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorCopyWith<$Res> {
  factory $CreatorCopyWith(Creator value, $Res Function(Creator) then) =
      _$CreatorCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String user,
      @JsonKey(name: 'number_of_subscribers') int? numberOfSubscribers,
      bool certified,
      @JsonKey(name: 'follower_count') int? followerCount,
      int order,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail,
      String? slug,
      @JsonKey(name: 'is_follower') bool? isFollower,
      @JsonKey(name: 'show_club_members') bool? showClubMembers,
      String? video,
      @JsonKey(name: 'video_poster') String? videoPoster});

  $CreatorCommunityCopyWith<$Res>? get defaultCommunity;
  $ProfileCopyWith<$Res>? get profileDetail;
}

/// @nodoc
class _$CreatorCopyWithImpl<$Res> implements $CreatorCopyWith<$Res> {
  _$CreatorCopyWithImpl(this._value, this._then);

  final Creator _value;
  // ignore: unused_field
  final $Res Function(Creator) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? numberOfSubscribers = freezed,
    Object? certified = freezed,
    Object? followerCount = freezed,
    Object? order = freezed,
    Object? defaultCommunity = freezed,
    Object? profileDetail = freezed,
    Object? slug = freezed,
    Object? isFollower = freezed,
    Object? showClubMembers = freezed,
    Object? video = freezed,
    Object? videoPoster = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfSubscribers: numberOfSubscribers == freezed
          ? _value.numberOfSubscribers
          : numberOfSubscribers // ignore: cast_nullable_to_non_nullable
              as int?,
      certified: certified == freezed
          ? _value.certified
          : certified // ignore: cast_nullable_to_non_nullable
              as bool,
      followerCount: followerCount == freezed
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      defaultCommunity: defaultCommunity == freezed
          ? _value.defaultCommunity
          : defaultCommunity // ignore: cast_nullable_to_non_nullable
              as CreatorCommunity?,
      profileDetail: profileDetail == freezed
          ? _value.profileDetail
          : profileDetail // ignore: cast_nullable_to_non_nullable
              as Profile?,
      slug: slug == freezed
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollower: isFollower == freezed
          ? _value.isFollower
          : isFollower // ignore: cast_nullable_to_non_nullable
              as bool?,
      showClubMembers: showClubMembers == freezed
          ? _value.showClubMembers
          : showClubMembers // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String?,
      videoPoster: videoPoster == freezed
          ? _value.videoPoster
          : videoPoster // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $CreatorCommunityCopyWith<$Res>? get defaultCommunity {
    if (_value.defaultCommunity == null) {
      return null;
    }

    return $CreatorCommunityCopyWith<$Res>(_value.defaultCommunity!, (value) {
      return _then(_value.copyWith(defaultCommunity: value));
    });
  }

  @override
  $ProfileCopyWith<$Res>? get profileDetail {
    if (_value.profileDetail == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.profileDetail!, (value) {
      return _then(_value.copyWith(profileDetail: value));
    });
  }
}

/// @nodoc
abstract class _$$_CreatorCopyWith<$Res> implements $CreatorCopyWith<$Res> {
  factory _$$_CreatorCopyWith(
          _$_Creator value, $Res Function(_$_Creator) then) =
      __$$_CreatorCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String user,
      @JsonKey(name: 'number_of_subscribers') int? numberOfSubscribers,
      bool certified,
      @JsonKey(name: 'follower_count') int? followerCount,
      int order,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail,
      String? slug,
      @JsonKey(name: 'is_follower') bool? isFollower,
      @JsonKey(name: 'show_club_members') bool? showClubMembers,
      String? video,
      @JsonKey(name: 'video_poster') String? videoPoster});

  @override
  $CreatorCommunityCopyWith<$Res>? get defaultCommunity;
  @override
  $ProfileCopyWith<$Res>? get profileDetail;
}

/// @nodoc
class __$$_CreatorCopyWithImpl<$Res> extends _$CreatorCopyWithImpl<$Res>
    implements _$$_CreatorCopyWith<$Res> {
  __$$_CreatorCopyWithImpl(_$_Creator _value, $Res Function(_$_Creator) _then)
      : super(_value, (v) => _then(v as _$_Creator));

  @override
  _$_Creator get _value => super._value as _$_Creator;

  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? numberOfSubscribers = freezed,
    Object? certified = freezed,
    Object? followerCount = freezed,
    Object? order = freezed,
    Object? defaultCommunity = freezed,
    Object? profileDetail = freezed,
    Object? slug = freezed,
    Object? isFollower = freezed,
    Object? showClubMembers = freezed,
    Object? video = freezed,
    Object? videoPoster = freezed,
  }) {
    return _then(_$_Creator(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfSubscribers: numberOfSubscribers == freezed
          ? _value.numberOfSubscribers
          : numberOfSubscribers // ignore: cast_nullable_to_non_nullable
              as int?,
      certified: certified == freezed
          ? _value.certified
          : certified // ignore: cast_nullable_to_non_nullable
              as bool,
      followerCount: followerCount == freezed
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      defaultCommunity: defaultCommunity == freezed
          ? _value.defaultCommunity
          : defaultCommunity // ignore: cast_nullable_to_non_nullable
              as CreatorCommunity?,
      profileDetail: profileDetail == freezed
          ? _value.profileDetail
          : profileDetail // ignore: cast_nullable_to_non_nullable
              as Profile?,
      slug: slug == freezed
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollower: isFollower == freezed
          ? _value.isFollower
          : isFollower // ignore: cast_nullable_to_non_nullable
              as bool?,
      showClubMembers: showClubMembers == freezed
          ? _value.showClubMembers
          : showClubMembers // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as String?,
      videoPoster: videoPoster == freezed
          ? _value.videoPoster
          : videoPoster // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Creator implements _Creator {
  const _$_Creator(
      {this.id = 0,
      this.user = '',
      @JsonKey(name: 'number_of_subscribers') this.numberOfSubscribers = 0,
      this.certified = false,
      @JsonKey(name: 'follower_count') this.followerCount = 0,
      this.order = 0,
      @JsonKey(name: 'default_community') this.defaultCommunity,
      @JsonKey(name: 'profile_detail') this.profileDetail,
      this.slug,
      @JsonKey(name: 'is_follower') this.isFollower,
      @JsonKey(name: 'show_club_members') this.showClubMembers,
      this.video,
      @JsonKey(name: 'video_poster') this.videoPoster});

  factory _$_Creator.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String user;
  @override
  @JsonKey(name: 'number_of_subscribers')
  final int? numberOfSubscribers;
  @override
  @JsonKey()
  final bool certified;
  @override
  @JsonKey(name: 'follower_count')
  final int? followerCount;
// @Default(0)dynamic type,
  @override
  @JsonKey()
  final int order;
  @override
  @JsonKey(name: 'default_community')
  final CreatorCommunity? defaultCommunity;
  @override
  @JsonKey(name: 'profile_detail')
  final Profile? profileDetail;
  @override
  final String? slug;
  @override
  @JsonKey(name: 'is_follower')
  final bool? isFollower;
  @override
  @JsonKey(name: 'show_club_members')
  final bool? showClubMembers;
  @override
  final String? video;
  @override
  @JsonKey(name: 'video_poster')
  final String? videoPoster;

  @override
  String toString() {
    return 'Creator(id: $id, user: $user, numberOfSubscribers: $numberOfSubscribers, certified: $certified, followerCount: $followerCount, order: $order, defaultCommunity: $defaultCommunity, profileDetail: $profileDetail, slug: $slug, isFollower: $isFollower, showClubMembers: $showClubMembers, video: $video, videoPoster: $videoPoster)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Creator &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.numberOfSubscribers, numberOfSubscribers) &&
            const DeepCollectionEquality().equals(other.certified, certified) &&
            const DeepCollectionEquality()
                .equals(other.followerCount, followerCount) &&
            const DeepCollectionEquality().equals(other.order, order) &&
            const DeepCollectionEquality()
                .equals(other.defaultCommunity, defaultCommunity) &&
            const DeepCollectionEquality()
                .equals(other.profileDetail, profileDetail) &&
            const DeepCollectionEquality().equals(other.slug, slug) &&
            const DeepCollectionEquality()
                .equals(other.isFollower, isFollower) &&
            const DeepCollectionEquality()
                .equals(other.showClubMembers, showClubMembers) &&
            const DeepCollectionEquality().equals(other.video, video) &&
            const DeepCollectionEquality()
                .equals(other.videoPoster, videoPoster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(numberOfSubscribers),
      const DeepCollectionEquality().hash(certified),
      const DeepCollectionEquality().hash(followerCount),
      const DeepCollectionEquality().hash(order),
      const DeepCollectionEquality().hash(defaultCommunity),
      const DeepCollectionEquality().hash(profileDetail),
      const DeepCollectionEquality().hash(slug),
      const DeepCollectionEquality().hash(isFollower),
      const DeepCollectionEquality().hash(showClubMembers),
      const DeepCollectionEquality().hash(video),
      const DeepCollectionEquality().hash(videoPoster));

  @JsonKey(ignore: true)
  @override
  _$$_CreatorCopyWith<_$_Creator> get copyWith =>
      __$$_CreatorCopyWithImpl<_$_Creator>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorToJson(this);
  }
}

abstract class _Creator implements Creator {
  const factory _Creator(
      {final int id,
      final String user,
      @JsonKey(name: 'number_of_subscribers')
          final int? numberOfSubscribers,
      final bool certified,
      @JsonKey(name: 'follower_count')
          final int? followerCount,
      final int order,
      @JsonKey(name: 'default_community')
          final CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail')
          final Profile? profileDetail,
      final String? slug,
      @JsonKey(name: 'is_follower')
          final bool? isFollower,
      @JsonKey(name: 'show_club_members')
          final bool? showClubMembers,
      final String? video,
      @JsonKey(name: 'video_poster')
          final String? videoPoster}) = _$_Creator;

  factory _Creator.fromJson(Map<String, dynamic> json) = _$_Creator.fromJson;

  @override
  int get id;
  @override
  String get user;
  @override
  @JsonKey(name: 'number_of_subscribers')
  int? get numberOfSubscribers;
  @override
  bool get certified;
  @override
  @JsonKey(name: 'follower_count')
  int? get followerCount;
  @override // @Default(0)dynamic type,
  int get order;
  @override
  @JsonKey(name: 'default_community')
  CreatorCommunity? get defaultCommunity;
  @override
  @JsonKey(name: 'profile_detail')
  Profile? get profileDetail;
  @override
  String? get slug;
  @override
  @JsonKey(name: 'is_follower')
  bool? get isFollower;
  @override
  @JsonKey(name: 'show_club_members')
  bool? get showClubMembers;
  @override
  String? get video;
  @override
  @JsonKey(name: 'video_poster')
  String? get videoPoster;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorCopyWith<_$_Creator> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatorCommunity _$CreatorCommunityFromJson(Map<String, dynamic> json) {
  return _CreatorCommunity.fromJson(json);
}

/// @nodoc
mixin _$CreatorCommunity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get creator => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatorCommunityCopyWith<CreatorCommunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatorCommunityCopyWith<$Res> {
  factory $CreatorCommunityCopyWith(
          CreatorCommunity value, $Res Function(CreatorCommunity) then) =
      _$CreatorCommunityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      int creator,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$CreatorCommunityCopyWithImpl<$Res>
    implements $CreatorCommunityCopyWith<$Res> {
  _$CreatorCommunityCopyWithImpl(this._value, this._then);

  final CreatorCommunity _value;
  // ignore: unused_field
  final $Res Function(CreatorCommunity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? creator = freezed,
    Object? isDefault = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CreatorCommunityCopyWith<$Res>
    implements $CreatorCommunityCopyWith<$Res> {
  factory _$$_CreatorCommunityCopyWith(
          _$_CreatorCommunity value, $Res Function(_$_CreatorCommunity) then) =
      __$$_CreatorCommunityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      int creator,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$_CreatorCommunityCopyWithImpl<$Res>
    extends _$CreatorCommunityCopyWithImpl<$Res>
    implements _$$_CreatorCommunityCopyWith<$Res> {
  __$$_CreatorCommunityCopyWithImpl(
      _$_CreatorCommunity _value, $Res Function(_$_CreatorCommunity) _then)
      : super(_value, (v) => _then(v as _$_CreatorCommunity));

  @override
  _$_CreatorCommunity get _value => super._value as _$_CreatorCommunity;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? creator = freezed,
    Object? isDefault = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$_CreatorCommunity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      creator: creator == freezed
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatorCommunity implements _CreatorCommunity {
  const _$_CreatorCommunity(
      {this.id = 0,
      this.name = '',
      this.creator = 0,
      @JsonKey(name: 'is_default') this.isDefault = false,
      @JsonKey(name: 'is_active') this.isActive = false});

  factory _$_CreatorCommunity.fromJson(Map<String, dynamic> json) =>
      _$$_CreatorCommunityFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int creator;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'CreatorCommunity(id: $id, name: $name, creator: $creator, isDefault: $isDefault, isActive: $isActive)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatorCommunity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.creator, creator) &&
            const DeepCollectionEquality().equals(other.isDefault, isDefault) &&
            const DeepCollectionEquality().equals(other.isActive, isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(creator),
      const DeepCollectionEquality().hash(isDefault),
      const DeepCollectionEquality().hash(isActive));

  @JsonKey(ignore: true)
  @override
  _$$_CreatorCommunityCopyWith<_$_CreatorCommunity> get copyWith =>
      __$$_CreatorCommunityCopyWithImpl<_$_CreatorCommunity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatorCommunityToJson(this);
  }
}

abstract class _CreatorCommunity implements CreatorCommunity {
  const factory _CreatorCommunity(
      {final int id,
      final String name,
      final int creator,
      @JsonKey(name: 'is_default') final bool isDefault,
      @JsonKey(name: 'is_active') final bool isActive}) = _$_CreatorCommunity;

  factory _CreatorCommunity.fromJson(Map<String, dynamic> json) =
      _$_CreatorCommunity.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get creator;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$_CreatorCommunityCopyWith<_$_CreatorCommunity> get copyWith =>
      throw _privateConstructorUsedError;
}
