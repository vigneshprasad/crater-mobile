// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreatorResponse _$_$_CreatorResponseFromJson(Map<String, dynamic> json) {
  return _$_CreatorResponse(
    count: json['count'] as int? ?? 0,
    currentPage: json['current_page'] as int,
    next: json['next'] as String?,
    previous: json['previous'] as String?,
    results: (json['results'] as List<dynamic>?)
            ?.map((e) => Creator.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_CreatorResponseToJson(_$_CreatorResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

_$_Creator _$_$_CreatorFromJson(Map<String, dynamic> json) {
  return _$_Creator(
    id: json['id'] as int? ?? 0,
    user: json['user'] as String? ?? '',
    numberOfSubscribers: json['number_of_subscribers'] as int?,
    certified: json['certified'] as bool? ?? false,
    followerCount: json['follower_count'] as int?,
    order: json['order'] as int? ?? 0,
    defaultCommunity: json['default_community'] == null
        ? null
        : CreatorCommunity.fromJson(
            json['default_community'] as Map<String, dynamic>),
    profileDetail: json['profile_detail'] == null
        ? null
        : Profile.fromJson(json['profile_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CreatorToJson(_$_Creator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'number_of_subscribers': instance.numberOfSubscribers,
      'certified': instance.certified,
      'follower_count': instance.followerCount,
      'order': instance.order,
      'default_community': instance.defaultCommunity,
      'profile_detail': instance.profileDetail,
    };

_$_CreatorCommunity _$_$_CreatorCommunityFromJson(Map<String, dynamic> json) {
  return _$_CreatorCommunity(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    creator: json['creator'] as int? ?? 0,
    isDefault: json['is_default'] as bool,
    isActive: json['is_active'] as bool,
  );
}

Map<String, dynamic> _$_$_CreatorCommunityToJson(
        _$_CreatorCommunity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'creator': instance.creator,
      'is_default': instance.isDefault,
      'is_active': instance.isActive,
    };
