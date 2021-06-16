import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_interest_entity.dart';

part 'meeting_interest_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingInterestModel extends MeetingInterest {
  final int pk;
  final String name;
  final String icon;

  const MeetingInterestModel({
    this.pk,
    this.name,
    this.icon,
  }) : super(
          pk: pk,
          name: name,
          icon: icon,
        );

  factory MeetingInterestModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingInterestModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingInterestModelToJson(this);
}
