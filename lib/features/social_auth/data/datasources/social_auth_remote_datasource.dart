import 'package:flutter/material.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../domain/entity/access_token.dart';

abstract class SocialAuthRemoteDataSource {
  Future<AccessToken> getLinkedInAccessToken();
  Future<AccessToken> getGoogleAccessToken();
  Future<AccessToken> getFacebookAccessToken();
  Future<AccessToken> getAppleAccessToken();
}

class SocialAuthRemoteDataSourceImpl implements SocialAuthRemoteDataSource {
  final GoogleSignIn googleSignIn;

  SocialAuthRemoteDataSourceImpl({
    @required this.googleSignIn,
  });

  @override
  Future<AccessToken> getAppleAccessToken() {
    // TODO: implement getAppleAccessToken
    throw UnimplementedError();
  }

  @override
  Future<AccessToken> getFacebookAccessToken() {
    // TODO: implement getFacebookAccessToken
    throw UnimplementedError();
  }

  @override
  Future<AccessToken> getGoogleAccessToken() async {
    final isSignedIn = await googleSignIn.isSignedIn();

    if (isSignedIn) googleSignIn.signOut();

    try {
      final account = await googleSignIn.signIn();
      final auth = await account.authentication;
      return AccessToken(auth.accessToken);
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<AccessToken> getLinkedInAccessToken() async {
    try {
      final token = await LinkedInLogin.loginForAccessToken(
          appBar: BaseAppBar(
        title: const Text("LinkedIn Auth"),
      ));
      return AccessToken(token);
    } catch (error) {
      throw ServerException();
    }
  }
}
