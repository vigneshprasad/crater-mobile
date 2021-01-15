import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/meeting_repository.dart';

class UCPostConfirmRescheduleRequest
    implements AsyncUseCase<bool, PostConfirmRescheduleRequestParams> {
  final MeetingRepository repository;

  UCPostConfirmRescheduleRequest(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      PostConfirmRescheduleRequestParams params) {
    return repository.postConfirmRescheduleRequest(
        params.timeSlot, params.rescheduleRequest);
  }
}

class PostConfirmRescheduleRequestParams extends Equatable {
  final DateTime timeSlot;
  final int rescheduleRequest;

  const PostConfirmRescheduleRequestParams({
    this.timeSlot,
    this.rescheduleRequest,
  });

  @override
  List<Object> get props => [
        timeSlot,
        rescheduleRequest,
      ];
}
