import 'package:flutter/material.dart';

class AppConstants {
  static const apiBaseUrl = "http://192.168.0.102:8000/v1";
  static const websocketBaseUrl = "ws://192.168.0.102:8000/ws/connector";
}

class AppImageAssets {
  static const defaultAvatar =
      AssetImage("assets/images/img_default_avatar.png");
}
