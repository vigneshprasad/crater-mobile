import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/connection/data/datasource/connection_remote_datasource.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

final connectionRepositoryProvider =
    Provider<ConnectionRepository>((ref) => ConnectionRepositoryImpl(ref.read));

abstract class ConnectionRepository {
  Future<Either<Failure, CreatorResponse>> getCreators({bool certified});
  Future<Either<Failure, Creator>> getCreator(int id);
}

class ConnectionRepositoryImpl implements ConnectionRepository {
  final Reader read;

  ConnectionRepositoryImpl(this.read);

  @override
  Future<Either<Failure, CreatorResponse>> getCreators(
      {bool certified = true}) async {
    try {
      final response = await read(connectionRemoteDatasourceProvider)
          .getCreatorsFromRemote();
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
}
