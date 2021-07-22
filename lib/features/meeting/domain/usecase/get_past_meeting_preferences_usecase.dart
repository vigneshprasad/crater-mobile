import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_meeting_preference_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetPastMeetingPreferences
    implements AsyncUseCase<UserMeetingPreference, NoParams> {
  final MeetingRepository repository;

  UCGetPastMeetingPreferences(this.repository);

  @override
  Future<Either<Failure, UserMeetingPreference?>> call(NoParams params) {
    return repository.getPastMeetingPreference();
  }
}
