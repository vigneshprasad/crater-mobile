import 'package:freezed_annotation/freezed_annotation.dart';

import '../tag_entity/tag_entity.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

@freezed
abstract class Profile with _$Profile {
  factory Profile({
    int pk,
    String name,
    String introduction,
    @JsonKey(name: "tag_list") List<Tag> tag,
    @JsonKey(name: "linkedin_url") String linkedIn,
    String photo,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
