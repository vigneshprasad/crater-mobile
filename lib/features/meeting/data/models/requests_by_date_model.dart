import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/requests_by_date_entity.dart';
import 'meeting_request_model.dart';

part 'requests_by_date_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class RequestsByDateModel extends RequestsByDate {
  final DateTime? date;

  @JsonKey(name: 'meeting_requests')
  final List<MeetingRequestModel>? meetingsRequests;

  RequestsByDateModel({
    this.date,
    this.meetingsRequests,
  }) : super(
          date: date,
          meetingsRequests: meetingsRequests,
        );

  factory RequestsByDateModel.fromJson(Map<String, dynamic> json) =>
      _$RequestsByDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestsByDateModelToJson(this);
}
