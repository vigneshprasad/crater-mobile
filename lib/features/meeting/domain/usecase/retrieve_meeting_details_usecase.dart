import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_entity.dart';
import '../repository/meeting_repository.dart';

class UCRetrieveMeetingDetails
    implements AsyncUseCase<Meeting, RetrieveMeetingDetailsParams> {
  final MeetingRepository repository;

  UCRetrieveMeetingDetails(this.repository);

  @override
  Future<Either<Failure, Meeting>> call(RetrieveMeetingDetailsParams params) {
    return repository.retrieveMeetingDetails(params.meetingId);
  }
}

class RetrieveMeetingDetailsParams extends Equatable {
  final int meetingId;

  const RetrieveMeetingDetailsParams({
    required this.meetingId,
  });

  @override
  List<Object> get props => [meetingId];
}
