import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/connection/data/datasource/connection_remote_datasource.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

final connectionRepositoryProvider =
    Provider<ConnectionRepository>((ref) => ConnectionRepositoryImpl(ref.read));

abstract class ConnectionRepository {
  Future<Either<Failure, CreatorResponse>> getCreators(
    int page,
    int pageSize, {
    bool certified,
  });

  Future<Either<Failure, CreatorResponse>> getTopCreators(
    int page,
    int pageSize,
  );
  Future<Either<Failure, Creator>> getCreator(int id);
  Future<Either<Failure, List<Profile>>> getCommunityMembers(
    String community,
    int page,
  );
  Future<Either<Failure, Creator>> followCreator(
    int id,
    String authPK,
  );
}

class ConnectionRepositoryImpl implements ConnectionRepository {
  final Reader read;

  ConnectionRepositoryImpl(this.read);

  @override
  Future<Either<Failure, CreatorResponse>> getCreators(
    int page,
    int pageSize, {
    bool certified = true,
  }) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCreatorsFromRemote(page, pageSize, certified: certified);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CreatorResponse>> getTopCreators(
    int page,
    int pageSize,
  ) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getTopCreatorsFromRemote(page, pageSize);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Creator>> getCreator(int id) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCreatorFromRemote(id);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> getCommunityMembers(
    String community,
    int page,
  ) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCommunityMembersFromRemote(community, page);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Creator>> followCreator(
    int id,
    String authPK,
  ) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .followCreatorToRemote(id, authPK);
      return Right(response);
    } on ServerException {
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }
}
