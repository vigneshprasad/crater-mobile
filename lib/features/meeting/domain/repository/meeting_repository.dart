import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../usecase/get_meetings_config_usecase.dart';

abstract class MeetingRepository {
  Future<Either<Failure, MeetingConfigResponse>> getMeetingsCoonfigs();
}
