import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/config_reader/config_reader.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/access_token.dart';

abstract class SocialAuthRemoteDataSource {
  Future<AccessToken> getGoogleAccessToken();
  Future<AccessToken> getFacebookAccessToken();
  Future<AccessToken> getAppleAccessToken();
}

class SocialAuthRemoteDataSourceImpl implements SocialAuthRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final fb.FacebookAuth facebookLogin;

  SocialAuthRemoteDataSourceImpl({
    required this.googleSignIn,
    required this.facebookLogin,
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
    try {
      await facebookLogin.logOut();
      final result = await facebookLogin.login(
          permissions: ['email'], loginBehavior: fb.LoginBehavior.webViewOnly);
      if (result.status == fb.LoginStatus.success) {
        return AccessToken(result.accessToken!.token);
      }
      throw ServerException(result.message);
    } catch (error) {
      throw ServerException();
    }
  }

  @override
  Future<AccessToken> getGoogleAccessToken() async {
    final isSignedIn = await googleSignIn.isSignedIn();

    if (isSignedIn) googleSignIn.signOut();

    try {
      final account = await googleSignIn.signIn();
      final auth = await account?.authentication;
      return AccessToken(auth!.accessToken!);
    } catch (error) {
      throw ServerException();
    }
  }
}
