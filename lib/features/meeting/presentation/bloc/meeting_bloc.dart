import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';

import 'package:worknetwork/features/meeting/domain/usecase/get_meetings_config_usecase.dart';

import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final UCGetMeetingConfig getMeetingConfig;

  MeetingBloc({
    @required this.getMeetingConfig,
  }) : super(const MeetingInitial());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is GetMeetingConfigStarted) {
      yield* _mapGetMeetingConfigToState(event);
    }
  }

  Stream<MeetingState> _mapGetMeetingConfigToState(
      GetMeetingConfigStarted event) async* {
    yield const MeetingGetRequestLoading();
    final responseOrError = await getMeetingConfig(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingRequestError(error: failure),
      (response) => GetMeetingConfigLoaded(
        interests: response.interests,
        meeting: response.meeting,
        objectives: response.objectives,
        preferences: response.preferences,
      ),
    );
  }
}
