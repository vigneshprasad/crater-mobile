import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

part 'creator_response.freezed.dart';
part 'creator_response.g.dart';

@freezed
abstract class CreatorResponse with _$CreatorResponse {
  const factory CreatorResponse({
    @Default(0) int count,
    @JsonKey(name: 'current_page') @Default(0) int currentPage,
    String? next,
    String? previous,
    @Default([]) List<Creator> results,
  }) = _CreatorResponse;

  factory CreatorResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatorResponseFromJson(json);
}

@freezed
abstract class Creator with _$Creator {
  const factory Creator({
    @Default(0) int id,
    @Default('') String user,
    @JsonKey(name: 'number_of_subscribers')
    @Default(0)
        int? numberOfSubscribers,
    @Default(false) bool certified,
    @JsonKey(name: 'follower_count') @Default(0) int? followerCount,
    // @Default(0)dynamic type,
    @Default(0) int order,
    @JsonKey(name: 'default_community') CreatorCommunity? defaultCommunity,
    @JsonKey(name: 'profile_detail') Profile? profileDetail,
    String? slug,
    bool? isFollower,
    bool? showClubMembers,
    String? video,
    String? videoPoster,
  }) = _Creator;

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);
}

@freezed
abstract class CreatorCommunity with _$CreatorCommunity {
  const factory CreatorCommunity({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int creator,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
  }) = _CreatorCommunity;

  factory CreatorCommunity.fromJson(Map<String, dynamic> json) =>
      _$CreatorCommunityFromJson(json);
}
