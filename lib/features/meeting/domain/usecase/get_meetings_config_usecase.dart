import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/meeting_config_entity.dart';
import '../entity/meeting_interest_entity.dart';
import '../entity/meeting_objective_entity.dart';
import '../entity/user_meeting_preference_entity.dart';
import '../repository/meeting_repository.dart';

class UCGetMeetingConfig
    implements AsyncUseCase<MeetingConfigResponse, NoParams> {
  final MeetingRepository repository;

  UCGetMeetingConfig(this.repository);

  @override
  Future<Either<Failure, MeetingConfigResponse>> call(NoParams params) {
    return repository.getMeetingsCoonfigs();
  }
}

class MeetingConfigResponse extends Equatable {
  final MeetingConfig meeting;
  final UserMeetingPreference preferences;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;

  const MeetingConfigResponse({
    @required this.meeting,
    @required this.preferences,
    @required this.interests,
    @required this.objectives,
  });

  @override
  List<Object> get props => [
        meeting,
        preferences,
        interests,
        objectives,
      ];
}
