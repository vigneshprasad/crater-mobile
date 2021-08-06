import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/meeting/data/datasources/dyte_remote_datasource.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';
import 'package:worknetwork/features/meeting/domain/repository/dyte_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/reschedule_request_entity.dart';

class DyteRepositoryImpl implements DyteRepository {
  final DyteRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  DyteRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DyteRequestModel>> getDyteCredsRequest(
      int meetingId) async {
    try {
      final response =
          await remoteDatasource.getDyteCredsRequestFromRemote(meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
