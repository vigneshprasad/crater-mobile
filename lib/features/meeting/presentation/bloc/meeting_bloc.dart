import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/meeting/domain/entity/reschedule_request_entity.dart';
import 'package:worknetwork/features/meeting/domain/usecase/get_reschedule_request_usecase.dart';
import 'package:worknetwork/features/meeting/domain/usecase/post_confirm_reschedule_request_usecase.dart';
import 'package:worknetwork/features/meeting/domain/usecase/post_rechedule_rsvp_status_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../auth/domain/entity/user_profile_entity.dart';
import '../../data/models/meeting_rsvp_model.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../../domain/entity/meetings_by_date_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../../domain/usecase/get_meeting_interests_usecase.dart';
import '../../domain/usecase/get_meeting_objectives_usecase.dart';
import '../../domain/usecase/get_meeting_preferences_usecase.dart';
import '../../domain/usecase/get_meetings_by_date_usecase.dart';
import '../../domain/usecase/get_meetings_config_usecase.dart';
import '../../domain/usecase/get_past_meeting_preferences_usecase.dart';
import '../../domain/usecase/get_reschedule_time_slots.dart';
import '../../domain/usecase/post_meeting_preferences_usecase.dart';
import '../../domain/usecase/post_rsvp_status_update_usecase.dart';
import '../../domain/usecase/retrieve_meeting_details_usecase.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final UCGetMeetingInterests getMeetingInterests;
  final UCGetMeetingObjectives getMeetingObjectives;
  final UCGetMeetingConfig getMeetingConfig;
  final UCGetMeetingPreferences getMeetingPreferences;
  final UCPostMeetingPreferences postMeetingPreferences;
  final UCGetPastMeetingPreferences getPastMeetingPreferences;
  final UCGetMeetingsByDate getMeetingsByDate;
  final UCRetrieveMeetingDetails retrieveMeetingDetails;
  final UCPostRsvpStatus postRsvpStatus;
  final UCGetRescheduleTimeSlots getRescheduleTimeSlots;
  final UCPostRecheduleRsvpStatus postRecheduleRsvpStatus;
  final UCGetRescheduleRequest getRescheduleRequest;
  final UCPostConfirmRescheduleRequest postConfirmRescheduleRequest;

  MeetingBloc({
    @required this.getMeetingInterests,
    @required this.getMeetingObjectives,
    @required this.getMeetingConfig,
    @required this.getMeetingPreferences,
    @required this.postMeetingPreferences,
    @required this.getPastMeetingPreferences,
    @required this.getMeetingsByDate,
    @required this.retrieveMeetingDetails,
    @required this.postRsvpStatus,
    @required this.getRescheduleTimeSlots,
    @required this.postRecheduleRsvpStatus,
    @required this.getRescheduleRequest,
    @required this.postConfirmRescheduleRequest,
  })  : assert(getMeetingInterests != null),
        assert(getMeetingObjectives != null),
        assert(getMeetingConfig != null),
        assert(getMeetingPreferences != null),
        assert(postMeetingPreferences != null),
        assert(getPastMeetingPreferences != null),
        assert(getMeetingsByDate != null),
        assert(retrieveMeetingDetails != null),
        assert(postRsvpStatus != null),
        assert(getRescheduleTimeSlots != null),
        assert(postRecheduleRsvpStatus != null),
        assert(getRescheduleRequest != null),
        assert(postConfirmRescheduleRequest != null),
        super(const MeetingInitial());

  @override
  Stream<MeetingState> mapEventToState(
    MeetingEvent event,
  ) async* {
    if (event is GetUpcomingMeetingsStarted) {
      yield* _mapGetUpcomingMeetingsToState(event);
    } else if (event is GetPastMeetingStarted) {
      yield* _mapGetPastMeetingsToState(event);
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
    } else if (event is RetrieveMeetingDetailStarted) {
      yield* _mapRetrieveMeetingToState(event);
    } else if (event is PostMeetingRsvpStatusStarted) {
      yield* _mapPostRsvpStatusToState(event);
    } else if (event is GetMeetingRescheduleSlotsStarted) {
      yield* _mapGetRescheduleTimeslotsToState(event);
    } else if (event is PostMeetingRescheduleRsvpStarted) {
      yield* _mapPostRecheduleRsvpRequestToState(event);
    } else if (event is GetRescheduleRequestStarted) {
      yield* _mapGetRescheduleRequestToState(event);
    } else if (event is PostConfirmRescheduleRequestStarted) {
      yield* _mapPostConfirmRescheduleRequestToState(event);
    }
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
      timeSlots: event.timeSlots,
    ));

    yield responseOrError.fold(
      (failure) => PostMeetingPreferenceError(error: failure),
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

  Stream<MeetingState> _mapGetUpcomingMeetingsToState(
      GetUpcomingMeetingsStarted event) async* {
    yield const MeetingGetUpcomingRequestLoading();

    final responseOrError =
        await getMeetingsByDate(const GetMeetingsByWeekParams());

    yield responseOrError.fold(
      (failure) => MeetingGetUpcomingRequestError(error: failure),
      (upcoming) => GetUpcomingMeetingsLoaded(upcoming: upcoming),
    );
  }

  Stream<MeetingState> _mapGetPastMeetingsToState(
      GetPastMeetingStarted event) async* {
    yield const MeetingGetPastRequestLoading();

    final responseOrError =
        await getMeetingsByDate(const GetMeetingsByWeekParams(past: true));

    yield responseOrError.fold(
      (failure) => MeetingPastRequestError(error: failure),
      (past) => GetPastMeetingsLoaded(past: past),
    );
  }

  Stream<MeetingState> _mapRetrieveMeetingToState(
      RetrieveMeetingDetailStarted event) async* {
    yield const RetrieveMeetingLoading();

    final responseOrError = await retrieveMeetingDetails(
        RetrieveMeetingDetailsParams(meetingId: event.meetingId));

    yield responseOrError.fold(
      (failure) => RetrieveMeetingError(error: failure),
      (meeting) => RetrieveMeetingLoaded(meeting: meeting),
    );
  }

  Stream<MeetingState> _mapPostRsvpStatusToState(
      PostMeetingRsvpStatusStarted event) async* {
    yield const PostMeetingRsvpStatusLoading();

    final responseOrError = await postRsvpStatus(
        PostRsvpStatusParams(meetingId: event.meetingId, status: event.status));

    yield responseOrError.fold(
      (failure) => PostMeetingRsvpStatusError(error: failure),
      (rsvp) => PostMeetingRsvpStatusLoaded(rsvp: rsvp),
    );
  }

  Stream<MeetingState> _mapGetRescheduleTimeslotsToState(
      GetMeetingRescheduleSlotsStarted event) async* {
    yield const GetMeetingRescheduleSlotsLoading();

    final responseOrError = await getRescheduleTimeSlots(NoParams());
    yield responseOrError.fold(
      (failure) => GetMeetingRescheduleSlotsError(error: failure),
      (slots) => GetMeetingRescheduleSlotsLoaded(timeslots: slots),
    );
  }

  Stream<MeetingState> _mapPostRecheduleRsvpRequestToState(
      PostMeetingRescheduleRsvpStarted event) async* {
    yield const PostMeetingRecheduleRsvpLoading();

    final responseOrError =
        await postRecheduleRsvpStatus(PostRescheduleRsvpParams(
      oldMeeting: event.oldMeeting,
      requestedBy: event.requestedBy,
      timeSlots: event.timeSlots,
    ));

    yield responseOrError.fold(
      (failure) => PostMeetingRecheduleRsvpError(error: failure),
      (response) => PostMeetingRecheduleRsvpLoaded(response: response),
    );
  }

  Stream<MeetingState> _mapGetRescheduleRequestToState(
      GetRescheduleRequestStarted event) async* {
    yield const GetMeetingRescheduleRequestLoading();

    final responseOrError = await getRescheduleRequest(
        GetRescheduleRequestParams(meetingId: event.meetingId));

    yield responseOrError.fold(
      (failure) => GetMeetingRescheduleRequestError(error: failure),
      (response) => GetMeetingRescheduleRequestLoaded(response: response),
    );
  }

  Stream<MeetingState> _mapPostConfirmRescheduleRequestToState(
      PostConfirmRescheduleRequestStarted event) async* {
    yield const PostConfirmRescheduleRequestLoading();

    final responseOrError = await postConfirmRescheduleRequest(
        PostConfirmRescheduleRequestParams(
            rescheduleRequest: event.rescheduleRequest,
            timeSlot: event.timeSlot));

    yield responseOrError.fold(
      (failure) => PostConfirmRescheduleRequestError(error: failure),
      (response) => PostConfirmRescheduleRequestLoaded(response: response),
    );
  }
}
