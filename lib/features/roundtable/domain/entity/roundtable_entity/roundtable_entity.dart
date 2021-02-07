import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../agenda_entity/agenda_entity.dart';

part 'roundtable_entity.freezed.dart';
part 'roundtable_entity.g.dart';

@freezed
abstract class RoundTable with _$RoundTable {
  factory RoundTable({
    int id,
    Host host,
    List<Speaker> speakers,
    Agenda agenda,
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
abstract class Speaker with _$Speaker {
  factory Speaker({
    String pk,
    String email,
    String name,
    String photo,
  }) = _Speaker;

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);
}

@freezed
abstract class Host with _$Host {
  factory Host({
    String pk,
    String email,
    String name,
    String photo,
  }) = _Host;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);
}
