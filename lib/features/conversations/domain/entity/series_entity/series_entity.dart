// To parse this JSON data, do
//
//     final series = seriesFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
// import 'dart:convert';

import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/topic_entity/topic_entity.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_rsvp_model.dart';

part 'series_entity.freezed.dart';
part 'series_entity.g.dart';

// Series seriesFromJson(String str) => Series.fromJson(json.decode(str));

// String seriesToJson(Series data) => json.encode(data.toJson());

@freezed
class Series with _$Series {
    const factory Series({
        int? id,
        int? topic,
        @JsonKey(name: "topic_detail") Topic? topicDetail,
        List<int>? groups,
        @JsonKey(name: "groups_detail_list") List<GroupsDetailList>? groupsDetailList,
        List<dynamic>? categories,
        @JsonKey(name: "categories_detail_list") List<dynamic>? categoriesDetailList,
        String? host,
        @JsonKey(name: "host_detail") HostDetail? hostDetail,
        DateTime? start,
        @JsonKey(name: "created_at") DateTime? createdAt,
    }) = _Series;

    factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
}

@freezed
class GroupsDetailList with _$GroupsDetailList {
    const factory GroupsDetailList({
        int? id,
        String? host,
        int? topic,
        String? description,
        DateTime? start,
        int? privacy,
        int? medium,
        bool? closed,
        @JsonKey(name: "closed_at") DateTime? closedAt,
        @JsonKey(name: "topic_detail") Topic? topicDetail,
        @JsonKey(name: "host_detail") HostDetail? hostDetail,
        @JsonKey(name: "host_profile_details") UserProfileModel? hostProfileDetails,
        int? type,
        @JsonKey(name: "is_live") bool? isLive,
        @JsonKey(name: "live_count") int? liveCount,
        bool? rsvp,
        bool? isPast,
        @JsonKey(name: "is_featured") bool? isFeatured,
        List<int>? categories,
        @JsonKey(name: "categories_detail_list") List<CategoriesDetailList>? categoriesDetailList,
        @JsonKey(name: "recording_details") RecordingDetails? recordingDetails,
        List<String>? speakers,
        @JsonKey(name: "speakers_detail_list") List<HostDetail>? speakersDetailList,
        int? series,
    }) = _GroupsDetailList;

    factory GroupsDetailList.fromJson(Map<String, dynamic> json) => _$GroupsDetailListFromJson(json);
}

@freezed
class CategoriesDetailList with _$CategoriesDetailList {
    const factory CategoriesDetailList({
        int? pk,
        String? name,
        String? color,
        String? photo,
        String? order,
    }) = _CategoriesDetailList;

    factory CategoriesDetailList.fromJson(Map<String, dynamic> json) => _$CategoriesDetailListFromJson(json);
}

@freezed
class HostDetail with _$HostDetail {
    const factory HostDetail({
        String? pk,
        String? email,
        String? name,
        String? photo,
        String? introduction,
        @JsonKey(name: "creator_detail") Creator? creatorDetail,
    }) = _HostDetail;

    factory HostDetail.fromJson(Map<String, dynamic> json) => _$HostDetailFromJson(json);
}

@freezed
class Group with _$Group {
    const factory Group({
        String? name,
        int? pk,
    }) = _Group;

    factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
