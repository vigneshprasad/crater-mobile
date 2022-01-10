import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';

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
  Future<UserProfile> retrieveProfileFromRemote(String profileId);
  Future<List<Profile>> retrieveProfilesFromRemote(
    String tags,
    int page,
    int pageSize,
    String userId,
  );
  Future<List<Profile>> retrieveConnectionsFromRemote(String profileId);
}

class ProfileRemoteImpl implements ProfileRemoteDatasource {
  final ProfileApiService apiService;

  ProfileRemoteImpl(this.apiService);

  @override
  Future<UserProfile> retrieveProfileFromRemote(String profileId) async {
    final response = await apiService.retrieveProfile(profileId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<Profile>> retrieveProfilesFromRemote(
    String tags,
    int page,
    int pageSize,
    String userId,
  ) async {
    if (userId.isNotEmpty) {
      return await retrieveConnectionsFromRemote(userId);
    }
    const searchKeyword = '';
    final response = userId.isEmpty
        ? await apiService.retrieveProfiles(
            tags,
            searchKeyword,
            page,
            pageSize,
          )
        : await apiService.getUserConnections(
            userId,
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
      if (response.bodyString == '[]') {
        return [];
      }
      final jsonList = jsonDecode(response.bodyString) as Iterable;

      return jsonList
          .map((json) => Profile.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }
}
