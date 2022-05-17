import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/auth/otp_api_service.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../api/auth/auth_api_service.dart';
import '../../../../api/user/user_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/entity/user_profile_entity.dart';
import '../models/api/auth_response_model.dart';
import '../models/user_model.dart';
import '../models/user_profile_model.dart';

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

  /// Calls the Apple Auth Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> authWithApple(String token, String osId);

  /// Calls the Linked Auth Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> authWithLinkedIn(String token, String osId);

  /// Calls the Facebook Auth Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> authWithFacebook(String token, String osId);

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

  /// Calls the Post Password Reset Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> postPasswordResetToRemote(String email);

  /// Calls the Post New Password Endpoint on backend.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> postNewPasswordToRemote(Map<String, String> body);

  /// Send OTP to phone
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> sendOtp(String phone);

  /// Verify OTP
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> verifyOtp(String phone, String otp);

  Future<UserPermission> getUserPermissionFromRemote();

  Future<ReferralsResponse> getReferralsFromRemote(int? page, int? pageSize);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService apiService;
  final UserApiService userApiService;
  final OtpApiService otpApiService;

  AuthRemoteDataSourceImpl(
      this.apiService, this.userApiService, this.otpApiService);

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
  Future<UserModel> authWithApple(String token, String osId) async {
    final body = {"access_token": token, "role": "user", "os_id": osId};
    final response = await apiService.authWithApple(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = AuthResponseModel.fromJson(json);
      return model.toUserModel();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<UserModel> authWithFacebook(String token, String osId) async {
    final body = {"access_token": token, "role": "user", "os_id": osId};
    final response = await apiService.authWithFacebook(body);
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
  Future<String> postPasswordResetToRemote(String email) async {
    final body = {'email': email};
    final response = await apiService.postPasswordReset(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return json['detail'] as String;
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<String> postNewPasswordToRemote(Map<String, String> body) async {
    final response = await apiService.postNewPassword(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return json['detail'] as String;
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
  Future<UserModel> verifyOtp(String phone, String otp) async {
    final body = {"username": phone, "otp": otp};
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
      int? page, int? pageSize) async {
    final response = await userApiService.getReferrals(page, pageSize);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return ReferralsResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
