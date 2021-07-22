import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

enum ObjectiveType {
  @JsonValue('looking_for')
  lookingFor,

  @JsonValue("looking_to")
  lookingTo,
}

class MeetingObjective extends Equatable {
  final String icon;
  final String name;
  final int pk;
  final ObjectiveType type;

  const MeetingObjective({
    required this.icon,
    required this.name,
    required this.pk,
    required this.type,
  });

  @override
  List<Object> get props => [
        icon,
        name,
        pk,
        type,
      ];
}
