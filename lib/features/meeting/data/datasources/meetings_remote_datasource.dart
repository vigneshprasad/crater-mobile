import 'dart:convert';

import 'package:worknetwork/api/meets/meets_api_service.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/meeting/data/models/user_meeting_preference_model.dart';
import 'package:worknetwork/features/meeting/domain/entity/user_meeting_preference_entity.dart';

import '../models/api_models.dart';

abstract class MeetingRemoteDatasource {
  Future<GetMeetingConfigApiResponse> getMeetingConfigFromRemote();
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  );
}

class MeetingRemoteDatasourceImpl implements MeetingRemoteDatasource {
  final MeetsApiService apiService;

  MeetingRemoteDatasourceImpl(this.apiService);

  @override
  Future<GetMeetingConfigApiResponse> getMeetingConfigFromRemote() async {
    final response = await apiService.getMeetings();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return GetMeetingConfigApiResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserMeetingPreference> postUserMeetingPreferencesToRemote(
    List<int> interests,
    int meeting,
    int numberOfMeetings,
    String objective,
    List<int> timeSlots,
  ) async {
    final body = {
      "meeting": meeting,
      "interests": interests,
      "number_of_meetings": numberOfMeetings,
      "objective": objective,
      "time_slots": timeSlots,
    };
    final response = await apiService.postMeetingPreferences(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserMeetingPreferenceModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
