import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../topic_entity/topic_entity.dart';

part 'roundtable_entity.freezed.dart';
part 'roundtable_entity.g.dart';

@freezed
abstract class RoundTable with _$RoundTable {
  factory RoundTable({
    int id,
    String host,
    List<String> speakers,
    int topic,
    String description,
    List<int> interests,
    DateTime start,
    DateTime end,
    @JsonKey(name: 'max_speakers') int maxSpeakers,
    int privacy,
    int medium,
    bool closed,
    @JsonKey(name: 'closed_at') DateTime closedAt,
    @JsonKey(name: 'topic_detail') Topic topicDetail,
    @JsonKey(name: 'host_detail') RoundTableUser hostDetail,
    @JsonKey(name: 'interests_detail_list')
        List<MeetingInterestModel> interestsDetailList,
    @JsonKey(name: 'speakers_detail_list')
        List<RoundTableUser> speakersDetailList,
    @JsonKey(name: 'is_speaker') bool isSpeaker,
  }) = _RoundTable;

  factory RoundTable.fromJson(Map<String, dynamic> json) =>
      _$RoundTableFromJson(json);
}

@freezed
abstract class RoundTableUser with _$RoundTableUser {
  factory RoundTableUser({
    String pk,
    String email,
    String name,
    String photo,
    String introduction,
  }) = _RoundTableUser;

  factory RoundTableUser.fromJson(Map<String, dynamic> json) =>
      _$RoundTableUserFromJson(json);
}
