import 'package:flutter/material.dart';

class AppConstants {
  static const apiBaseUrl = "https://back-pre.1worknetwork.com/v1";
  static const websocketBaseUrl =
      "wss://back-pre.1worknetwork.com/ws/connector";
  static const oneSignalAppId = "1e6689ee-cb44-4c39-8339-4ce7ddd513fc";
  static const linkedinClientId = "816zzmaw07e4v3";
  static const linkedinSecret = "upmxGw6xmBM7CHVa";
  static const linkedinRedirect = "http://localhost:3000/connect/linkedin";

  static const googleAuthScope = [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];
}

class AppImageAssets {
  static const defaultAvatar =
      AssetImage("assets/images/img_default_avatar.png");
  static const searchUserempty =
      AssetImage("assets/images/img_no_user_search.png");
  static const drawerBg = AssetImage("assets/images/img_drawer_image.png");
}

class AppSvgAssets {
  static const googleColored = "assets/svg/google.svg";
  static const linkedinFilled = "assets/svg/linkedin-fill.svg";
  static const facebook = "assets/svg/facebook.svg";
}

class AppLottieAssets {
  static const imageLoading = "assets/lottie/loading_dots.json";
  static const typingAnimation = "assets/lottie/typing_animation.json";
}
