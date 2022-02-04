import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/connection/data/datasource/connection_remote_datasource.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

final connectionRepositoryProvider =
    Provider<ConnectionRepository>((ref) => ConnectionRepositoryImpl(ref.read));

abstract class ConnectionRepository {
  Future<Either<Failure, CreatorResponse>> getCreators(int page, int pageSize,
      {bool certified});
  Future<Either<Failure, Creator>> getCreator(int id);
  Future<Either<Failure, List<Profile>>> getCommunityMembers(
      String community, int page);
}

class ConnectionRepositoryImpl implements ConnectionRepository {
  final Reader read;

  ConnectionRepositoryImpl(this.read);

  @override
  Future<Either<Failure, CreatorResponse>> getCreators(int page, int pageSize,
      {bool certified = true}) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCreatorsFromRemote(page, pageSize, certified: certified);
      return Right(response);
    } on ServerException catch (error) {
      final _ = jsonDecode(error.message as String) as Map<String, dynamic>;
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
    } on ServerException catch (error) {
      final _ = jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> getCommunityMembers(
      String community, int page) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCommunityMembersFromRemote(community, page);
      return Right(response);
    } on ServerException catch (error) {
      final _ = jsonDecode(error.message as String) as Map<String, dynamic>;
      final failure = ServerFailure('Something went wrong');
      return Left(failure);
    }
  }
}
