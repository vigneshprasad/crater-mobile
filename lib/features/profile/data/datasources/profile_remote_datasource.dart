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
  Future<List<Profile>> retrieveProfilesFromRemote(String tags, int page);
  Future<List<Profile>> retrieveConnectionsFromRemote(String profileId);
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

  @override
  Future<List<Profile>> retrieveProfilesFromRemote(
    String tags,
    int page,
  ) async {
    const pageSize = 10;
    const searchKeyword = '';
    final response = await apiService.retrieveProfiles(
      tags,
      searchKeyword,
      page,
      pageSize,
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final jsonList = json['results'] as List;

      return jsonList
          .map((json) => Profile.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Profile>> retrieveConnectionsFromRemote(String profileId) async {
    final response = await apiService.getUserConnections(profileId);
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.bodyString) as Iterable;

      return jsonList
          .map((json) => Profile.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }
}
