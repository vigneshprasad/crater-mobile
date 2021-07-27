import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../../domain/entity/meetings_by_date_entity.dart';
import '../../domain/entity/reschedule_request_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../../domain/repository/meeting_repository.dart';
import '../datasources/meetings_remote_datasource.dart';
import '../models/meeting_rsvp_model.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  MeetingRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MeetingConfig>> getMeetingsCoonfigs() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDatasource.getMeetingConfigFromRemote();
        if (response == null) return Left(CacheFailure());
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserMeetingPreference>> postUserMeetingPreferences(
    List<MeetingInterest> interests,
    MeetingConfig config,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  ) async {
    try {
      final response =
          await remoteDatasource.postUserMeetingPreferencesToRemote(
        interests,
        config,
        objectives,
        timeSlots,
      );
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<Meeting>>> getMeetings() async {
    try {
      final response = await remoteDatasource.getMeetingsFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<MeetingInterest>>> getMeetingInterests() async {
    try {
      final response = await remoteDatasource.getMeetingInterestFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<MeetingObjective>>> getMeetingObjectives() async {
    try {
      final response = await remoteDatasource.getMeetingObjectivesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserMeetingPreference>> getMeetingPreference() async {
    try {
      final response = await remoteDatasource.getMeetingPreferenceFromRemote();
      if (response == null) return Right(UserMeetingPreference());
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserMeetingPreference>>
      getPastMeetingPreference() async {
    try {
      final response =
          await remoteDatasource.getPastMeetingPreferenceFromRemote();
      if (response == null) return Left(ServerFailure());
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<MeetingsByDate>>> getMeetingsByDate(
      {bool? past}) async {
    try {
      final response =
          await remoteDatasource.getMeetingsByDateFromRemote(past: past);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, Meeting>> retrieveMeetingDetails(int meetingId) async {
    try {
      final response =
          await remoteDatasource.retrieveMeetingDetailFromRemote(meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, MeetingRsvp>> postRsvpStatusUpdate(
      MeetingRsvpStatus status, int meetingId) async {
    try {
      final response =
          await remoteDatasource.postRsvpStatusToRemote(status, meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<List<DateTime>>>> getRescheduleTimeSlots() async {
    try {
      final response = await remoteDatasource.getRescheduleSlotsFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, RescheduleRequest>> postRecheduleRsvpStatus(
      int oldMeeting, String requestedBy, List<DateTime> timeSlots) async {
    try {
      final response = await remoteDatasource.postRecheduleRsvpStatusToRemote(
          oldMeeting, requestedBy, timeSlots);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, RescheduleRequest>> getRescheduleRequest(
      int meetingId) async {
    try {
      final response =
          await remoteDatasource.getRescheduleRequestFromRemote(meetingId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, bool>> postConfirmRescheduleRequest(
      DateTime timeSlot, int rescheduleRequest) async {
    try {
      final response = await remoteDatasource
          .postConfirmRescheduleRequestToRemote(timeSlot, rescheduleRequest);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
