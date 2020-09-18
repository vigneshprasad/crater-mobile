import 'package:flutter/material.dart';

class AppConstants {
  static const apiBaseUrl = "http://192.168.0.102:8000/v1";
  static const websocketBaseUrl = "ws://192.168.0.102:8000/ws/connector";
  static const oneSignalAppId = "1e6689ee-cb44-4c39-8339-4ce7ddd513fc";
  static const linkedinClientId = "816zzmaw07e4v3";
  static const linkedinSecret = "upmxGw6xmBM7CHVa";
  static const linkedinRedirect = "http://localhost:3000/connect/linkedin";

  static const googleAuthScope = [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static const appleClientId = "com.worknetwork.mobile.service";
  static const appleRedirectUri = "$apiBaseUrl/connect/apple";

  static const defaultAvatar = {
    "a":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/A.png',
    "b":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/B.png',
    "c":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/C.png',
    "d":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/D.png',
    "e":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/E.png',
    "f":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/F.png',
    "g":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/G.png',
    "h":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/H.png',
    "i":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/I.png',
    "j":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/J.png',
    "k":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/K.png',
    "l":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/L.png',
    "m":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/M.png',
    "n":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/N.png',
    "o":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/O.png',
    "p":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/P.png',
    "q":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Q.png',
    "r":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/R.png',
    "s":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/S.png',
    "t":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/T.png',
    "u":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/U.png',
    "v":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/V.png',
    "w":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/W.png',
    "x":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/X.png',
    "y":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Y.png',
    "z":
        'https://1worknetwork-prod.s3.ap-south-1.amazonaws.com/media/stock_profile_pictures/Z.png',
  };
}

class AppImageAssets {
  static const defaultAvatar =
      AssetImage("assets/images/img_default_avatar.png");
  static const searchUserempty =
      AssetImage("assets/images/img_no_user_search.png");
  static const drawerBg = AssetImage("assets/images/img_drawer_image.png");
  static const articleDefault =
      AssetImage("assets/images/img_article_placeholder.png");
}

class AppSvgAssets {
  static const googleColored = "assets/svg/google.svg";
  static const linkedinFilled = "assets/svg/linkedin-fill.svg";
  static const facebook = "assets/svg/facebook.svg";
  static const apple = "assets/svg/apple-logo.svg";
}

class AppLottieAssets {
  static const imageLoading = "assets/lottie/loading_dots.json";
  static const typingAnimation = "assets/lottie/typing_animation.json";
}
