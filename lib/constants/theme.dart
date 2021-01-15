import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/create_material_color.dart';

mixin AppTheme {
  static const Size appBarHeight = Size.fromHeight(48);
  static const Color primaryColor = Color(0xFF025DA9);
  static final TextTheme primaryTextTheme = Typography.material2018().black;
  static final MaterialColor primarySwatch = createMaterialColor(primaryColor);
  static const Color blueAccent = Color(0xFF7AB9DE);
  static const Color linkedInColor = Color(0xFF0073b3);
  static const Color facebookColor = Color(0xFF405695);
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const Color primaryLightStatusBar = Color(0x0D000000);
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    primarySwatch: primarySwatch,
    fontFamily: 'Aeonik',
    dividerTheme: DividerThemeData(
      space: AppInsets.xs,
      color: Colors.grey[400],
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
      textTheme: primaryTextTheme,
      color: Colors.grey[800],
      brightness: Brightness.light,
      actionsIconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
    ),
    canvasColor: Colors.grey[100],
    backgroundColor: Colors.grey[100],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionHandleColor: primaryColor,
    cursorColor: primaryColor,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[850],
    canvasColor: Colors.grey[800],
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    accentColor: primaryColor,
    appBarTheme: AppBarTheme(
      textTheme: primaryTextTheme,
      color: Colors.white,
      brightness: Brightness.light,
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
  );

  static const ShapeBorder bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
      topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
    ),
  );
}

mixin AppPadding {
  static const tiny = 4.0;
  static const sm = 8.0;
  static const med = 16.0;
  static const l = 24.0;
}

mixin AppInsets {
  static const xs = 2.0;
  static const sm = 4.0;
  static const med = 8.0;
  static const l = 12.0;
  static const xl = 16.0;
  static const xxl = 20.0;
  static const listDividerInset = 72.00;
}

mixin AppBorderRadius {
  static const textInput = 12.0;
  static const largeButton = 24.0;
  static const bottomSheetRadius = 16.0;
}
