// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'creator_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatorResponse _$CreatorResponseFromJson(Map<String, dynamic> json) {
  return _CreatorResponse.fromJson(json);
}

/// @nodoc
class _$CreatorResponseTearOff {
  const _$CreatorResponseTearOff();

  _CreatorResponse call(
      {int count = 0,
      @JsonKey(name: 'current_page') int currentPage = 0,
      String? next,
      String? previous,
      List<Creator> results = const []}) {
    return _CreatorResponse(
      count: count,
      currentPage: currentPage,
      next: next,
      previous: previous,
      results: results,
    );
  }

  CreatorResponse fromJson(Map<String, Object> json) {
    return CreatorResponse.fromJson(json);
  }
}

/// @nodoc
const $CreatorResponse = _$CreatorResponseTearOff();

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
abstract class _$CreatorResponseCopyWith<$Res>
    implements $CreatorResponseCopyWith<$Res> {
  factory _$CreatorResponseCopyWith(
          _CreatorResponse value, $Res Function(_CreatorResponse) then) =
      __$CreatorResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Creator> results});
}

/// @nodoc
class __$CreatorResponseCopyWithImpl<$Res>
    extends _$CreatorResponseCopyWithImpl<$Res>
    implements _$CreatorResponseCopyWith<$Res> {
  __$CreatorResponseCopyWithImpl(
      _CreatorResponse _value, $Res Function(_CreatorResponse) _then)
      : super(_value, (v) => _then(v as _CreatorResponse));

  @override
  _CreatorResponse get _value => super._value as _CreatorResponse;

  @override
  $Res call({
    Object? count = freezed,
    Object? currentPage = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = freezed,
  }) {
    return _then(_CreatorResponse(
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
@JsonSerializable()
class _$_CreatorResponse implements _CreatorResponse {
  const _$_CreatorResponse(
      {this.count = 0,
      @JsonKey(name: 'current_page') this.currentPage = 0,
      this.next,
      this.previous,
      this.results = const []});

  factory _$_CreatorResponse.fromJson(Map<String, dynamic> json) =>
      _$_$_CreatorResponseFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int count;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  final String? next;
  @override
  final String? previous;
  @JsonKey(defaultValue: const [])
  @override
  final List<Creator> results;

  @override
  String toString() {
    return 'CreatorResponse(count: $count, currentPage: $currentPage, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CreatorResponse &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)) &&
            (identical(other.previous, previous) ||
                const DeepCollectionEquality()
                    .equals(other.previous, previous)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(next) ^
      const DeepCollectionEquality().hash(previous) ^
      const DeepCollectionEquality().hash(results);

  @JsonKey(ignore: true)
  @override
  _$CreatorResponseCopyWith<_CreatorResponse> get copyWith =>
      __$CreatorResponseCopyWithImpl<_CreatorResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CreatorResponseToJson(this);
  }
}

abstract class _CreatorResponse implements CreatorResponse {
  const factory _CreatorResponse(
      {int count,
      @JsonKey(name: 'current_page') int currentPage,
      String? next,
      String? previous,
      List<Creator> results}) = _$_CreatorResponse;

  factory _CreatorResponse.fromJson(Map<String, dynamic> json) =
      _$_CreatorResponse.fromJson;

  @override
  int get count => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @override
  String? get next => throw _privateConstructorUsedError;
  @override
  String? get previous => throw _privateConstructorUsedError;
  @override
  List<Creator> get results => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreatorResponseCopyWith<_CreatorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return _Creator.fromJson(json);
}

/// @nodoc
class _$CreatorTearOff {
  const _$CreatorTearOff();

  _Creator call(
      {int id = 0,
      String user = '',
      @JsonKey(name: 'number_of_subscribers') int numberOfSubscribers = 0,
      bool certified = false,
      @JsonKey(name: 'follower_count') int followerCount = 0,
      int order = 0,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail}) {
    return _Creator(
      id: id,
      user: user,
      numberOfSubscribers: numberOfSubscribers,
      certified: certified,
      followerCount: followerCount,
      order: order,
      defaultCommunity: defaultCommunity,
      profileDetail: profileDetail,
    );
  }

  Creator fromJson(Map<String, Object> json) {
    return Creator.fromJson(json);
  }
}

/// @nodoc
const $Creator = _$CreatorTearOff();

/// @nodoc
mixin _$Creator {
  int get id => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'number_of_subscribers')
  int get numberOfSubscribers => throw _privateConstructorUsedError;
  bool get certified => throw _privateConstructorUsedError;
  @JsonKey(name: 'follower_count')
  int get followerCount =>
      throw _privateConstructorUsedError; // @Default(0)dynamic type,
  int get order => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_community')
  CreatorCommunity? get defaultCommunity => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_detail')
  Profile? get profileDetail => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'number_of_subscribers') int numberOfSubscribers,
      bool certified,
      @JsonKey(name: 'follower_count') int followerCount,
      int order,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail});

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
              as int,
      certified: certified == freezed
          ? _value.certified
          : certified // ignore: cast_nullable_to_non_nullable
              as bool,
      followerCount: followerCount == freezed
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$CreatorCopyWith<$Res> implements $CreatorCopyWith<$Res> {
  factory _$CreatorCopyWith(_Creator value, $Res Function(_Creator) then) =
      __$CreatorCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String user,
      @JsonKey(name: 'number_of_subscribers') int numberOfSubscribers,
      bool certified,
      @JsonKey(name: 'follower_count') int followerCount,
      int order,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail});

  @override
  $CreatorCommunityCopyWith<$Res>? get defaultCommunity;
  @override
  $ProfileCopyWith<$Res>? get profileDetail;
}

/// @nodoc
class __$CreatorCopyWithImpl<$Res> extends _$CreatorCopyWithImpl<$Res>
    implements _$CreatorCopyWith<$Res> {
  __$CreatorCopyWithImpl(_Creator _value, $Res Function(_Creator) _then)
      : super(_value, (v) => _then(v as _Creator));

  @override
  _Creator get _value => super._value as _Creator;

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
  }) {
    return _then(_Creator(
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
              as int,
      certified: certified == freezed
          ? _value.certified
          : certified // ignore: cast_nullable_to_non_nullable
              as bool,
      followerCount: followerCount == freezed
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
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
      @JsonKey(name: 'profile_detail') this.profileDetail});

  factory _$_Creator.fromJson(Map<String, dynamic> json) =>
      _$_$_CreatorFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int id;
  @JsonKey(defaultValue: '')
  @override
  final String user;
  @override
  @JsonKey(name: 'number_of_subscribers')
  final int numberOfSubscribers;
  @JsonKey(defaultValue: false)
  @override
  final bool certified;
  @override
  @JsonKey(name: 'follower_count')
  final int followerCount;
  @JsonKey(defaultValue: 0)
  @override // @Default(0)dynamic type,
  final int order;
  @override
  @JsonKey(name: 'default_community')
  final CreatorCommunity? defaultCommunity;
  @override
  @JsonKey(name: 'profile_detail')
  final Profile? profileDetail;

  @override
  String toString() {
    return 'Creator(id: $id, user: $user, numberOfSubscribers: $numberOfSubscribers, certified: $certified, followerCount: $followerCount, order: $order, defaultCommunity: $defaultCommunity, profileDetail: $profileDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Creator &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.numberOfSubscribers, numberOfSubscribers) ||
                const DeepCollectionEquality()
                    .equals(other.numberOfSubscribers, numberOfSubscribers)) &&
            (identical(other.certified, certified) ||
                const DeepCollectionEquality()
                    .equals(other.certified, certified)) &&
            (identical(other.followerCount, followerCount) ||
                const DeepCollectionEquality()
                    .equals(other.followerCount, followerCount)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.defaultCommunity, defaultCommunity) ||
                const DeepCollectionEquality()
                    .equals(other.defaultCommunity, defaultCommunity)) &&
            (identical(other.profileDetail, profileDetail) ||
                const DeepCollectionEquality()
                    .equals(other.profileDetail, profileDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(numberOfSubscribers) ^
      const DeepCollectionEquality().hash(certified) ^
      const DeepCollectionEquality().hash(followerCount) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(defaultCommunity) ^
      const DeepCollectionEquality().hash(profileDetail);

  @JsonKey(ignore: true)
  @override
  _$CreatorCopyWith<_Creator> get copyWith =>
      __$CreatorCopyWithImpl<_Creator>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CreatorToJson(this);
  }
}

abstract class _Creator implements Creator {
  const factory _Creator(
      {int id,
      String user,
      @JsonKey(name: 'number_of_subscribers') int numberOfSubscribers,
      bool certified,
      @JsonKey(name: 'follower_count') int followerCount,
      int order,
      @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
      @JsonKey(name: 'profile_detail') Profile? profileDetail}) = _$_Creator;

  factory _Creator.fromJson(Map<String, dynamic> json) = _$_Creator.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'number_of_subscribers')
  int get numberOfSubscribers => throw _privateConstructorUsedError;
  @override
  bool get certified => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'follower_count')
  int get followerCount => throw _privateConstructorUsedError;
  @override // @Default(0)dynamic type,
  int get order => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'default_community')
  CreatorCommunity? get defaultCommunity => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'profile_detail')
  Profile? get profileDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreatorCopyWith<_Creator> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatorCommunity _$CreatorCommunityFromJson(Map<String, dynamic> json) {
  return _CreatorCommunity.fromJson(json);
}

/// @nodoc
class _$CreatorCommunityTearOff {
  const _$CreatorCommunityTearOff();

  _CreatorCommunity call(
      {int id = 0,
      String name = '',
      int creator = 0,
      @JsonKey(name: 'is_default') bool isDefault = false,
      @JsonKey(name: 'is_active') bool isActive = false}) {
    return _CreatorCommunity(
      id: id,
      name: name,
      creator: creator,
      isDefault: isDefault,
      isActive: isActive,
    );
  }

  CreatorCommunity fromJson(Map<String, Object> json) {
    return CreatorCommunity.fromJson(json);
  }
}

/// @nodoc
const $CreatorCommunity = _$CreatorCommunityTearOff();

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
abstract class _$CreatorCommunityCopyWith<$Res>
    implements $CreatorCommunityCopyWith<$Res> {
  factory _$CreatorCommunityCopyWith(
          _CreatorCommunity value, $Res Function(_CreatorCommunity) then) =
      __$CreatorCommunityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      int creator,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$CreatorCommunityCopyWithImpl<$Res>
    extends _$CreatorCommunityCopyWithImpl<$Res>
    implements _$CreatorCommunityCopyWith<$Res> {
  __$CreatorCommunityCopyWithImpl(
      _CreatorCommunity _value, $Res Function(_CreatorCommunity) _then)
      : super(_value, (v) => _then(v as _CreatorCommunity));

  @override
  _CreatorCommunity get _value => super._value as _CreatorCommunity;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? creator = freezed,
    Object? isDefault = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_CreatorCommunity(
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
      _$_$_CreatorCommunityFromJson(json);

  @JsonKey(defaultValue: 0)
  @override
  final int id;
  @JsonKey(defaultValue: '')
  @override
  final String name;
  @JsonKey(defaultValue: 0)
  @override
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
        (other is _CreatorCommunity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.creator, creator) ||
                const DeepCollectionEquality()
                    .equals(other.creator, creator)) &&
            (identical(other.isDefault, isDefault) ||
                const DeepCollectionEquality()
                    .equals(other.isDefault, isDefault)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(creator) ^
      const DeepCollectionEquality().hash(isDefault) ^
      const DeepCollectionEquality().hash(isActive);

  @JsonKey(ignore: true)
  @override
  _$CreatorCommunityCopyWith<_CreatorCommunity> get copyWith =>
      __$CreatorCommunityCopyWithImpl<_CreatorCommunity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CreatorCommunityToJson(this);
  }
}

abstract class _CreatorCommunity implements CreatorCommunity {
  const factory _CreatorCommunity(
      {int id,
      String name,
      int creator,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive}) = _$_CreatorCommunity;

  factory _CreatorCommunity.fromJson(Map<String, dynamic> json) =
      _$_CreatorCommunity.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get creator => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreatorCommunityCopyWith<_CreatorCommunity> get copyWith =>
      throw _privateConstructorUsedError;
}
