import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../../auth/data/models/user_profile_model.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../../domain/entity/profile_intro_meta.dart';
import '../../domain/entity/profile_intro_question.dart';
import '../../domain/repository/profile_intro_repository.dart';
import '../datasources/profile_intro_remote_datasource.dart';

class ProfileIntroRepositoryImpl implements ProfileIntroRepository {
  final ProfileIntroRemoteDatasource remoteDatasource;
  final AuthLocalDataSource localDataSource;

  ProfileIntroRepositoryImpl(this.remoteDatasource, this.localDataSource);

  @override
  Future<Either<Failure, List<String>>> getProfileIntroQuestions() async {
    try {
      const questions = [
        '{${ProfileIntroElement.name}} is a {${ProfileIntroElement.tags}}',
        'with {${ProfileIntroElement.yearsOfExperience}} years of work experience.',
        'Currently working with a {${ProfileIntroElement.companyType}} ,',
        'in the {${ProfileIntroElement.sector}} sector.',
        'Previously has completed a {${ProfileIntroElement.educationLevel}} degree.',
        '\n About {${ProfileIntroElement.introduction}}'
      ];

      return const Right(questions);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> getCompanies() async {
    try {
      final response = await remoteDatasource.getCompaniesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> getEducations() async {
    try {
      final response = await remoteDatasource.getEducationsFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> getExperiences() async {
    try {
      final response = await remoteDatasource.getExperiencesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<ProfileIntroMeta>>> getSectors() async {
    try {
      final response = await remoteDatasource.getSectorsFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> postUserProfileIntro(
      Map<String, dynamic> body, File photo) async {
    try {
      final response = await remoteDatasource.postUserProfile(body, photo);
      await localDataSource.setUserProfileToCache(response as UserProfileModel);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
