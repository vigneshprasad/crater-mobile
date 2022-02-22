// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'series_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return _Series.fromJson(json);
}

/// @nodoc
class _$SeriesTearOff {
  const _$SeriesTearOff();

  _Series call(
      {int? id,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          List<GroupsDetailList>? groupsDetailList,
      List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          List<dynamic>? categoriesDetailList,
      String? host,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      DateTime? start,
      @JsonKey(name: "created_at")
          DateTime? createdAt}) {
    return _Series(
      id: id,
      topic: topic,
      topicDetail: topicDetail,
      groups: groups,
      groupsDetailList: groupsDetailList,
      categories: categories,
      categoriesDetailList: categoriesDetailList,
      host: host,
      hostDetail: hostDetail,
      start: start,
      createdAt: createdAt,
    );
  }

  Series fromJson(Map<String, Object> json) {
    return Series.fromJson(json);
  }
}

/// @nodoc
const $Series = _$SeriesTearOff();

/// @nodoc
mixin _$Series {
  int? get id => throw _privateConstructorUsedError;
  int? get topic => throw _privateConstructorUsedError;
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  List<int>? get groups => throw _privateConstructorUsedError;
  @JsonKey(name: "groups_detail_list")
  List<GroupsDetailList>? get groupsDetailList =>
      throw _privateConstructorUsedError;
  List<dynamic>? get categories => throw _privateConstructorUsedError;
  @JsonKey(name: "categories_detail_list")
  List<dynamic>? get categoriesDetailList => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesCopyWith<Series> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesCopyWith<$Res> {
  factory $SeriesCopyWith(Series value, $Res Function(Series) then) =
      _$SeriesCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          List<GroupsDetailList>? groupsDetailList,
      List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          List<dynamic>? categoriesDetailList,
      String? host,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      DateTime? start,
      @JsonKey(name: "created_at")
          DateTime? createdAt});

  $TopicCopyWith<$Res>? get topicDetail;
  $HostDetailCopyWith<$Res>? get hostDetail;
}

/// @nodoc
class _$SeriesCopyWithImpl<$Res> implements $SeriesCopyWith<$Res> {
  _$SeriesCopyWithImpl(this._value, this._then);

  final Series _value;
  // ignore: unused_field
  final $Res Function(Series) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? topic = freezed,
    Object? topicDetail = freezed,
    Object? groups = freezed,
    Object? groupsDetailList = freezed,
    Object? categories = freezed,
    Object? categoriesDetailList = freezed,
    Object? host = freezed,
    Object? hostDetail = freezed,
    Object? start = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      groupsDetailList: groupsDetailList == freezed
          ? _value.groupsDetailList
          : groupsDetailList // ignore: cast_nullable_to_non_nullable
              as List<GroupsDetailList>?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value.categoriesDetailList
          : categoriesDetailList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as HostDetail?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

  @override
  $HostDetailCopyWith<$Res>? get hostDetail {
    if (_value.hostDetail == null) {
      return null;
    }

    return $HostDetailCopyWith<$Res>(_value.hostDetail!, (value) {
      return _then(_value.copyWith(hostDetail: value));
    });
  }
}

/// @nodoc
abstract class _$SeriesCopyWith<$Res> implements $SeriesCopyWith<$Res> {
  factory _$SeriesCopyWith(_Series value, $Res Function(_Series) then) =
      __$SeriesCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          List<GroupsDetailList>? groupsDetailList,
      List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          List<dynamic>? categoriesDetailList,
      String? host,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      DateTime? start,
      @JsonKey(name: "created_at")
          DateTime? createdAt});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
  @override
  $HostDetailCopyWith<$Res>? get hostDetail;
}

/// @nodoc
class __$SeriesCopyWithImpl<$Res> extends _$SeriesCopyWithImpl<$Res>
    implements _$SeriesCopyWith<$Res> {
  __$SeriesCopyWithImpl(_Series _value, $Res Function(_Series) _then)
      : super(_value, (v) => _then(v as _Series));

  @override
  _Series get _value => super._value as _Series;

  @override
  $Res call({
    Object? id = freezed,
    Object? topic = freezed,
    Object? topicDetail = freezed,
    Object? groups = freezed,
    Object? groupsDetailList = freezed,
    Object? categories = freezed,
    Object? categoriesDetailList = freezed,
    Object? host = freezed,
    Object? hostDetail = freezed,
    Object? start = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_Series(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      groupsDetailList: groupsDetailList == freezed
          ? _value.groupsDetailList
          : groupsDetailList // ignore: cast_nullable_to_non_nullable
              as List<GroupsDetailList>?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value.categoriesDetailList
          : categoriesDetailList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as HostDetail?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Series implements _Series {
  const _$_Series(
      {this.id,
      this.topic,
      @JsonKey(name: "topic_detail") this.topicDetail,
      this.groups,
      @JsonKey(name: "groups_detail_list") this.groupsDetailList,
      this.categories,
      @JsonKey(name: "categories_detail_list") this.categoriesDetailList,
      this.host,
      @JsonKey(name: "host_detail") this.hostDetail,
      this.start,
      @JsonKey(name: "created_at") this.createdAt});

  factory _$_Series.fromJson(Map<String, dynamic> json) =>
      _$_$_SeriesFromJson(json);

  @override
  final int? id;
  @override
  final int? topic;
  @override
  @JsonKey(name: "topic_detail")
  final Topic? topicDetail;
  @override
  final List<int>? groups;
  @override
  @JsonKey(name: "groups_detail_list")
  final List<GroupsDetailList>? groupsDetailList;
  @override
  final List<dynamic>? categories;
  @override
  @JsonKey(name: "categories_detail_list")
  final List<dynamic>? categoriesDetailList;
  @override
  final String? host;
  @override
  @JsonKey(name: "host_detail")
  final HostDetail? hostDetail;
  @override
  final DateTime? start;
  @override
  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Series(id: $id, topic: $topic, topicDetail: $topicDetail, groups: $groups, groupsDetailList: $groupsDetailList, categories: $categories, categoriesDetailList: $categoriesDetailList, host: $host, hostDetail: $hostDetail, start: $start, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Series &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.topic, topic) ||
                const DeepCollectionEquality().equals(other.topic, topic)) &&
            (identical(other.topicDetail, topicDetail) ||
                const DeepCollectionEquality()
                    .equals(other.topicDetail, topicDetail)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)) &&
            (identical(other.groupsDetailList, groupsDetailList) ||
                const DeepCollectionEquality()
                    .equals(other.groupsDetailList, groupsDetailList)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.categoriesDetailList, categoriesDetailList) ||
                const DeepCollectionEquality().equals(
                    other.categoriesDetailList, categoriesDetailList)) &&
            (identical(other.host, host) ||
                const DeepCollectionEquality().equals(other.host, host)) &&
            (identical(other.hostDetail, hostDetail) ||
                const DeepCollectionEquality()
                    .equals(other.hostDetail, hostDetail)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(topic) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(groups) ^
      const DeepCollectionEquality().hash(groupsDetailList) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(categoriesDetailList) ^
      const DeepCollectionEquality().hash(host) ^
      const DeepCollectionEquality().hash(hostDetail) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(createdAt);

  @JsonKey(ignore: true)
  @override
  _$SeriesCopyWith<_Series> get copyWith =>
      __$SeriesCopyWithImpl<_Series>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SeriesToJson(this);
  }
}

abstract class _Series implements Series {
  const factory _Series(
      {int? id,
      int? topic,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          List<GroupsDetailList>? groupsDetailList,
      List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          List<dynamic>? categoriesDetailList,
      String? host,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      DateTime? start,
      @JsonKey(name: "created_at")
          DateTime? createdAt}) = _$_Series;

  factory _Series.fromJson(Map<String, dynamic> json) = _$_Series.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  int? get topic => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @override
  List<int>? get groups => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "groups_detail_list")
  List<GroupsDetailList>? get groupsDetailList =>
      throw _privateConstructorUsedError;
  @override
  List<dynamic>? get categories => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "categories_detail_list")
  List<dynamic>? get categoriesDetailList => throw _privateConstructorUsedError;
  @override
  String? get host => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail => throw _privateConstructorUsedError;
  @override
  DateTime? get start => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SeriesCopyWith<_Series> get copyWith => throw _privateConstructorUsedError;
}

GroupsDetailList _$GroupsDetailListFromJson(Map<String, dynamic> json) {
  return _GroupsDetailList.fromJson(json);
}

/// @nodoc
class _$GroupsDetailListTearOff {
  const _$GroupsDetailListTearOff();

  _GroupsDetailList call(
      {int? id,
      String? host,
      int? topic,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      @JsonKey(name: "closed_at")
          DateTime? closedAt,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      @JsonKey(name: "host_profile_details")
          UserProfileModel? hostProfileDetails,
      int? type,
      @JsonKey(name: "is_live")
          bool? isLive,
      @JsonKey(name: "live_count")
          int? liveCount,
      bool? rsvp,
      bool? isPast,
      @JsonKey(name: "is_featured")
          bool? isFeatured,
      List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          RecordingDetails? recordingDetails,
      List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          List<HostDetail>? speakersDetailList,
      int? series}) {
    return _GroupsDetailList(
      id: id,
      host: host,
      topic: topic,
      description: description,
      start: start,
      privacy: privacy,
      medium: medium,
      closed: closed,
      closedAt: closedAt,
      topicDetail: topicDetail,
      hostDetail: hostDetail,
      hostProfileDetails: hostProfileDetails,
      type: type,
      isLive: isLive,
      liveCount: liveCount,
      rsvp: rsvp,
      isPast: isPast,
      isFeatured: isFeatured,
      categories: categories,
      categoriesDetailList: categoriesDetailList,
      recordingDetails: recordingDetails,
      speakers: speakers,
      speakersDetailList: speakersDetailList,
      series: series,
    );
  }

  GroupsDetailList fromJson(Map<String, Object> json) {
    return GroupsDetailList.fromJson(json);
  }
}

/// @nodoc
const $GroupsDetailList = _$GroupsDetailListTearOff();

/// @nodoc
mixin _$GroupsDetailList {
  int? get id => throw _privateConstructorUsedError;
  String? get host => throw _privateConstructorUsedError;
  int? get topic => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  int? get privacy => throw _privateConstructorUsedError;
  int? get medium => throw _privateConstructorUsedError;
  bool? get closed => throw _privateConstructorUsedError;
  @JsonKey(name: "closed_at")
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail => throw _privateConstructorUsedError;
  @JsonKey(name: "host_profile_details")
  UserProfileModel? get hostProfileDetails =>
      throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "is_live")
  bool? get isLive => throw _privateConstructorUsedError;
  @JsonKey(name: "live_count")
  int? get liveCount => throw _privateConstructorUsedError;
  bool? get rsvp => throw _privateConstructorUsedError;
  bool? get isPast => throw _privateConstructorUsedError;
  @JsonKey(name: "is_featured")
  bool? get isFeatured => throw _privateConstructorUsedError;
  List<int>? get categories => throw _privateConstructorUsedError;
  @JsonKey(name: "categories_detail_list")
  List<CategoriesDetailList>? get categoriesDetailList =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "recording_details")
  RecordingDetails? get recordingDetails => throw _privateConstructorUsedError;
  List<String>? get speakers => throw _privateConstructorUsedError;
  @JsonKey(name: "speakers_detail_list")
  List<HostDetail>? get speakersDetailList =>
      throw _privateConstructorUsedError;
  int? get series => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupsDetailListCopyWith<GroupsDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupsDetailListCopyWith<$Res> {
  factory $GroupsDetailListCopyWith(
          GroupsDetailList value, $Res Function(GroupsDetailList) then) =
      _$GroupsDetailListCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String? host,
      int? topic,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      @JsonKey(name: "closed_at")
          DateTime? closedAt,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      @JsonKey(name: "host_profile_details")
          UserProfileModel? hostProfileDetails,
      int? type,
      @JsonKey(name: "is_live")
          bool? isLive,
      @JsonKey(name: "live_count")
          int? liveCount,
      bool? rsvp,
      bool? isPast,
      @JsonKey(name: "is_featured")
          bool? isFeatured,
      List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          RecordingDetails? recordingDetails,
      List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          List<HostDetail>? speakersDetailList,
      int? series});

  $TopicCopyWith<$Res>? get topicDetail;
  $HostDetailCopyWith<$Res>? get hostDetail;
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
}

/// @nodoc
class _$GroupsDetailListCopyWithImpl<$Res>
    implements $GroupsDetailListCopyWith<$Res> {
  _$GroupsDetailListCopyWithImpl(this._value, this._then);

  final GroupsDetailList _value;
  // ignore: unused_field
  final $Res Function(GroupsDetailList) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? topic = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? hostProfileDetails = freezed,
    Object? type = freezed,
    Object? isLive = freezed,
    Object? liveCount = freezed,
    Object? rsvp = freezed,
    Object? isPast = freezed,
    Object? isFeatured = freezed,
    Object? categories = freezed,
    Object? categoriesDetailList = freezed,
    Object? recordingDetails = freezed,
    Object? speakers = freezed,
    Object? speakersDetailList = freezed,
    Object? series = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as int?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      closedAt: closedAt == freezed
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as HostDetail?,
      hostProfileDetails: hostProfileDetails == freezed
          ? _value.hostProfileDetails
          : hostProfileDetails // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      liveCount: liveCount == freezed
          ? _value.liveCount
          : liveCount // ignore: cast_nullable_to_non_nullable
              as int?,
      rsvp: rsvp == freezed
          ? _value.rsvp
          : rsvp // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value.categoriesDetailList
          : categoriesDetailList // ignore: cast_nullable_to_non_nullable
              as List<CategoriesDetailList>?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
      speakers: speakers == freezed
          ? _value.speakers
          : speakers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<HostDetail>?,
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as int?,
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

  @override
  $HostDetailCopyWith<$Res>? get hostDetail {
    if (_value.hostDetail == null) {
      return null;
    }

    return $HostDetailCopyWith<$Res>(_value.hostDetail!, (value) {
      return _then(_value.copyWith(hostDetail: value));
    });
  }

  @override
  $RecordingDetailsCopyWith<$Res>? get recordingDetails {
    if (_value.recordingDetails == null) {
      return null;
    }

    return $RecordingDetailsCopyWith<$Res>(_value.recordingDetails!, (value) {
      return _then(_value.copyWith(recordingDetails: value));
    });
  }
}

/// @nodoc
abstract class _$GroupsDetailListCopyWith<$Res>
    implements $GroupsDetailListCopyWith<$Res> {
  factory _$GroupsDetailListCopyWith(
          _GroupsDetailList value, $Res Function(_GroupsDetailList) then) =
      __$GroupsDetailListCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String? host,
      int? topic,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      @JsonKey(name: "closed_at")
          DateTime? closedAt,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      @JsonKey(name: "host_profile_details")
          UserProfileModel? hostProfileDetails,
      int? type,
      @JsonKey(name: "is_live")
          bool? isLive,
      @JsonKey(name: "live_count")
          int? liveCount,
      bool? rsvp,
      bool? isPast,
      @JsonKey(name: "is_featured")
          bool? isFeatured,
      List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          RecordingDetails? recordingDetails,
      List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          List<HostDetail>? speakersDetailList,
      int? series});

  @override
  $TopicCopyWith<$Res>? get topicDetail;
  @override
  $HostDetailCopyWith<$Res>? get hostDetail;
  @override
  $RecordingDetailsCopyWith<$Res>? get recordingDetails;
}

/// @nodoc
class __$GroupsDetailListCopyWithImpl<$Res>
    extends _$GroupsDetailListCopyWithImpl<$Res>
    implements _$GroupsDetailListCopyWith<$Res> {
  __$GroupsDetailListCopyWithImpl(
      _GroupsDetailList _value, $Res Function(_GroupsDetailList) _then)
      : super(_value, (v) => _then(v as _GroupsDetailList));

  @override
  _GroupsDetailList get _value => super._value as _GroupsDetailList;

  @override
  $Res call({
    Object? id = freezed,
    Object? host = freezed,
    Object? topic = freezed,
    Object? description = freezed,
    Object? start = freezed,
    Object? privacy = freezed,
    Object? medium = freezed,
    Object? closed = freezed,
    Object? closedAt = freezed,
    Object? topicDetail = freezed,
    Object? hostDetail = freezed,
    Object? hostProfileDetails = freezed,
    Object? type = freezed,
    Object? isLive = freezed,
    Object? liveCount = freezed,
    Object? rsvp = freezed,
    Object? isPast = freezed,
    Object? isFeatured = freezed,
    Object? categories = freezed,
    Object? categoriesDetailList = freezed,
    Object? recordingDetails = freezed,
    Object? speakers = freezed,
    Object? speakersDetailList = freezed,
    Object? series = freezed,
  }) {
    return _then(_GroupsDetailList(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      host: host == freezed
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String?,
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      start: start == freezed
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as int?,
      medium: medium == freezed
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as int?,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool?,
      closedAt: closedAt == freezed
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      topicDetail: topicDetail == freezed
          ? _value.topicDetail
          : topicDetail // ignore: cast_nullable_to_non_nullable
              as Topic?,
      hostDetail: hostDetail == freezed
          ? _value.hostDetail
          : hostDetail // ignore: cast_nullable_to_non_nullable
              as HostDetail?,
      hostProfileDetails: hostProfileDetails == freezed
          ? _value.hostProfileDetails
          : hostProfileDetails // ignore: cast_nullable_to_non_nullable
              as UserProfileModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      isLive: isLive == freezed
          ? _value.isLive
          : isLive // ignore: cast_nullable_to_non_nullable
              as bool?,
      liveCount: liveCount == freezed
          ? _value.liveCount
          : liveCount // ignore: cast_nullable_to_non_nullable
              as int?,
      rsvp: rsvp == freezed
          ? _value.rsvp
          : rsvp // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPast: isPast == freezed
          ? _value.isPast
          : isPast // ignore: cast_nullable_to_non_nullable
              as bool?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value.categoriesDetailList
          : categoriesDetailList // ignore: cast_nullable_to_non_nullable
              as List<CategoriesDetailList>?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
      speakers: speakers == freezed
          ? _value.speakers
          : speakers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      speakersDetailList: speakersDetailList == freezed
          ? _value.speakersDetailList
          : speakersDetailList // ignore: cast_nullable_to_non_nullable
              as List<HostDetail>?,
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupsDetailList implements _GroupsDetailList {
  const _$_GroupsDetailList(
      {this.id,
      this.host,
      this.topic,
      this.description,
      this.start,
      this.privacy,
      this.medium,
      this.closed,
      @JsonKey(name: "closed_at") this.closedAt,
      @JsonKey(name: "topic_detail") this.topicDetail,
      @JsonKey(name: "host_detail") this.hostDetail,
      @JsonKey(name: "host_profile_details") this.hostProfileDetails,
      this.type,
      @JsonKey(name: "is_live") this.isLive,
      @JsonKey(name: "live_count") this.liveCount,
      this.rsvp,
      this.isPast,
      @JsonKey(name: "is_featured") this.isFeatured,
      this.categories,
      @JsonKey(name: "categories_detail_list") this.categoriesDetailList,
      @JsonKey(name: "recording_details") this.recordingDetails,
      this.speakers,
      @JsonKey(name: "speakers_detail_list") this.speakersDetailList,
      this.series});

  factory _$_GroupsDetailList.fromJson(Map<String, dynamic> json) =>
      _$_$_GroupsDetailListFromJson(json);

  @override
  final int? id;
  @override
  final String? host;
  @override
  final int? topic;
  @override
  final String? description;
  @override
  final DateTime? start;
  @override
  final int? privacy;
  @override
  final int? medium;
  @override
  final bool? closed;
  @override
  @JsonKey(name: "closed_at")
  final DateTime? closedAt;
  @override
  @JsonKey(name: "topic_detail")
  final Topic? topicDetail;
  @override
  @JsonKey(name: "host_detail")
  final HostDetail? hostDetail;
  @override
  @JsonKey(name: "host_profile_details")
  final UserProfileModel? hostProfileDetails;
  @override
  final int? type;
  @override
  @JsonKey(name: "is_live")
  final bool? isLive;
  @override
  @JsonKey(name: "live_count")
  final int? liveCount;
  @override
  final bool? rsvp;
  @override
  final bool? isPast;
  @override
  @JsonKey(name: "is_featured")
  final bool? isFeatured;
  @override
  final List<int>? categories;
  @override
  @JsonKey(name: "categories_detail_list")
  final List<CategoriesDetailList>? categoriesDetailList;
  @override
  @JsonKey(name: "recording_details")
  final RecordingDetails? recordingDetails;
  @override
  final List<String>? speakers;
  @override
  @JsonKey(name: "speakers_detail_list")
  final List<HostDetail>? speakersDetailList;
  @override
  final int? series;

  @override
  String toString() {
    return 'GroupsDetailList(id: $id, host: $host, topic: $topic, description: $description, start: $start, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, hostProfileDetails: $hostProfileDetails, type: $type, isLive: $isLive, liveCount: $liveCount, rsvp: $rsvp, isPast: $isPast, isFeatured: $isFeatured, categories: $categories, categoriesDetailList: $categoriesDetailList, recordingDetails: $recordingDetails, speakers: $speakers, speakersDetailList: $speakersDetailList, series: $series)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GroupsDetailList &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.host, host) ||
                const DeepCollectionEquality().equals(other.host, host)) &&
            (identical(other.topic, topic) ||
                const DeepCollectionEquality().equals(other.topic, topic)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
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
            (identical(other.hostProfileDetails, hostProfileDetails) ||
                const DeepCollectionEquality()
                    .equals(other.hostProfileDetails, hostProfileDetails)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isLive, isLive) ||
                const DeepCollectionEquality().equals(other.isLive, isLive)) &&
            (identical(other.liveCount, liveCount) ||
                const DeepCollectionEquality()
                    .equals(other.liveCount, liveCount)) &&
            (identical(other.rsvp, rsvp) ||
                const DeepCollectionEquality().equals(other.rsvp, rsvp)) &&
            (identical(other.isPast, isPast) ||
                const DeepCollectionEquality().equals(other.isPast, isPast)) &&
            (identical(other.isFeatured, isFeatured) ||
                const DeepCollectionEquality()
                    .equals(other.isFeatured, isFeatured)) &&
            (identical(other.categories, categories) ||
                const DeepCollectionEquality()
                    .equals(other.categories, categories)) &&
            (identical(other.categoriesDetailList, categoriesDetailList) ||
                const DeepCollectionEquality().equals(
                    other.categoriesDetailList, categoriesDetailList)) &&
            (identical(other.recordingDetails, recordingDetails) ||
                const DeepCollectionEquality()
                    .equals(other.recordingDetails, recordingDetails)) &&
            (identical(other.speakers, speakers) ||
                const DeepCollectionEquality()
                    .equals(other.speakers, speakers)) &&
            (identical(other.speakersDetailList, speakersDetailList) ||
                const DeepCollectionEquality()
                    .equals(other.speakersDetailList, speakersDetailList)) &&
            (identical(other.series, series) ||
                const DeepCollectionEquality().equals(other.series, series)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(host) ^
      const DeepCollectionEquality().hash(topic) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(privacy) ^
      const DeepCollectionEquality().hash(medium) ^
      const DeepCollectionEquality().hash(closed) ^
      const DeepCollectionEquality().hash(closedAt) ^
      const DeepCollectionEquality().hash(topicDetail) ^
      const DeepCollectionEquality().hash(hostDetail) ^
      const DeepCollectionEquality().hash(hostProfileDetails) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isLive) ^
      const DeepCollectionEquality().hash(liveCount) ^
      const DeepCollectionEquality().hash(rsvp) ^
      const DeepCollectionEquality().hash(isPast) ^
      const DeepCollectionEquality().hash(isFeatured) ^
      const DeepCollectionEquality().hash(categories) ^
      const DeepCollectionEquality().hash(categoriesDetailList) ^
      const DeepCollectionEquality().hash(recordingDetails) ^
      const DeepCollectionEquality().hash(speakers) ^
      const DeepCollectionEquality().hash(speakersDetailList) ^
      const DeepCollectionEquality().hash(series);

  @JsonKey(ignore: true)
  @override
  _$GroupsDetailListCopyWith<_GroupsDetailList> get copyWith =>
      __$GroupsDetailListCopyWithImpl<_GroupsDetailList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GroupsDetailListToJson(this);
  }
}

abstract class _GroupsDetailList implements GroupsDetailList {
  const factory _GroupsDetailList(
      {int? id,
      String? host,
      int? topic,
      String? description,
      DateTime? start,
      int? privacy,
      int? medium,
      bool? closed,
      @JsonKey(name: "closed_at")
          DateTime? closedAt,
      @JsonKey(name: "topic_detail")
          Topic? topicDetail,
      @JsonKey(name: "host_detail")
          HostDetail? hostDetail,
      @JsonKey(name: "host_profile_details")
          UserProfileModel? hostProfileDetails,
      int? type,
      @JsonKey(name: "is_live")
          bool? isLive,
      @JsonKey(name: "live_count")
          int? liveCount,
      bool? rsvp,
      bool? isPast,
      @JsonKey(name: "is_featured")
          bool? isFeatured,
      List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          RecordingDetails? recordingDetails,
      List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          List<HostDetail>? speakersDetailList,
      int? series}) = _$_GroupsDetailList;

  factory _GroupsDetailList.fromJson(Map<String, dynamic> json) =
      _$_GroupsDetailList.fromJson;

  @override
  int? get id => throw _privateConstructorUsedError;
  @override
  String? get host => throw _privateConstructorUsedError;
  @override
  int? get topic => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  DateTime? get start => throw _privateConstructorUsedError;
  @override
  int? get privacy => throw _privateConstructorUsedError;
  @override
  int? get medium => throw _privateConstructorUsedError;
  @override
  bool? get closed => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "closed_at")
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "host_profile_details")
  UserProfileModel? get hostProfileDetails =>
      throw _privateConstructorUsedError;
  @override
  int? get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "is_live")
  bool? get isLive => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "live_count")
  int? get liveCount => throw _privateConstructorUsedError;
  @override
  bool? get rsvp => throw _privateConstructorUsedError;
  @override
  bool? get isPast => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "is_featured")
  bool? get isFeatured => throw _privateConstructorUsedError;
  @override
  List<int>? get categories => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "categories_detail_list")
  List<CategoriesDetailList>? get categoriesDetailList =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "recording_details")
  RecordingDetails? get recordingDetails => throw _privateConstructorUsedError;
  @override
  List<String>? get speakers => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "speakers_detail_list")
  List<HostDetail>? get speakersDetailList =>
      throw _privateConstructorUsedError;
  @override
  int? get series => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupsDetailListCopyWith<_GroupsDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoriesDetailList _$CategoriesDetailListFromJson(Map<String, dynamic> json) {
  return _CategoriesDetailList.fromJson(json);
}

/// @nodoc
class _$CategoriesDetailListTearOff {
  const _$CategoriesDetailListTearOff();

  _CategoriesDetailList call(
      {int? pk, String? name, String? color, String? photo, String? order}) {
    return _CategoriesDetailList(
      pk: pk,
      name: name,
      color: color,
      photo: photo,
      order: order,
    );
  }

  CategoriesDetailList fromJson(Map<String, Object> json) {
    return CategoriesDetailList.fromJson(json);
  }
}

/// @nodoc
const $CategoriesDetailList = _$CategoriesDetailListTearOff();

/// @nodoc
mixin _$CategoriesDetailList {
  int? get pk => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoriesDetailListCopyWith<CategoriesDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesDetailListCopyWith<$Res> {
  factory $CategoriesDetailListCopyWith(CategoriesDetailList value,
          $Res Function(CategoriesDetailList) then) =
      _$CategoriesDetailListCopyWithImpl<$Res>;
  $Res call(
      {int? pk, String? name, String? color, String? photo, String? order});
}

/// @nodoc
class _$CategoriesDetailListCopyWithImpl<$Res>
    implements $CategoriesDetailListCopyWith<$Res> {
  _$CategoriesDetailListCopyWithImpl(this._value, this._then);

  final CategoriesDetailList _value;
  // ignore: unused_field
  final $Res Function(CategoriesDetailList) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? photo = freezed,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$CategoriesDetailListCopyWith<$Res>
    implements $CategoriesDetailListCopyWith<$Res> {
  factory _$CategoriesDetailListCopyWith(_CategoriesDetailList value,
          $Res Function(_CategoriesDetailList) then) =
      __$CategoriesDetailListCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk, String? name, String? color, String? photo, String? order});
}

/// @nodoc
class __$CategoriesDetailListCopyWithImpl<$Res>
    extends _$CategoriesDetailListCopyWithImpl<$Res>
    implements _$CategoriesDetailListCopyWith<$Res> {
  __$CategoriesDetailListCopyWithImpl(
      _CategoriesDetailList _value, $Res Function(_CategoriesDetailList) _then)
      : super(_value, (v) => _then(v as _CategoriesDetailList));

  @override
  _CategoriesDetailList get _value => super._value as _CategoriesDetailList;

  @override
  $Res call({
    Object? pk = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? photo = freezed,
    Object? order = freezed,
  }) {
    return _then(_CategoriesDetailList(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      order: order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CategoriesDetailList implements _CategoriesDetailList {
  const _$_CategoriesDetailList(
      {this.pk, this.name, this.color, this.photo, this.order});

  factory _$_CategoriesDetailList.fromJson(Map<String, dynamic> json) =>
      _$_$_CategoriesDetailListFromJson(json);

  @override
  final int? pk;
  @override
  final String? name;
  @override
  final String? color;
  @override
  final String? photo;
  @override
  final String? order;

  @override
  String toString() {
    return 'CategoriesDetailList(pk: $pk, name: $name, color: $color, photo: $photo, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CategoriesDetailList &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(order);

  @JsonKey(ignore: true)
  @override
  _$CategoriesDetailListCopyWith<_CategoriesDetailList> get copyWith =>
      __$CategoriesDetailListCopyWithImpl<_CategoriesDetailList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CategoriesDetailListToJson(this);
  }
}

abstract class _CategoriesDetailList implements CategoriesDetailList {
  const factory _CategoriesDetailList(
      {int? pk,
      String? name,
      String? color,
      String? photo,
      String? order}) = _$_CategoriesDetailList;

  factory _CategoriesDetailList.fromJson(Map<String, dynamic> json) =
      _$_CategoriesDetailList.fromJson;

  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get color => throw _privateConstructorUsedError;
  @override
  String? get photo => throw _privateConstructorUsedError;
  @override
  String? get order => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CategoriesDetailListCopyWith<_CategoriesDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

HostDetail _$HostDetailFromJson(Map<String, dynamic> json) {
  return _HostDetail.fromJson(json);
}

/// @nodoc
class _$HostDetailTearOff {
  const _$HostDetailTearOff();

  _HostDetail call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: "creator_detail") Creator? creatorDetail}) {
    return _HostDetail(
      pk: pk,
      email: email,
      name: name,
      photo: photo,
      introduction: introduction,
      creatorDetail: creatorDetail,
    );
  }

  HostDetail fromJson(Map<String, Object> json) {
    return HostDetail.fromJson(json);
  }
}

/// @nodoc
const $HostDetail = _$HostDetailTearOff();

/// @nodoc
mixin _$HostDetail {
  String? get pk => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;
  @JsonKey(name: "creator_detail")
  Creator? get creatorDetail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HostDetailCopyWith<HostDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostDetailCopyWith<$Res> {
  factory $HostDetailCopyWith(
          HostDetail value, $Res Function(HostDetail) then) =
      _$HostDetailCopyWithImpl<$Res>;
  $Res call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: "creator_detail") Creator? creatorDetail});

  $CreatorCopyWith<$Res>? get creatorDetail;
}

/// @nodoc
class _$HostDetailCopyWithImpl<$Res> implements $HostDetailCopyWith<$Res> {
  _$HostDetailCopyWithImpl(this._value, this._then);

  final HostDetail _value;
  // ignore: unused_field
  final $Res Function(HostDetail) _then;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_value.copyWith(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorDetail: creatorDetail == freezed
          ? _value.creatorDetail
          : creatorDetail // ignore: cast_nullable_to_non_nullable
              as Creator?,
    ));
  }

  @override
  $CreatorCopyWith<$Res>? get creatorDetail {
    if (_value.creatorDetail == null) {
      return null;
    }

    return $CreatorCopyWith<$Res>(_value.creatorDetail!, (value) {
      return _then(_value.copyWith(creatorDetail: value));
    });
  }
}

/// @nodoc
abstract class _$HostDetailCopyWith<$Res> implements $HostDetailCopyWith<$Res> {
  factory _$HostDetailCopyWith(
          _HostDetail value, $Res Function(_HostDetail) then) =
      __$HostDetailCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: "creator_detail") Creator? creatorDetail});

  @override
  $CreatorCopyWith<$Res>? get creatorDetail;
}

/// @nodoc
class __$HostDetailCopyWithImpl<$Res> extends _$HostDetailCopyWithImpl<$Res>
    implements _$HostDetailCopyWith<$Res> {
  __$HostDetailCopyWithImpl(
      _HostDetail _value, $Res Function(_HostDetail) _then)
      : super(_value, (v) => _then(v as _HostDetail));

  @override
  _HostDetail get _value => super._value as _HostDetail;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_HostDetail(
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: introduction == freezed
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorDetail: creatorDetail == freezed
          ? _value.creatorDetail
          : creatorDetail // ignore: cast_nullable_to_non_nullable
              as Creator?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HostDetail implements _HostDetail {
  const _$_HostDetail(
      {this.pk,
      this.email,
      this.name,
      this.photo,
      this.introduction,
      @JsonKey(name: "creator_detail") this.creatorDetail});

  factory _$_HostDetail.fromJson(Map<String, dynamic> json) =>
      _$_$_HostDetailFromJson(json);

  @override
  final String? pk;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? photo;
  @override
  final String? introduction;
  @override
  @JsonKey(name: "creator_detail")
  final Creator? creatorDetail;

  @override
  String toString() {
    return 'HostDetail(pk: $pk, email: $email, name: $name, photo: $photo, introduction: $introduction, creatorDetail: $creatorDetail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HostDetail &&
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
                    .equals(other.introduction, introduction)) &&
            (identical(other.creatorDetail, creatorDetail) ||
                const DeepCollectionEquality()
                    .equals(other.creatorDetail, creatorDetail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pk) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(introduction) ^
      const DeepCollectionEquality().hash(creatorDetail);

  @JsonKey(ignore: true)
  @override
  _$HostDetailCopyWith<_HostDetail> get copyWith =>
      __$HostDetailCopyWithImpl<_HostDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HostDetailToJson(this);
  }
}

abstract class _HostDetail implements HostDetail {
  const factory _HostDetail(
      {String? pk,
      String? email,
      String? name,
      String? photo,
      String? introduction,
      @JsonKey(name: "creator_detail") Creator? creatorDetail}) = _$_HostDetail;

  factory _HostDetail.fromJson(Map<String, dynamic> json) =
      _$_HostDetail.fromJson;

  @override
  String? get pk => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get photo => throw _privateConstructorUsedError;
  @override
  String? get introduction => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "creator_detail")
  Creator? get creatorDetail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HostDetailCopyWith<_HostDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
class _$GroupTearOff {
  const _$GroupTearOff();

  _Group call({String? name, int? pk}) {
    return _Group(
      name: name,
      pk: pk,
    );
  }

  Group fromJson(Map<String, Object> json) {
    return Group.fromJson(json);
  }
}

/// @nodoc
const $Group = _$GroupTearOff();

/// @nodoc
mixin _$Group {
  String? get name => throw _privateConstructorUsedError;
  int? get pk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res>;
  $Res call({String? name, int? pk});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res> implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  final Group _value;
  // ignore: unused_field
  final $Res Function(Group) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? pk = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) then) =
      __$GroupCopyWithImpl<$Res>;
  @override
  $Res call({String? name, int? pk});
}

/// @nodoc
class __$GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(_Group _value, $Res Function(_Group) _then)
      : super(_value, (v) => _then(v as _Group));

  @override
  _Group get _value => super._value as _Group;

  @override
  $Res call({
    Object? name = freezed,
    Object? pk = freezed,
  }) {
    return _then(_Group(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      pk: pk == freezed
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group implements _Group {
  const _$_Group({this.name, this.pk});

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$_$_GroupFromJson(json);

  @override
  final String? name;
  @override
  final int? pk;

  @override
  String toString() {
    return 'Group(name: $name, pk: $pk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Group &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.pk, pk) ||
                const DeepCollectionEquality().equals(other.pk, pk)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(pk);

  @JsonKey(ignore: true)
  @override
  _$GroupCopyWith<_Group> get copyWith =>
      __$GroupCopyWithImpl<_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GroupToJson(this);
  }
}

abstract class _Group implements Group {
  const factory _Group({String? name, int? pk}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  int? get pk => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupCopyWith<_Group> get copyWith => throw _privateConstructorUsedError;
}
