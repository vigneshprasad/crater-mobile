import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/signup/data/datasources/profile_intro_remote_datasource.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_question.dart';
import 'package:worknetwork/features/signup/domain/repository/profile_intro_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class ProfileIntroRepositoryImpl implements ProfileIntroRepository {
  final ProfileIntroRemoteDatasource remoteDatasource;
  final AuthLocalDataSource localDataSource;

  ProfileIntroRepositoryImpl(this.remoteDatasource, this.localDataSource);

  @override
  Future<Either<Failure, List<String>>> getProfileIntroQuestions() async {
    try {
      const questions = [
        '{${ProfileIntroElement.name}} is a {${ProfileIntroElement.tags}}',
        'with {${ProfileIntroElement.yearsOfExperience}} years of work experience,',
        'Currently, working in the {${ProfileIntroElement.sector}} sector,',
        'as/with a {${ProfileIntroElement.companyType}}',
        'Previously, he received a {${ProfileIntroElement.educationLevel}} degree.'
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
