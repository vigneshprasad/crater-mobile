import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

enum ObjectiveType {
  @JsonValue('looking_for')
  lookingFor,

  @JsonValue("looking_to")
  lookingTo,
}

class MeetingObjective extends Equatable {
  final String? icon;
  final String? name;
  final int? pk;
  final ObjectiveType? type;

  const MeetingObjective({
    this.icon,
    this.name,
    this.pk,
    this.type,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (icon != null) temp.add(icon!);
    if (name != null) temp.add(name!);
    if (pk != null) temp.add(pk!);
    if (type != null) temp.add(type!);
    return temp;
  }
}
