import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../data/models/meeting_rsvp_model.dart';
import '../entity/meeting_rsvp_entity.dart';
import '../repository/meeting_repository.dart';

class UCPostRsvpStatus
    implements AsyncUseCase<MeetingRsvp, PostRsvpStatusParams> {
  final MeetingRepository repository;

  UCPostRsvpStatus(this.repository);

  @override
  Future<Either<Failure, MeetingRsvp>> call(PostRsvpStatusParams params) {
    return repository.postRsvpStatusUpdate(params.status, params.meetingId);
  }
}

class PostRsvpStatusParams extends Equatable {
  final MeetingRsvpStatus status;
  final int meetingId;

  const PostRsvpStatusParams({
    required this.status,
    required this.meetingId,
  });

  @override
  List<Object> get props => [
        status,
        meetingId,
      ];
}
