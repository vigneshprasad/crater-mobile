import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
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
}
