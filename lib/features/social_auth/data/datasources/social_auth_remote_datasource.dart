import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/config_reader/config_reader.dart';
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
  final FacebookLogin facebookLogin;

  SocialAuthRemoteDataSourceImpl({
    @required this.googleSignIn,
    @required this.facebookLogin,
  });

  @override
  Future<AccessToken> getAppleAccessToken() async {
    try {
      final creds = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: ConfigReader.getAppleClientId(),
          redirectUri: Uri.parse(ConfigReader.getAppleRedirectUrl()),
        ),
      );
      return AccessToken(creds.authorizationCode);
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<AccessToken> getFacebookAccessToken() async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    try {
      await facebookLogin.logOut();
      final result = await facebookLogin.logIn(["email"]);
      final token = result.accessToken.token;
      return AccessToken(token);
    } catch (error) {
      throw ServerException(error);
    }
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
