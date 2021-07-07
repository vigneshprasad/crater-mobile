import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../../auth/data/models/user_profile_model.dart';
import '../models/profile_extra_meta/profile_extra_meta.dart';
import '../services/profile_api_service/profile_api_service.dart';
import '../services/profile_meta_api_service/profile_meta_api_service.dart';

final profileMetaRemoteDatasourceProvider =
    Provider<ProfileMetaRemoteDatasource>(
        (ref) => ProfileMetaRemoteDatasourceImpl(ref.read));

abstract class ProfileMetaRemoteDatasource {
  Future<ProfileExtraMeta> getProfileExtraMetaFromRemote(int id);
  Future<UserProfileModel> postUserProfileToRemote(Map<String, dynamic> data);
}

class ProfileMetaRemoteDatasourceImpl implements ProfileMetaRemoteDatasource {
  final Reader read;

  ProfileMetaRemoteDatasourceImpl(this.read);

  @override
  Future<ProfileExtraMeta> getProfileExtraMetaFromRemote(int id) async {
    final response =
        await read(profileMetaApiServiceProvider).getProfileExtraFormMeta(id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ProfileExtraMeta.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserProfileModel> postUserProfileToRemote(
      Map<String, dynamic> data) async {
    final response =
        await read(profileApiServiceProvider).postUserProfile(data);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
