import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_config_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetingConfig implements AsyncUseCase<MeetingConfig, NoParams> {
  final MeetingRepository repository;

  UCGetMeetingConfig(this.repository);

  @override
  Future<Either<Failure, MeetingConfig?>> call(NoParams params) {
    return repository.getMeetingsCoonfigs();
  }
}
