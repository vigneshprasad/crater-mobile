import 'package:freezed_annotation/freezed_annotation.dart';

import '../tag_entity/tag_entity.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

@freezed
abstract class Profile with _$Profile {
  factory Profile({
    int? pk,
    String? uuid,
    String? name,
    String? introduction,
    @JsonKey(name: 'generated_introduction') String? generatedIntroduction,
    @JsonKey(name: "tag_list") List<Tag>? tag,
    @JsonKey(name: "linkedin_url") String? linkedIn,
    String? photo,
    @JsonKey(name: "allow_meeting_request") bool? allowMeetingRequest,
    @JsonKey(name: "can_connect") bool? canConnect,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
