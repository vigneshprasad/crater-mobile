import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_objective_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetingObjectives
    implements AsyncUseCase<List<MeetingObjective>, NoParams> {
  final MeetingRepository repository;

  UCGetMeetingObjectives(this.repository);

  @override
  Future<Either<Failure, List<MeetingObjective>>> call(NoParams params) {
    return repository.getMeetingObjectives();
  }
}
