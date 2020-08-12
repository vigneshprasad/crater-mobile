import 'dart:convert';

import 'package:worknetwork/api/masterclass/masterclass_api_service.dart';

class MasterClassRepository {
  final MasterClassApiService _masterClassApiService =
      MasterClassApiService.create();

  Future<MasterClassGetResponse> getMasterClassList() async {
    final response = await _masterClassApiService.getVideosList();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return MasterClassGetResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  void dispose() {
    _masterClassApiService.dispose();
  }
}
