import 'package:worknetwork/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/meeting/domain/repository/meeting_repository.dart';

class UCGetRescheduleTimeSlots
    implements AsyncUseCase<List<List<DateTime>>, NoParams> {
  final MeetingRepository repository;

  UCGetRescheduleTimeSlots(this.repository);

  @override
  Future<Either<Failure, List<List<DateTime>>>> call(NoParams params) {
    return repository.getRescheduleTimeSlots();
  }
}
