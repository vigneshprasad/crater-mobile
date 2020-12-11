import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_config_entity.dart';
import '../entity/meeting_interest_entity.dart';
import '../entity/meeting_objective_entity.dart';
import '../entity/number_of_meetings_entity.dart';
import '../entity/time_slot_entity.dart';
import '../entity/user_meeting_preference_entity.dart';
import '../repository/meeting_repository.dart';

class UCPostMeetingPreferences
    implements AsyncUseCase<UserMeetingPreference, PostMeetingPrefParams> {
  final MeetingRepository repository;

  UCPostMeetingPreferences(this.repository);

  @override
  Future<Either<Failure, UserMeetingPreference>> call(
      PostMeetingPrefParams params) {
    return repository.postUserMeetingPreferences(
      params.interests,
      params.config,
      params.numberOfMeetings,
      params.objectives,
      params.timeSlots,
    );
  }
}

class PostMeetingPrefParams extends Equatable {
  final List<MeetingInterest> interests;
  final MeetingConfig config;
  final NumberOfMeetings numberOfMeetings;
  final List<MeetingObjective> objectives;
  final List<TimeSlot> timeSlots;

  const PostMeetingPrefParams({
    @required this.interests,
    @required this.config,
    @required this.numberOfMeetings,
    @required this.objectives,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [
        interests,
        config,
        numberOfMeetings,
        objectives,
        timeSlots,
      ];
}
