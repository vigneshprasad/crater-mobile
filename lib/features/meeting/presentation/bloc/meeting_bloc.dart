import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../../domain/usecase/get_meetings_config_usecase.dart';
import '../../domain/usecase/post_meeting_preferences_usecase.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final UCGetMeetingConfig getMeetingConfig;
  final UCPostMeetingPreferences postMeetingPreferences;

  MeetingBloc({
    @required this.getMeetingConfig,
    @required this.postMeetingPreferences,
  })  : assert(getMeetingConfig != null),
        assert(postMeetingPreferences != null),
        super(const MeetingInitial());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is GetMeetingConfigStarted) {
      yield* _mapGetMeetingConfigToState(event);
    } else if (event is PostMeetingPreferencesStarted) {
      yield* _mapPostMeetingPreferencesToState(event);
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

  Stream<MeetingState> _mapPostMeetingPreferencesToState(
      PostMeetingPreferencesStarted event) async* {
    yield const MeetingGetRequestLoading();
    final postOrError = await postMeetingPreferences(PostMeetingPrefParams(
      interests: event.interests,
      objective: event.objective,
      numberOfMeetings: event.numberOfMeetings,
      timeSlots: event.timeSlots,
      meeting: event.meeting,
    ));

    yield postOrError.fold(
      (failure) => MeetingRequestError(error: failure),
      (prefs) => PostMeetingPreferencesLoaded(preferences: prefs),
    );
  }
}
