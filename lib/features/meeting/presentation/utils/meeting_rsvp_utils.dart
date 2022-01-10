import 'package:flutter/material.dart';

import '../../data/models/meeting_rsvp_model.dart';

class MeetingRsvpUtils {
  static Color getRsvpStatusColor(MeetingRsvpStatus status) {
    switch (status) {
      case MeetingRsvpStatus.attending:
        return Colors.green;
      case MeetingRsvpStatus.notAttending:
        return Colors.red;
      case MeetingRsvpStatus.pending:
        return Colors.yellow[600]!;
      case MeetingRsvpStatus.reschedule:
        return Colors.orange;
      default:
        return Colors.yellow;
    }
  }
}
