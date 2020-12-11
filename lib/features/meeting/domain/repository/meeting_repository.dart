import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_config_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/number_of_meetings_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/time_slot_entity.dart';

import '../../../../core/error/failures.dart';
import '../entity/meeting_entity.dart';
import '../entity/meeting_interest_entity.dart';
import '../entity/meeting_objective_entity.dart';
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
}
