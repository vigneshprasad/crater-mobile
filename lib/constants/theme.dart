import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worknetwork/utils/create_material_color.dart';

mixin AppTheme {
  static const Size appBarHeight = Size.fromHeight(48);
  static const Color primaryColor = Color(0xFFD3596C);
  static final TextTheme primaryTextTheme = Typography.material2018().black;
  static final MaterialColor primarySwatch = createMaterialColor(primaryColor);
  static const Color blueAccent = Color(0xFF7AB9DE);
  static const Color linkedInColor = Color(0xFF0073b3);
  static const Color facebookColor = Color(0xFF405695);

  static const Color primaryLightStatusBar = Color(0x0D000000);
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primarySwatch: primarySwatch,
      fontFamily: 'Aeonik',
      textTheme: primaryTextTheme,
      dividerTheme: DividerThemeData(
        space: AppInsets.xs,
        color: Colors.grey[400],
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: AppBarTheme(
        textTheme: primaryTextTheme,
        color: Colors.white,
        brightness: Brightness.light,
        actionsIconTheme: const IconThemeData(
          color: Colors.black87,
        ),
      ),
      canvasColor: Colors.grey[50],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionHandleColor: primaryColor,
      cursorColor: primaryColor);

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: createMaterialColor(primaryColor),
    fontFamily: 'Aeonik',
    visualDensity: VisualDensity.adaptivePlatformDensity,
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
}
