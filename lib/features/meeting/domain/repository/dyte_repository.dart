import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_meeting_model.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';

import '../../../../core/error/failures.dart';

abstract class DyteRepository {
  Future<Either<Failure, DyteRequestModel>> getDyteCredsRequest(int meetingId);
  Future<Either<Failure, DyteMeeting>> getRoom(int meetingId);
}
