import 'dart:convert';

import 'package:worknetwork/api/user/user_api_service.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';

import '../../../../api/auth/auth_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../models/api/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Calls the Email Login Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> loginWithEmail(String email, String password, String osId);

  /// Calls the Email Register Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> registerWithEmail(
      String name, String email, String password, String osId);

  /// Calls the Google Auth Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> authWithGoogle(String token, String osId);

  /// Calls the Linked Auth Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> authWithLinkedIn(String token, String osId);

  /// Calls the Patch User Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> patchUserModelRemote(UserModel user);

  /// Calls the Get User Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> getUserFromRemote();

  /// Calls the Post User Profile Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserProfile> postUserProfileRemote(Map<String, dynamic> body);

  /// Calls the GET User Profile Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserProfile> getUserProfileFromRemote();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService apiService;
  final UserApiService userApiService;

  AuthRemoteDataSourceImpl(this.apiService, this.userApiService);

  @override
  Future<UserModel> authWithGoogle(String token, String osId) async {
    final body = {"access_token": token, "role": "user", "os_id": osId};
    final response = await apiService.authWithGoogle(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserModel> authWithLinkedIn(String token, String osId) async {
    final body = {"access_token": token, "role": "user", "os_id": osId};
    final response = await apiService.authWithLinkedin(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserModel> loginWithEmail(
      String email, String password, String osId) async {
    final body = {
      "email": email,
      "password": password,
      "os_id": osId,
    };
    final response = await apiService.loginWithEmail(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserModel> registerWithEmail(
    String name,
    String email,
    String password,
    String osId,
  ) async {
    final body = {
      "name": name,
      "email": email,
      "password": password,
      "os_id": osId,
    };
    final response = await apiService.registerWithEmail(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<User> patchUserModelRemote(UserModel user) async {
    final body = user.toJson();
    body.removeWhere((key, value) => value == null);
    final response = await userApiService.patchUser(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<User> getUserFromRemote() async {
    final response = await userApiService.getUser();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserProfile> postUserProfileRemote(Map<String, dynamic> body) async {
    final response = await userApiService.postUserProfile(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserProfile> getUserProfileFromRemote() async {
    final response = await userApiService.getUserProfile();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserProfileModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
