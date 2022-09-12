import 'package:dartz/dartz.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_meeting_model.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';

abstract class DyteRepository {
  Future<Either<Failure, DyteRequestModel>> getDyteCredsRequest(int meetingId);
  Future<Either<Failure, DyteMeeting>> getRoom(int meetingId);
}
