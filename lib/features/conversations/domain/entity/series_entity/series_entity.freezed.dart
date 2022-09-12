// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'series_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return _Series.fromJson(json);
}

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
abstract class _$$_SeriesCopyWith<$Res> implements $SeriesCopyWith<$Res> {
  factory _$$_SeriesCopyWith(_$_Series value, $Res Function(_$_Series) then) =
      __$$_SeriesCopyWithImpl<$Res>;
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
class __$$_SeriesCopyWithImpl<$Res> extends _$SeriesCopyWithImpl<$Res>
    implements _$$_SeriesCopyWith<$Res> {
  __$$_SeriesCopyWithImpl(_$_Series _value, $Res Function(_$_Series) _then)
      : super(_value, (v) => _then(v as _$_Series));

  @override
  _$_Series get _value => super._value as _$_Series;

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
    return _then(_$_Series(
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
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      groupsDetailList: groupsDetailList == freezed
          ? _value._groupsDetailList
          : groupsDetailList // ignore: cast_nullable_to_non_nullable
              as List<GroupsDetailList>?,
      categories: categories == freezed
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value._categoriesDetailList
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
      @JsonKey(name: "topic_detail")
          this.topicDetail,
      final List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          final List<GroupsDetailList>? groupsDetailList,
      final List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          final List<dynamic>? categoriesDetailList,
      this.host,
      @JsonKey(name: "host_detail")
          this.hostDetail,
      this.start,
      @JsonKey(name: "created_at")
          this.createdAt})
      : _groups = groups,
        _groupsDetailList = groupsDetailList,
        _categories = categories,
        _categoriesDetailList = categoriesDetailList;

  factory _$_Series.fromJson(Map<String, dynamic> json) =>
      _$$_SeriesFromJson(json);

  @override
  final int? id;
  @override
  final int? topic;
  @override
  @JsonKey(name: "topic_detail")
  final Topic? topicDetail;
  final List<int>? _groups;
  @override
  List<int>? get groups {
    final value = _groups;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GroupsDetailList>? _groupsDetailList;
  @override
  @JsonKey(name: "groups_detail_list")
  List<GroupsDetailList>? get groupsDetailList {
    final value = _groupsDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _categories;
  @override
  List<dynamic>? get categories {
    final value = _categories;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _categoriesDetailList;
  @override
  @JsonKey(name: "categories_detail_list")
  List<dynamic>? get categoriesDetailList {
    final value = _categoriesDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
        (other.runtimeType == runtimeType &&
            other is _$_Series &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality()
                .equals(other.topicDetail, topicDetail) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality()
                .equals(other._groupsDetailList, _groupsDetailList) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesDetailList, _categoriesDetailList) &&
            const DeepCollectionEquality().equals(other.host, host) &&
            const DeepCollectionEquality()
                .equals(other.hostDetail, hostDetail) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(topic),
      const DeepCollectionEquality().hash(topicDetail),
      const DeepCollectionEquality().hash(_groups),
      const DeepCollectionEquality().hash(_groupsDetailList),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoriesDetailList),
      const DeepCollectionEquality().hash(host),
      const DeepCollectionEquality().hash(hostDetail),
      const DeepCollectionEquality().hash(start),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_SeriesCopyWith<_$_Series> get copyWith =>
      __$$_SeriesCopyWithImpl<_$_Series>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeriesToJson(this);
  }
}

abstract class _Series implements Series {
  const factory _Series(
      {final int? id,
      final int? topic,
      @JsonKey(name: "topic_detail")
          final Topic? topicDetail,
      final List<int>? groups,
      @JsonKey(name: "groups_detail_list")
          final List<GroupsDetailList>? groupsDetailList,
      final List<dynamic>? categories,
      @JsonKey(name: "categories_detail_list")
          final List<dynamic>? categoriesDetailList,
      final String? host,
      @JsonKey(name: "host_detail")
          final HostDetail? hostDetail,
      final DateTime? start,
      @JsonKey(name: "created_at")
          final DateTime? createdAt}) = _$_Series;

  factory _Series.fromJson(Map<String, dynamic> json) = _$_Series.fromJson;

  @override
  int? get id;
  @override
  int? get topic;
  @override
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail;
  @override
  List<int>? get groups;
  @override
  @JsonKey(name: "groups_detail_list")
  List<GroupsDetailList>? get groupsDetailList;
  @override
  List<dynamic>? get categories;
  @override
  @JsonKey(name: "categories_detail_list")
  List<dynamic>? get categoriesDetailList;
  @override
  String? get host;
  @override
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail;
  @override
  DateTime? get start;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_SeriesCopyWith<_$_Series> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupsDetailList _$GroupsDetailListFromJson(Map<String, dynamic> json) {
  return _GroupsDetailList.fromJson(json);
}

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
abstract class _$$_GroupsDetailListCopyWith<$Res>
    implements $GroupsDetailListCopyWith<$Res> {
  factory _$$_GroupsDetailListCopyWith(
          _$_GroupsDetailList value, $Res Function(_$_GroupsDetailList) then) =
      __$$_GroupsDetailListCopyWithImpl<$Res>;
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
class __$$_GroupsDetailListCopyWithImpl<$Res>
    extends _$GroupsDetailListCopyWithImpl<$Res>
    implements _$$_GroupsDetailListCopyWith<$Res> {
  __$$_GroupsDetailListCopyWithImpl(
      _$_GroupsDetailList _value, $Res Function(_$_GroupsDetailList) _then)
      : super(_value, (v) => _then(v as _$_GroupsDetailList));

  @override
  _$_GroupsDetailList get _value => super._value as _$_GroupsDetailList;

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
    return _then(_$_GroupsDetailList(
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
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      categoriesDetailList: categoriesDetailList == freezed
          ? _value._categoriesDetailList
          : categoriesDetailList // ignore: cast_nullable_to_non_nullable
              as List<CategoriesDetailList>?,
      recordingDetails: recordingDetails == freezed
          ? _value.recordingDetails
          : recordingDetails // ignore: cast_nullable_to_non_nullable
              as RecordingDetails?,
      speakers: speakers == freezed
          ? _value._speakers
          : speakers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      speakersDetailList: speakersDetailList == freezed
          ? _value._speakersDetailList
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
      @JsonKey(name: "closed_at")
          this.closedAt,
      @JsonKey(name: "topic_detail")
          this.topicDetail,
      @JsonKey(name: "host_detail")
          this.hostDetail,
      @JsonKey(name: "host_profile_details")
          this.hostProfileDetails,
      this.type,
      @JsonKey(name: "is_live")
          this.isLive,
      @JsonKey(name: "live_count")
          this.liveCount,
      this.rsvp,
      this.isPast,
      @JsonKey(name: "is_featured")
          this.isFeatured,
      final List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          final List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          this.recordingDetails,
      final List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          final List<HostDetail>? speakersDetailList,
      this.series})
      : _categories = categories,
        _categoriesDetailList = categoriesDetailList,
        _speakers = speakers,
        _speakersDetailList = speakersDetailList;

  factory _$_GroupsDetailList.fromJson(Map<String, dynamic> json) =>
      _$$_GroupsDetailListFromJson(json);

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
  final List<int>? _categories;
  @override
  List<int>? get categories {
    final value = _categories;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CategoriesDetailList>? _categoriesDetailList;
  @override
  @JsonKey(name: "categories_detail_list")
  List<CategoriesDetailList>? get categoriesDetailList {
    final value = _categoriesDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "recording_details")
  final RecordingDetails? recordingDetails;
  final List<String>? _speakers;
  @override
  List<String>? get speakers {
    final value = _speakers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<HostDetail>? _speakersDetailList;
  @override
  @JsonKey(name: "speakers_detail_list")
  List<HostDetail>? get speakersDetailList {
    final value = _speakersDetailList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? series;

  @override
  String toString() {
    return 'GroupsDetailList(id: $id, host: $host, topic: $topic, description: $description, start: $start, privacy: $privacy, medium: $medium, closed: $closed, closedAt: $closedAt, topicDetail: $topicDetail, hostDetail: $hostDetail, hostProfileDetails: $hostProfileDetails, type: $type, isLive: $isLive, liveCount: $liveCount, rsvp: $rsvp, isPast: $isPast, isFeatured: $isFeatured, categories: $categories, categoriesDetailList: $categoriesDetailList, recordingDetails: $recordingDetails, speakers: $speakers, speakersDetailList: $speakersDetailList, series: $series)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupsDetailList &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.host, host) &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.start, start) &&
            const DeepCollectionEquality().equals(other.privacy, privacy) &&
            const DeepCollectionEquality().equals(other.medium, medium) &&
            const DeepCollectionEquality().equals(other.closed, closed) &&
            const DeepCollectionEquality().equals(other.closedAt, closedAt) &&
            const DeepCollectionEquality()
                .equals(other.topicDetail, topicDetail) &&
            const DeepCollectionEquality()
                .equals(other.hostDetail, hostDetail) &&
            const DeepCollectionEquality()
                .equals(other.hostProfileDetails, hostProfileDetails) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.isLive, isLive) &&
            const DeepCollectionEquality().equals(other.liveCount, liveCount) &&
            const DeepCollectionEquality().equals(other.rsvp, rsvp) &&
            const DeepCollectionEquality().equals(other.isPast, isPast) &&
            const DeepCollectionEquality()
                .equals(other.isFeatured, isFeatured) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesDetailList, _categoriesDetailList) &&
            const DeepCollectionEquality()
                .equals(other.recordingDetails, recordingDetails) &&
            const DeepCollectionEquality().equals(other._speakers, _speakers) &&
            const DeepCollectionEquality()
                .equals(other._speakersDetailList, _speakersDetailList) &&
            const DeepCollectionEquality().equals(other.series, series));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(host),
        const DeepCollectionEquality().hash(topic),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(start),
        const DeepCollectionEquality().hash(privacy),
        const DeepCollectionEquality().hash(medium),
        const DeepCollectionEquality().hash(closed),
        const DeepCollectionEquality().hash(closedAt),
        const DeepCollectionEquality().hash(topicDetail),
        const DeepCollectionEquality().hash(hostDetail),
        const DeepCollectionEquality().hash(hostProfileDetails),
        const DeepCollectionEquality().hash(type),
        const DeepCollectionEquality().hash(isLive),
        const DeepCollectionEquality().hash(liveCount),
        const DeepCollectionEquality().hash(rsvp),
        const DeepCollectionEquality().hash(isPast),
        const DeepCollectionEquality().hash(isFeatured),
        const DeepCollectionEquality().hash(_categories),
        const DeepCollectionEquality().hash(_categoriesDetailList),
        const DeepCollectionEquality().hash(recordingDetails),
        const DeepCollectionEquality().hash(_speakers),
        const DeepCollectionEquality().hash(_speakersDetailList),
        const DeepCollectionEquality().hash(series)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_GroupsDetailListCopyWith<_$_GroupsDetailList> get copyWith =>
      __$$_GroupsDetailListCopyWithImpl<_$_GroupsDetailList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupsDetailListToJson(this);
  }
}

abstract class _GroupsDetailList implements GroupsDetailList {
  const factory _GroupsDetailList(
      {final int? id,
      final String? host,
      final int? topic,
      final String? description,
      final DateTime? start,
      final int? privacy,
      final int? medium,
      final bool? closed,
      @JsonKey(name: "closed_at")
          final DateTime? closedAt,
      @JsonKey(name: "topic_detail")
          final Topic? topicDetail,
      @JsonKey(name: "host_detail")
          final HostDetail? hostDetail,
      @JsonKey(name: "host_profile_details")
          final UserProfileModel? hostProfileDetails,
      final int? type,
      @JsonKey(name: "is_live")
          final bool? isLive,
      @JsonKey(name: "live_count")
          final int? liveCount,
      final bool? rsvp,
      final bool? isPast,
      @JsonKey(name: "is_featured")
          final bool? isFeatured,
      final List<int>? categories,
      @JsonKey(name: "categories_detail_list")
          final List<CategoriesDetailList>? categoriesDetailList,
      @JsonKey(name: "recording_details")
          final RecordingDetails? recordingDetails,
      final List<String>? speakers,
      @JsonKey(name: "speakers_detail_list")
          final List<HostDetail>? speakersDetailList,
      final int? series}) = _$_GroupsDetailList;

  factory _GroupsDetailList.fromJson(Map<String, dynamic> json) =
      _$_GroupsDetailList.fromJson;

  @override
  int? get id;
  @override
  String? get host;
  @override
  int? get topic;
  @override
  String? get description;
  @override
  DateTime? get start;
  @override
  int? get privacy;
  @override
  int? get medium;
  @override
  bool? get closed;
  @override
  @JsonKey(name: "closed_at")
  DateTime? get closedAt;
  @override
  @JsonKey(name: "topic_detail")
  Topic? get topicDetail;
  @override
  @JsonKey(name: "host_detail")
  HostDetail? get hostDetail;
  @override
  @JsonKey(name: "host_profile_details")
  UserProfileModel? get hostProfileDetails;
  @override
  int? get type;
  @override
  @JsonKey(name: "is_live")
  bool? get isLive;
  @override
  @JsonKey(name: "live_count")
  int? get liveCount;
  @override
  bool? get rsvp;
  @override
  bool? get isPast;
  @override
  @JsonKey(name: "is_featured")
  bool? get isFeatured;
  @override
  List<int>? get categories;
  @override
  @JsonKey(name: "categories_detail_list")
  List<CategoriesDetailList>? get categoriesDetailList;
  @override
  @JsonKey(name: "recording_details")
  RecordingDetails? get recordingDetails;
  @override
  List<String>? get speakers;
  @override
  @JsonKey(name: "speakers_detail_list")
  List<HostDetail>? get speakersDetailList;
  @override
  int? get series;
  @override
  @JsonKey(ignore: true)
  _$$_GroupsDetailListCopyWith<_$_GroupsDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoriesDetailList _$CategoriesDetailListFromJson(Map<String, dynamic> json) {
  return _CategoriesDetailList.fromJson(json);
}

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
abstract class _$$_CategoriesDetailListCopyWith<$Res>
    implements $CategoriesDetailListCopyWith<$Res> {
  factory _$$_CategoriesDetailListCopyWith(_$_CategoriesDetailList value,
          $Res Function(_$_CategoriesDetailList) then) =
      __$$_CategoriesDetailListCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? pk, String? name, String? color, String? photo, String? order});
}

/// @nodoc
class __$$_CategoriesDetailListCopyWithImpl<$Res>
    extends _$CategoriesDetailListCopyWithImpl<$Res>
    implements _$$_CategoriesDetailListCopyWith<$Res> {
  __$$_CategoriesDetailListCopyWithImpl(_$_CategoriesDetailList _value,
      $Res Function(_$_CategoriesDetailList) _then)
      : super(_value, (v) => _then(v as _$_CategoriesDetailList));

  @override
  _$_CategoriesDetailList get _value => super._value as _$_CategoriesDetailList;

  @override
  $Res call({
    Object? pk = freezed,
    Object? name = freezed,
    Object? color = freezed,
    Object? photo = freezed,
    Object? order = freezed,
  }) {
    return _then(_$_CategoriesDetailList(
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
      _$$_CategoriesDetailListFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _$_CategoriesDetailList &&
            const DeepCollectionEquality().equals(other.pk, pk) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality().equals(other.order, order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pk),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(order));

  @JsonKey(ignore: true)
  @override
  _$$_CategoriesDetailListCopyWith<_$_CategoriesDetailList> get copyWith =>
      __$$_CategoriesDetailListCopyWithImpl<_$_CategoriesDetailList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoriesDetailListToJson(this);
  }
}

abstract class _CategoriesDetailList implements CategoriesDetailList {
  const factory _CategoriesDetailList(
      {final int? pk,
      final String? name,
      final String? color,
      final String? photo,
      final String? order}) = _$_CategoriesDetailList;

  factory _CategoriesDetailList.fromJson(Map<String, dynamic> json) =
      _$_CategoriesDetailList.fromJson;

  @override
  int? get pk;
  @override
  String? get name;
  @override
  String? get color;
  @override
  String? get photo;
  @override
  String? get order;
  @override
  @JsonKey(ignore: true)
  _$$_CategoriesDetailListCopyWith<_$_CategoriesDetailList> get copyWith =>
      throw _privateConstructorUsedError;
}

HostDetail _$HostDetailFromJson(Map<String, dynamic> json) {
  return _HostDetail.fromJson(json);
}

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
abstract class _$$_HostDetailCopyWith<$Res>
    implements $HostDetailCopyWith<$Res> {
  factory _$$_HostDetailCopyWith(
          _$_HostDetail value, $Res Function(_$_HostDetail) then) =
      __$$_HostDetailCopyWithImpl<$Res>;
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
class __$$_HostDetailCopyWithImpl<$Res> extends _$HostDetailCopyWithImpl<$Res>
    implements _$$_HostDetailCopyWith<$Res> {
  __$$_HostDetailCopyWithImpl(
      _$_HostDetail _value, $Res Function(_$_HostDetail) _then)
      : super(_value, (v) => _then(v as _$_HostDetail));

  @override
  _$_HostDetail get _value => super._value as _$_HostDetail;

  @override
  $Res call({
    Object? pk = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? introduction = freezed,
    Object? creatorDetail = freezed,
  }) {
    return _then(_$_HostDetail(
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
      _$$_HostDetailFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _$_HostDetail &&
            const DeepCollectionEquality().equals(other.pk, pk) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality()
                .equals(other.introduction, introduction) &&
            const DeepCollectionEquality()
                .equals(other.creatorDetail, creatorDetail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(pk),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(introduction),
      const DeepCollectionEquality().hash(creatorDetail));

  @JsonKey(ignore: true)
  @override
  _$$_HostDetailCopyWith<_$_HostDetail> get copyWith =>
      __$$_HostDetailCopyWithImpl<_$_HostDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HostDetailToJson(this);
  }
}

abstract class _HostDetail implements HostDetail {
  const factory _HostDetail(
          {final String? pk,
          final String? email,
          final String? name,
          final String? photo,
          final String? introduction,
          @JsonKey(name: "creator_detail") final Creator? creatorDetail}) =
      _$_HostDetail;

  factory _HostDetail.fromJson(Map<String, dynamic> json) =
      _$_HostDetail.fromJson;

  @override
  String? get pk;
  @override
  String? get email;
  @override
  String? get name;
  @override
  String? get photo;
  @override
  String? get introduction;
  @override
  @JsonKey(name: "creator_detail")
  Creator? get creatorDetail;
  @override
  @JsonKey(ignore: true)
  _$$_HostDetailCopyWith<_$_HostDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

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
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  $Res call({String? name, int? pk});
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, (v) => _then(v as _$_Group));

  @override
  _$_Group get _value => super._value as _$_Group;

  @override
  $Res call({
    Object? name = freezed,
    Object? pk = freezed,
  }) {
    return _then(_$_Group(
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
      _$$_GroupFromJson(json);

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
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.pk, pk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(pk));

  @JsonKey(ignore: true)
  @override
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(this);
  }
}

abstract class _Group implements Group {
  const factory _Group({final String? name, final int? pk}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String? get name;
  @override
  int? get pk;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}
