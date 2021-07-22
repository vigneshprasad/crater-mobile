import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/reschedule_request_entity.dart';
import '../repository/meeting_repository.dart';

class UCPostRecheduleRsvpStatus
    implements AsyncUseCase<RescheduleRequest, PostRescheduleRsvpParams> {
  final MeetingRepository repository;

  UCPostRecheduleRsvpStatus(this.repository);

  @override
  Future<Either<Failure, RescheduleRequest>> call(
      PostRescheduleRsvpParams params) {
    return repository.postRecheduleRsvpStatus(
        params.oldMeeting, params.requestedBy, params.timeSlots);
  }
}

class PostRescheduleRsvpParams extends Equatable {
  final int oldMeeting;
  final String requestedBy;
  final List<DateTime> timeSlots;

  const PostRescheduleRsvpParams({
    required this.oldMeeting,
    required this.requestedBy,
    required this.timeSlots,
  });

  @override
  List<Object> get props => [
        oldMeeting,
        requestedBy,
        timeSlots,
      ];
}
