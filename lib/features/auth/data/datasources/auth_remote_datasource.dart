import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/auth/auth_api_service.dart';
import 'package:worknetwork/api/auth/otp_api_service.dart';
import 'package:worknetwork/api/user/user_api_service.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/auth/data/models/api/auth_response_model.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.read(authApiServiceProvider);
  final userApiService = ref.read(userApiServiceProvider);
  final otpApiService = ref.read(otpApiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService, userApiService, otpApiService);
});

abstract class AuthRemoteDataSource {
  /// Calls the Email Login Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> logout(String osId);

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

  /// Send OTP to phone
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> sendOtp(String phone);

  /// Verify OTP
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> verifyOtp(
    String phone,
    String otp,
    Map<String, String> attributionData,
  );

  Future<UserPermission> getUserPermissionFromRemote();

  Future<ReferralsResponse> getReferralsFromRemote(int? page, int? pageSize);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService apiService;
  final UserApiService userApiService;
  final OtpApiService otpApiService;

  AuthRemoteDataSourceImpl(
    this.apiService,
    this.userApiService,
    this.otpApiService,
  );

  @override
  Future<UserModel> logout(String osId) async {
    final body = {"os_id": osId};
    final response = await apiService.logout(body);
    if (response.statusCode == 200) {
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
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
      // final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      // return UserModel.fromJson(json);
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

  @override
  Future<void> sendOtp(String phone) async {
    final body = {"username": phone};
    final response = await otpApiService.sendOtp(body);
    if (response.statusCode == 200) {
      // final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      // final model = AuthResponseModel.fromJson(json);
      // return model.toUserModel();
      return;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserModel> verifyOtp(
    String phone,
    String otp,
    Map<String, String> attributionData,
  ) async {
    final body = {"username": phone, "otp": otp};
    body.addAll(attributionData);
    final response = await otpApiService.verifyOtp(body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserPermission> getUserPermissionFromRemote() async {
    final response = await userApiService.getUserPermission();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return UserPermission.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<ReferralsResponse> getReferralsFromRemote(
    int? page,
    int? pageSize,
  ) async {
    final response = await userApiService.getReferrals(page, pageSize);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ReferralsResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
