import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';

import '../../../../core/error/failures.dart';
import '../entity/reschedule_request_entity.dart';

abstract class DyteRepository {
  Future<Either<Failure, DyteRequestModel>> getDyteCredsRequest(
    int meetingId,
  );
}
