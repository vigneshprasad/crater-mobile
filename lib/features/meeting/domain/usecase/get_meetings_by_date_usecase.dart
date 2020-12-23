import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meetings_by_date_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetingsByDate
    implements AsyncUseCase<List<MeetingsByDate>, GetMeetingsByWeekParams> {
  final MeetingRepository repository;

  UCGetMeetingsByDate(this.repository);

  @override
  Future<Either<Failure, List<MeetingsByDate>>> call(
      GetMeetingsByWeekParams params) {
    return repository.getMeetingsByDate(past: params.past);
  }
}

class GetMeetingsByWeekParams extends Equatable {
  final bool past;

  const GetMeetingsByWeekParams({
    this.past = false,
  });

  @override
  List<Object> get props => [past];
}
