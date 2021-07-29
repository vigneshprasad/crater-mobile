import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/linkedin_oauth2_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/config_reader/config_reader.dart';
import '../../../../core/error/exceptions.dart';
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
    required this.googleSignIn,
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
      await fb.FacebookAuth.instance.logOut();
      final fb.LoginResult result = await fb.FacebookAuth.instance.login(
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

  @override
  Future<AccessToken> getLinkedInAccessToken() async {
    try {
      final liClient = LinkedInOAuth2Client(
          redirectUri: ConfigReader.getLinkedInRedirect(),
          customUriScheme: 'worknetwork');

      //Request a token using the Client Credentials flow...
      AccessTokenResponse tknResp = await liClient.getTokenWithAuthCodeFlow(
        clientId: ConfigReader.getLinkedInClientId(), //Your client id
        clientSecret: ConfigReader.getLinkedInSecret(), //Your client secret
        scopes: ['r_liteprofile', 'r_emailaddress'],
      );

      if (tknResp.error != null) {
        throw ServerException(tknResp.error);
      }

      //Or, if you already have a token, check if it is expired and in case refresh it...
      if (tknResp.isExpired()) {
        tknResp = await liClient.refreshToken(tknResp.refreshToken!,
            clientId: ConfigReader.getLinkedInClientId(),
            clientSecret: ConfigReader.getLinkedInSecret());
      }
      return AccessToken(tknResp.accessToken!);
    } catch (error) {
      throw ServerException();
    }
  }
}
