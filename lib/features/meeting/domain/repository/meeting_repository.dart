import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_meeting_preference_entity.dart';
import '../usecase/get_meetings_config_usecase.dart';

abstract class MeetingRepository {
  Future<Either<Failure, MeetingConfigResponse>> getMeetingsCoonfigs();
  Future<Either<Failure, UserMeetingPreference>> postUserMeetingPreferences(
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  );
  Future<Either<Failure, UserMeetingPreference>> patchUserMeetingPreferences(
    int meetingPref,
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  );
}
