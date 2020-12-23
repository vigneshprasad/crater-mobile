import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../../../../api/meets/meets_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../../domain/entity/meetings_by_date_entity.dart';
import '../../domain/entity/number_of_meetings_entity.dart';
import '../../domain/entity/time_slot_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../models/meeting_config_model.dart';
import '../models/meeting_interest_model.dart';
import '../models/meeting_model.dart';
import '../models/meeting_objective_model.dart';
import '../models/meeting_rsvp_model.dart';
import '../models/meetings_by_date_model.dart';
import '../models/user_meeting_preference_model.dart';

abstract class MeetingRemoteDatasource {
  Future<MeetingConfig> getMeetingConfigFromRemote();
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<MeetingInterest> interests,
    MeetingConfig config,
    NumberOfMeetings numberOfMeetings,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  );
  Future<List<Meeting>> getMeetingsFromRemote();
  Future<List<MeetingObjective>> getMeetingObjectivesFromRemote();
  Future<List<MeetingInterest>> getMeetingInterestFromRemote();
  Future<UserMeetingPreference> getMeetingPreferenceFromRemote();
  Future<UserMeetingPreference> getPastMeetingPreferenceFromRemote();
  Future<List<MeetingsByDate>> getMeetingsByDateFromRemote({bool past});
  Future<Meeting> retrieveMeetingDetailFromRemote(int meetingId);
  Future<MeetingRsvp> postRsvpStatusToRemote(
      MeetingRsvpStatus status, int meetingId);
}

class MeetingRemoteDatasourceImpl implements MeetingRemoteDatasource {
  final MeetsApiService apiService;

  MeetingRemoteDatasourceImpl(this.apiService);

  @override
  Future<MeetingConfig> getMeetingConfigFromRemote() async {
    final response = await apiService.getMeetingsConfig();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingConfigModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<MeetingInterest> interests,
    MeetingConfig config,
    NumberOfMeetings numberOfMeetings,
    List<MeetingObjective> objectives,
    List<TimeSlot> timeSlots,
  ) async {
    final body = {
      "meeting": config.pk,
      "interests": interests.map((e) => e.pk).toList(),
      "number_of_meetings_per_month": numberOfMeetings.value,
      "objectives": objectives.map((e) => e.pk).toList(),
      "time_slots": timeSlots.map((e) => e.pk).toList(),
    };
    final response = await apiService.postMeetingPreferences(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Meeting>> getMeetingsFromRemote() async {
    final response = await apiService.getMeetings();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((item) => MeetingModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<MeetingInterest>> getMeetingInterestFromRemote() async {
    final response = await apiService.getMeetingInterests();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((interest) =>
              MeetingInterestModel.fromJson(interest as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<MeetingObjective>> getMeetingObjectivesFromRemote() async {
    final response = await apiService.getMeetingObjectives();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((objective) =>
              MeetingObjectiveModel.fromJson(objective as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference> getMeetingPreferenceFromRemote() async {
    final response = await apiService.getMeetingPreferences();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference> getPastMeetingPreferenceFromRemote() async {
    final response = await apiService.getPastMeetingPreferences();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw ServerException(response.error);
    }
  }

  Future<Response<dynamic>> _getMeetingsData({bool past}) {
    if (past) {
      return apiService.getPastMeetings();
    } else {
      return apiService.getUpcomingMeetings();
    }
  }

  @override
  Future<List<MeetingsByDate>> getMeetingsByDateFromRemote({bool past}) async {
    final response = await _getMeetingsData(past: past);
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((data) =>
              MeetingsByDateModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Meeting> retrieveMeetingDetailFromRemote(int meetingId) async {
    final response = await apiService.retrieveMeetingDetail(meetingId);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;

      return MeetingModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<MeetingRsvp> postRsvpStatusToRemote(
      MeetingRsvpStatus status, int meetingId) async {
    final response = await _postRsvpStatus(status, meetingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingRsvpModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  Future<Response> _postRsvpStatus(MeetingRsvpStatus status, int meetingId) {
    final data = {
      'meeting': meetingId,
    };
    if (status == MeetingRsvpStatus.attending) {
      return apiService.postRsvpAttendingStatus(data);
    } else if (status == MeetingRsvpStatus.notAttending) {
      return apiService.postRsvpCancelledStatus(data);
    } else {
      throw ServerException('Incorrect rsvp status');
    }
  }
}
