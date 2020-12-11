import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/meeting/domain/entity/number_of_meetings_entity.dart';
import 'package:worknetwork/features/meeting/domain/usecase/get_past_meeting_preferences_usecase.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../../domain/usecase/get_meeting_interests_usecase.dart';
import '../../domain/usecase/get_meeting_objectives_usecase.dart';
import '../../domain/usecase/get_meeting_preferences_usecase.dart';
import '../../domain/usecase/get_meetings_config_usecase.dart';
import '../../domain/usecase/get_meetings_usecase.dart';
import '../../domain/usecase/post_meeting_preferences_usecase.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final UCGetMeetings getMeetings;
  final UCGetMeetingInterests getMeetingInterests;
  final UCGetMeetingObjectives getMeetingObjectives;
  final UCGetMeetingConfig getMeetingConfig;
  final UCGetMeetingPreferences getMeetingPreferences;
  final UCPostMeetingPreferences postMeetingPreferences;
  final UCGetPastMeetingPreferences getPastMeetingPreferences;

  MeetingBloc({
    @required this.getMeetings,
    @required this.getMeetingInterests,
    @required this.getMeetingObjectives,
    @required this.getMeetingConfig,
    @required this.getMeetingPreferences,
    @required this.postMeetingPreferences,
    @required this.getPastMeetingPreferences,
  })  : assert(getMeetings != null),
        assert(getMeetingInterests != null),
        assert(getMeetingObjectives != null),
        assert(getMeetingConfig != null),
        assert(getMeetingPreferences != null),
        assert(postMeetingPreferences != null),
        assert(getPastMeetingPreferences != null),
        super(const MeetingInitial());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is GetMeetingStarted) {
      yield* _mapGetMeetingToState(event);
    } else if (event is GetMeetingConfigStarted) {
      yield* _mapGetMeetingConfigToState(event);
    } else if (event is GetMeetingPreferencesStarted) {
      yield* _mapGetMeetingPreferencesToState(event);
    } else if (event is GetMeetingObjectivesStarted) {
      yield* _mapGetMeetingObjectivesToState(event);
    } else if (event is GetMeetingInterestsStarted) {
      yield* _mapGetMeetingInterestsToState(event);
    } else if (event is PostMeetingPreferencesStarted) {
      yield* _mapPostMeetingPreferencesToState(event);
    } else if (event is GetPastMeetingPreferencesStarted) {
      yield* _mapGetPastMeetingPrefsToState(event);
    }
  }

  Stream<MeetingState> _mapGetMeetingToState(GetMeetingStarted event) async* {
    yield const MeetingGetRequestLoading();
    final responseOrError = await getMeetings(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (response) {
        final List<Meeting> upcoming =
            response.where((element) => !element.isPast).toList();
        final List<Meeting> past =
            response.where((element) => element.isPast).toList();
        return GetMeetingLoaded(
          past: past,
          upcoming: upcoming,
        );
      },
    );
  }

  Stream<MeetingState> _mapGetMeetingConfigToState(
      GetMeetingConfigStarted event) async* {
    yield const MeetingGetConfigLoading();
    final responseOrError = await getMeetingConfig(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (config) => MeetingGetConfigLoaded(config: config),
    );
  }

  Stream<MeetingState> _mapGetMeetingPreferencesToState(
      GetMeetingPreferencesStarted event) async* {
    yield const MeetingGetPreferencesLoading();
    final responseOrError = await getMeetingPreferences(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (prefs) => MeetingGetPreferencesLoaded(preference: prefs),
    );
  }

  Stream<MeetingState> _mapGetMeetingObjectivesToState(
      GetMeetingObjectivesStarted event) async* {
    yield const MeetingGetObjectivesRequestLoading();
    final responseOrError = await getMeetingObjectives(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (objectives) => MeetingGetObjectivesLoaded(objectives: objectives),
    );
  }

  Stream<MeetingState> _mapGetMeetingInterestsToState(
      GetMeetingInterestsStarted event) async* {
    yield const MeetingGetInterestsRequestLoading();
    final responseOrError = await getMeetingInterests(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (interests) => MeetingGetInterestsLoaded(interests: interests),
    );
  }

  Stream<MeetingState> _mapPostMeetingPreferencesToState(
      PostMeetingPreferencesStarted event) async* {
    yield const MeetingPostPreferencesLoading();
    final responseOrError = await postMeetingPreferences(PostMeetingPrefParams(
      config: event.config,
      interests: event.interests,
      objectives: event.objectives,
      numberOfMeetings: event.numberOfMeetings,
      timeSlots: event.timeSlots,
    ));

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (prefs) => PostMeetingPreferencesLoaded(preferences: prefs),
    );
  }

  Stream<MeetingState> _mapGetPastMeetingPrefsToState(
      GetPastMeetingPreferencesStarted event) async* {
    yield const MeetingGetPastPreferencesLoading();

    final responseOrError = await getPastMeetingPreferences(NoParams());

    yield responseOrError.fold(
      (failure) => MeetingGetRequestError(error: failure),
      (prefs) => MeetingGetPastPreferencesLoaded(pastPreferences: prefs),
    );
  }
}
