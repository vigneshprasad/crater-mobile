import 'package:flutter/material.dart';

class AppConstants {
  static const apiBaseUrl = "http://192.168.0.102:8000/v1";
  static const websocketBaseUrl = "ws://192.168.0.102:8000/ws/connector";
  static const oneSignalAppId = "07ed4c08-3698-4fdd-80c5-2de973b851ef";
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
}

class AppSvgAssets {
  static const googleColored = "assets/svg/google.svg";
  static const linkedinFilled = "assets/svg/linkedin-fill.svg";
  static const facebook = "assets/svg/facebook.svg";
}

class AppLottieAssets {
  static const typingAnimation = "assets/lottie/typing_animation.json";
}
