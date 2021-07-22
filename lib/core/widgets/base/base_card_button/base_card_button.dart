import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class BaseCardButton extends MaterialButton {
  final ButtonThemeData? buttonTheme;

  const BaseCardButton({
    required Widget child,
    required VoidCallback onPressed,
    Color? textColor,
    this.buttonTheme,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final buttonThemeData = buttonTheme ?? Theme.of(context).buttonTheme;
    const buttonHeight = 36.00;

    return SizedBox(
      height: buttonHeight,
      child: RawMaterialButton(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        onPressed: onPressed,
        fillColor: buttonThemeData.getFillColor(this),
        splashColor: buttonThemeData.getSplashColor(this),
        focusColor: buttonThemeData.getFocusColor(this),
        highlightColor: buttonThemeData.getHighlightColor(this),
        textStyle: theme.textTheme.button?.copyWith(
          color: textColor ?? buttonThemeData.getTextColor(this),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        ),
        child: child,
      ),
    );
  }
}
