import 'dart:convert';

import 'package:worknetwork/features/meeting/domain/entity/number_of_meetings_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/time_slot_entity.dart';

import '../../../../api/meets/meets_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../models/meeting_config_model.dart';
import '../models/meeting_interest_model.dart';
import '../models/meeting_model.dart';
import '../models/meeting_objective_model.dart';
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
}
