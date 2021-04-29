import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entity/profile_entity/profile_entity.dart';
import '../services/profile_api_services/profile_api_service.dart';

final profileRemoteDatasourceProvider =
    Provider<ProfileRemoteDatasource>((ref) {
  final apiService = ref.read(profileApiServiceProvider);
  return ProfileRemoteImpl(apiService);
});

abstract class ProfileRemoteDatasource {
  /// TODO: PUT COMMENTS
  Future<Profile> retrieveProfileFromRemote(String profileId);
}

class ProfileRemoteImpl implements ProfileRemoteDatasource {
  final ProfileApiService apiService;

  ProfileRemoteImpl(this.apiService);

  @override
  Future<Profile> retrieveProfileFromRemote(String profileId) async {
    final response = await apiService.retrieveProfile(profileId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return Profile.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
