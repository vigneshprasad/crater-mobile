import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/failures.dart';

import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/meeting/domain/entity/user_meeting_preference_entity.dart';
import 'package:worknetwork/features/meeting/domain/repository/meeting_repository.dart';

class UCPostMeetingPreferences
    implements AsyncUseCase<UserMeetingPreference, PostMeetingPrefParams> {
  final MeetingRepository repository;

  UCPostMeetingPreferences(this.repository);

  @override
  Future<Either<Failure, UserMeetingPreference>> call(
      PostMeetingPrefParams params) {
    return repository.postUserMeetingPreferences(
      params.interests,
      params.meeting,
      params.numberOfMeetings,
      params.objective,
      params.timeSlots,
    );
  }
}

class PostMeetingPrefParams extends Equatable {
  final List<int> interests;
  final int meeting;
  final int numberOfMeetings;
  final String objective;
  final List<int> timeSlots;

  const PostMeetingPrefParams({
    @required this.interests,
    @required this.meeting,
    @required this.numberOfMeetings,
    @required this.objective,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [
        interests,
        meeting,
        numberOfMeetings,
        objective,
        timeSlots,
      ];
}
