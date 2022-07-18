import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_meeting_model.dart';
import 'package:worknetwork/features/meeting/data/models/dyte_request_model.dart';
import 'package:worknetwork/features/meeting/data/services/dyte_api_service.dart';

final dyteRemoteDataSouceProvider = Provider(
  (ref) {
    final apiService = ref.watch(dyteApiServiceProvider);
    return DyteRemoteDatasourceImpl(apiService);
  },
);

abstract class DyteRemoteDatasource {
  Future<DyteRequestModel> getDyteCredsRequestFromRemote(int meetingId);
  Future<DyteMeeting> getRoomFromRemote(int meetingId);
}

class DyteRemoteDatasourceImpl implements DyteRemoteDatasource {
  final DyteApiService apiService;

  DyteRemoteDatasourceImpl(this.apiService);

  @override
  Future<DyteRequestModel> getDyteCredsRequestFromRemote(int meetingId) async {
    final response = await apiService.getDyteCredsRequest(meetingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return DyteRequestModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<DyteMeeting> getRoomFromRemote(int meetingId) async {
    final response = await apiService.getRoomRequest(meetingId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return DyteMeeting.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
