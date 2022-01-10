import 'package:hive/hive.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_request_entity.dart';

import 'meeting_entity.dart';

class RequestsByDate extends HiveObject {
  final DateTime? date;
  final List<MeetingRequest>? meetingsRequests;

  RequestsByDate({
    this.date,
    this.meetingsRequests,
  });
}
