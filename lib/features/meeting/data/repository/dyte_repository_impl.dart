import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/core/network_info/network_info.dart';
import 'package:worknetwork/features/meeting/data/datasources/dyte_remote_datasource.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_meeting_model.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';
import 'package:worknetwork/features/meeting/domain/repository/dyte_repository.dart';

final dyteRepositoryProvider = Provider(
  (ref) {
    final remoteDatasource = ref.watch(dyteRemoteDataSouceProvider);
    final networkInfo = ref.watch(networkInfoProvider);
    return DyteRepositoryImpl(
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo,
    );
  },
);

class DyteRepositoryImpl implements DyteRepository {
  final DyteRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  DyteRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DyteRequestModel>> getDyteCredsRequest(
    int meetingId,
  ) async {
    try {
      final response =
          await remoteDatasource.getDyteCredsRequestFromRemote(meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, DyteMeeting>> getRoom(int meetingId) async {
    try {
      final response = await remoteDatasource.getRoomFromRemote(meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
