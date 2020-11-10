import 'package:json_annotation/json_annotation.dart';

enum ObjectiveType {
  @JsonValue('looking_for')
  lookingFor,

  @JsonValue("looking_to")
  lookingTo,
}

class MeetingObjective {
  final String icon;
  final String name;
  final int pk;
  final ObjectiveType type;

  MeetingObjective({
    this.icon,
    this.name,
    this.pk,
    this.type,
  });
}
