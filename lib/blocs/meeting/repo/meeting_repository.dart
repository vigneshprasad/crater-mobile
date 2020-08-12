import 'dart:convert';

import 'package:worknetwork/api/meets/meets_api_service.dart';

class MeetingRepository {
  final MeetsApiService _meetsApiService = MeetsApiService.create();

  Future<MeetingsResponse> getMeetings() async {
    final response = await _meetsApiService.getMeetings();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MeetingsResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  void dispose() {
    _meetsApiService.dispose();
  }
}
