import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/meeting_rsvp_model.dart';
import '../entity/meeting_config_entity.dart';
import '../entity/meeting_entity.dart';
import '../entity/meeting_interest_entity.dart';
import '../entity/meeting_objective_entity.dart';
import '../entity/meeting_rsvp_entity.dart';
import '../entity/meetings_by_date_entity.dart';
import '../entity/number_of_meetings_entity.dart';
import '../entity/reschedule_request_entity.dart';
import '../entity/time_slot_entity.dart';
import '../entity/user_meeting_preference_entity.dart';

abstract class MeetingRepository {
  Future<Either<Failure, MeetingConfig>> getMeetingsCoonfigs();
  Future<Either<Failure, UserMeetingPreference>> postUserMeetingPreferences(
    List<MeetingInterest> interests,
    MeetingConfig config,
    NumberOfMeetings numberOfMeetings,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  );
  Future<Either<Failure, List<Meeting>>> getMeetings();
  Future<Either<Failure, List<MeetingObjective>>> getMeetingObjectives();
  Future<Either<Failure, List<MeetingInterest>>> getMeetingInterests();
  Future<Either<Failure, UserMeetingPreference>> getMeetingPreference();
  Future<Either<Failure, UserMeetingPreference>> getPastMeetingPreference();
  Future<Either<Failure, List<MeetingsByDate>>> getMeetingsByDate({bool past});
  Future<Either<Failure, Meeting>> retrieveMeetingDetails(int meetingId);
  Future<Either<Failure, MeetingRsvp>> postRsvpStatusUpdate(
      MeetingRsvpStatus status, int meetingId);
  Future<Either<Failure, List<List<DateTime>>>> getRescheduleTimeSlots();
  Future<Either<Failure, RescheduleRequest>> postRecheduleRsvpStatus(
    int oldMeeting,
    String requestedBy,
    List<DateTime> timeSlots,
  );
  Future<Either<Failure, RescheduleRequest>> getRescheduleRequest(
    int meetingId,
  );
  Future<Either<Failure, bool>> postConfirmRescheduleRequest(
    DateTime timeSlot,
    int rescheduleRequest,
  );
}
