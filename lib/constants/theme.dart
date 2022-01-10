import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/create_material_color.dart';

mixin AppTheme {
  static const Size appBarHeight = Size.fromHeight(48);
  static const Color primaryColor2 = Color(0xFF025DA9);
  static const Color primaryColor = Color(0xFF283845);
  static final TextTheme primaryTextTheme = Typography.material2018().black;
  static final MaterialColor primarySwatch = createMaterialColor(primaryColor);
  static const Color blueAccent = Color(0xFFCDDAFD);
  static const Color blueAccentDark = Color(0xFF86A0E6);
  static const Color cardColor = Color(0xFFF5F6FB);
  static const Color linkedInColor = Color(0xFF0073b3);
  static const Color facebookColor = Color(0xFF405695);
  static const Color errorColor = Color(0xFFBC4749);
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const Color canvasColor = Color(0xFFFEFDFD);

  static const Color primaryLightStatusBar = Color(0x0D000000);
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    primarySwatch: primarySwatch,
    fontFamily: 'Apercu',
    dividerTheme: DividerThemeData(
      space: AppInsets.xs,
      color: Colors.grey[400],
    ),
    cardColor: cardColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
      textTheme: primaryTextTheme,
      color: canvasColor,
      brightness: Brightness.light,
      actionsIconTheme: IconThemeData(
        color: Colors.grey[800],
      ),
    ),
    errorColor: errorColor,
    canvasColor: canvasColor,
    backgroundColor: Colors.grey[100],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: primaryColor,
      cursorColor: primaryColor,
    ),
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
  static const largeButton = 8.0;
  static const bottomSheetRadius = 24.0;
}
