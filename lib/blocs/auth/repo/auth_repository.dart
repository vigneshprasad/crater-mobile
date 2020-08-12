import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/constants/shared_pref_keys.dart';
import 'package:worknetwork/api/auth/auth_api_service.dart';
import 'package:worknetwork/models/user/user_model.dart';

class AuthRepository {
  final AuthApiService _authApiService = AuthApiService.create();
  final _googleSignin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  // Future<http.Response> signupEmail({
  //   @required String name,
  //   @required String email,
  //   @required String password,
  //   @required String role,
  // }) async {
  //   return;
  // }

  Future<AuthEmailResponse> loginEmail({
    @required String email,
    @required String password,
  }) async {
    final response = await _authApiService.loginWithEmail({
      'email': email,
      'password': password,
    });
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
        return AuthEmailResponse.fromJson(json);
      case 400:
        throw Exception(response.body);
      default:
        throw Exception('Something went wrong');
    }
  }

  Future<GoogleSignInAuthentication> signInWithGoogle() async {
    final isSignedIn = await _googleSignin.isSignedIn();
    if (isSignedIn) {
      await _googleSignin.signOut();
    }
    final account = await _googleSignin.signIn();
    final googleAuth = await account.authentication;
    return googleAuth;
  }

  Future<AuthEmailResponse> authWithGoogle(String accessToken) async {
    final body = {'access_token': accessToken, 'role': 'user'};
    final response = await _authApiService.authWithGoogle(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return AuthEmailResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.containsKey(SharedPrefKeys.authToken);
    return token ? prefs.getString(SharedPrefKeys.authToken) : '';
  }

  Future<User> hasUser() async {
    final userBox = await Hive.openBox<User>(AppHiveBoxes.userBox);
    return userBox.get(0);
  }

  Future<void> presistToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.authToken, token);
  }

  Future<void> persistUser(User user) async {
    final userBox = await Hive.openBox<User>(AppHiveBoxes.userBox);
    await userBox.add(user);
    userBox.close();
  }

  void dispose() {
    _authApiService.client.dispose();
  }
}
