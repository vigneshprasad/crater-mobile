import 'dart:convert';

import 'package:worknetwork/api/meets/meets_api_service.dart';
import 'package:worknetwork/core/error/exceptions.dart';

import '../models/api_models.dart';

abstract class MeetingRemoteDatasource {
  Future<GetMeetingConfigApiResponse> getMeetingConfigFromRemote();
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
}
