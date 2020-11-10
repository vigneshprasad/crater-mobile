import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_interest_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetingInterests
    implements AsyncUseCase<List<MeetingInterest>, NoParams> {
  final MeetingRepository repository;

  UCGetMeetingInterests(this.repository);

  @override
  Future<Either<Failure, List<MeetingInterest>>> call(NoParams params) {
    return repository.getMeetingInterests();
  }
}
