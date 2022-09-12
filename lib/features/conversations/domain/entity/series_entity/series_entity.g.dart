// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Series _$$_SeriesFromJson(Map<String, dynamic> json) => _$_Series(
      id: json['id'] as int?,
      topic: json['topic'] as int?,
      topicDetail: json['topic_detail'] == null
          ? null
          : Topic.fromJson(json['topic_detail'] as Map<String, dynamic>),
      groups: (json['groups'] as List<dynamic>?)?.map((e) => e as int).toList(),
      groupsDetailList: (json['groups_detail_list'] as List<dynamic>?)
          ?.map((e) => GroupsDetailList.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: json['categories'] as List<dynamic>?,
      categoriesDetailList: json['categories_detail_list'] as List<dynamic>?,
      host: json['host'] as String?,
      hostDetail: json['host_detail'] == null
          ? null
          : HostDetail.fromJson(json['host_detail'] as Map<String, dynamic>),
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_SeriesToJson(_$_Series instance) => <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'topic_detail': instance.topicDetail,
      'groups': instance.groups,
      'groups_detail_list': instance.groupsDetailList,
      'categories': instance.categories,
      'categories_detail_list': instance.categoriesDetailList,
      'host': instance.host,
      'host_detail': instance.hostDetail,
      'start': instance.start?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$_GroupsDetailList _$$_GroupsDetailListFromJson(Map<String, dynamic> json) =>
    _$_GroupsDetailList(
      id: json['id'] as int?,
      host: json['host'] as String?,
      topic: json['topic'] as int?,
      description: json['description'] as String?,
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      privacy: json['privacy'] as int?,
      medium: json['medium'] as int?,
      closed: json['closed'] as bool?,
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
      topicDetail: json['topic_detail'] == null
          ? null
          : Topic.fromJson(json['topic_detail'] as Map<String, dynamic>),
      hostDetail: json['host_detail'] == null
          ? null
          : HostDetail.fromJson(json['host_detail'] as Map<String, dynamic>),
      hostProfileDetails: json['host_profile_details'] == null
          ? null
          : UserProfileModel.fromJson(
              json['host_profile_details'] as Map<String, dynamic>),
      type: json['type'] as int?,
      isLive: json['is_live'] as bool?,
      liveCount: json['live_count'] as int?,
      rsvp: json['rsvp'] as bool?,
      isPast: json['isPast'] as bool?,
      isFeatured: json['is_featured'] as bool?,
      categories:
          (json['categories'] as List<dynamic>?)?.map((e) => e as int).toList(),
      categoriesDetailList: (json['categories_detail_list'] as List<dynamic>?)
          ?.map((e) => CategoriesDetailList.fromJson(e as Map<String, dynamic>))
          .toList(),
      recordingDetails: json['recording_details'] == null
          ? null
          : RecordingDetails.fromJson(
              json['recording_details'] as Map<String, dynamic>),
      speakers: (json['speakers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      speakersDetailList: (json['speakers_detail_list'] as List<dynamic>?)
          ?.map((e) => HostDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      series: json['series'] as int?,
    );

Map<String, dynamic> _$$_GroupsDetailListToJson(_$_GroupsDetailList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'topic': instance.topic,
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'privacy': instance.privacy,
      'medium': instance.medium,
      'closed': instance.closed,
      'closed_at': instance.closedAt?.toIso8601String(),
      'topic_detail': instance.topicDetail,
      'host_detail': instance.hostDetail,
      'host_profile_details': instance.hostProfileDetails,
      'type': instance.type,
      'is_live': instance.isLive,
      'live_count': instance.liveCount,
      'rsvp': instance.rsvp,
      'isPast': instance.isPast,
      'is_featured': instance.isFeatured,
      'categories': instance.categories,
      'categories_detail_list': instance.categoriesDetailList,
      'recording_details': instance.recordingDetails,
      'speakers': instance.speakers,
      'speakers_detail_list': instance.speakersDetailList,
      'series': instance.series,
    };

_$_CategoriesDetailList _$$_CategoriesDetailListFromJson(
        Map<String, dynamic> json) =>
    _$_CategoriesDetailList(
      pk: json['pk'] as int?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      photo: json['photo'] as String?,
      order: json['order'] as String?,
    );

Map<String, dynamic> _$$_CategoriesDetailListToJson(
        _$_CategoriesDetailList instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'color': instance.color,
      'photo': instance.photo,
      'order': instance.order,
    };

_$_HostDetail _$$_HostDetailFromJson(Map<String, dynamic> json) =>
    _$_HostDetail(
      pk: json['pk'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      introduction: json['introduction'] as String?,
      creatorDetail: json['creator_detail'] == null
          ? null
          : Creator.fromJson(json['creator_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_HostDetailToJson(_$_HostDetail instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'introduction': instance.introduction,
      'creator_detail': instance.creatorDetail,
    };

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      name: json['name'] as String?,
      pk: json['pk'] as int?,
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'name': instance.name,
      'pk': instance.pk,
    };
