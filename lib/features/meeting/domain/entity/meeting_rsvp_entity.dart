import 'package:hive/hive.dart';

import '../../data/models/meeting_rsvp_model.dart';

class MeetingRsvp extends HiveObject {
  final int? pk;
  final MeetingRsvpStatus? status;

  MeetingRsvp({
    this.pk,
    this.status,
  });
}
