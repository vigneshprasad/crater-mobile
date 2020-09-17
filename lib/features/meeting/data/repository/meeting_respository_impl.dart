import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../../domain/repository/meeting_repository.dart';
import '../../domain/usecase/get_meetings_config_usecase.dart';
import '../datasources/meetings_remote_datasource.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  MeetingRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MeetingConfigResponse>> getMeetingsCoonfigs() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDatasource.getMeetingConfigFromRemote();
        return Right(MeetingConfigResponse(
          meeting: MeetingConfig(
            pk: response.pk,
            availableTimeSlots: response.availableTimeSlots,
            title: response.title,
            weekStartDate: response.weekStartDate,
            weekEndDate: response.weekEndDate,
            isRegistrationOpen: response.isRegistrationOpen,
            isActive: response.isActive,
          ),
          preferences: response.userPreferences,
          interests: response.interests,
          objectives: response.objectives,
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserMeetingPreference>> postUserMeetingPreferences(
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  ) async {
    try {
      final response =
          await remoteDatasource.postUserMeetingPreferencesToRemote(
              interests, meeting, numberOfMeetings, objective, timeSlots);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, UserMeetingPreference>> patchUserMeetingPreferences(
    int meetingPref,
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  ) async {
    try {
      final response =
          await remoteDatasource.patchUserMeetingPreferencesToRemote(
        meetingPref,
        interests,
        meeting,
        numberOfMeetings,
        objective,
        timeSlots,
      );
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
