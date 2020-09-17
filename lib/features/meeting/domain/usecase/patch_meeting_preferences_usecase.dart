import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_meeting_preference_entity.dart';
import '../repository/meeting_repository.dart';

class UCPatchMeetingPreferences
    implements AsyncUseCase<UserMeetingPreference, PatchMeetingPrefParams> {
  final MeetingRepository repository;

  UCPatchMeetingPreferences(this.repository);

  @override
  Future<Either<Failure, UserMeetingPreference>> call(
      PatchMeetingPrefParams params) {
    return repository.patchUserMeetingPreferences(
      params.meetingPref,
      params.interests,
      params.meeting,
      params.numberOfMeetings,
      params.objective,
      params.timeSlots,
    );
  }
}

class PatchMeetingPrefParams extends Equatable {
  final int meetingPref;
  final List<int> interests;
  final int meeting;
  final int numberOfMeetings;
  final String objective;
  final List<int> timeSlots;

  const PatchMeetingPrefParams({
    @required this.meetingPref,
    @required this.interests,
    @required this.meeting,
    @required this.numberOfMeetings,
    @required this.objective,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [
        meetingPref,
        interests,
        meeting,
        numberOfMeetings,
        objective,
        timeSlots,
      ];
}
