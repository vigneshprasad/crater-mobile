import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

enum ThemeType { light, dark }

class StatusBarColor {
  static Future<void> setTheme(ThemeType theme) async {
    if (theme == ThemeType.dark) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.grey[900]);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }
}
