import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../topic_entity/topic_entity.dart';

part 'roundtable_entity.freezed.dart';
part 'roundtable_entity.g.dart';

@freezed
abstract class RoundTable with _$RoundTable {
  factory RoundTable({
    int id,
    RoundTableUser host,
    List<RoundTableUser> speakers,
    Topic topic,
    String description,
    List<MeetingInterestModel> interests,
    DateTime start,
    DateTime end,
    @JsonKey(name: 'max_speakers') int maxSpeakers,
    int privacy,
    int medium,
    bool closed,
    @JsonKey(name: 'closed_at') DateTime closedAt,
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
  }) = _RoundTableUser;

  factory RoundTableUser.fromJson(Map<String, dynamic> json) =>
      _$RoundTableUserFromJson(json);
}
