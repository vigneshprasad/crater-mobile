import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures/failures.dart';
import '../../domain/repository/profile_meta_repository.dart';
import '../datasources/profile_meta_remote_datasource.dart';
import '../models/profile_extra_meta/profile_extra_meta.dart';

final profileMetaRepositoryProvider = Provider<ProfileMetaRepository>(
    (ref) => ProfileMetaRepositoryImpl(ref.read));

class ProfileMetaRepositoryImpl implements ProfileMetaRepository {
  final Reader read;

  ProfileMetaRepositoryImpl(this.read);

  @override
  Future<Either<Failure, ProfileExtraMeta>> getProfileExtraInfoMeta(
      int id) async {
    try {
      final result = await read(profileMetaRemoteDatasourceProvider)
          .getProfileExtraMetaFromRemote(id);
      return Right(result);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: error.message as String);
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfile>> postUserProfile(
      Map<String, dynamic> data) async {
    try {
      final response = await read(profileMetaRemoteDatasourceProvider)
          .postUserProfileToRemote(data);
      return Right(response);
    } on ServerException catch (error) {
      final failure = ServerFailure(message: error.message as String);
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
