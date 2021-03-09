import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/meeting_repository.dart';

class UCGetRescheduleTimeSlots
    implements AsyncUseCase<List<List<DateTime>>, NoParams> {
  final MeetingRepository repository;

  UCGetRescheduleTimeSlots(this.repository);

  @override
  Future<Either<Failure, List<List<DateTime>>>> call(NoParams params) {
    return repository.getRescheduleTimeSlots();
  }
}
