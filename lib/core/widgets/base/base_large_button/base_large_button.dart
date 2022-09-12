import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

enum LargeButtonStyle {
  fill,
  outline,
}

class BaseLargeButton extends MaterialButton {
  final double? width;
  final ButtonThemeData? buttonTheme;
  final LargeButtonStyle style;

  const BaseLargeButton({
    required Widget child,
    required VoidCallback onPressed,
    Color? textColor,
    this.width,
    this.buttonTheme,
    this.style = LargeButtonStyle.fill,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  const BaseLargeButton.outline({
    required Widget child,
    required VoidCallback onPressed,
    Color? textColor,
    this.width,
    this.buttonTheme,
    this.style = LargeButtonStyle.outline,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final buttonThemeData = buttonTheme ?? Theme.of(context).buttonTheme;
    const buttonHeight = 48.00;

    if (style == LargeButtonStyle.fill) {
      return SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: buttonHeight,
        child: RawMaterialButton(
          splashColor: buttonThemeData.getSplashColor(this),
          focusColor: buttonThemeData.getFocusColor(this),
          highlightColor: buttonThemeData.getHighlightColor(this),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
          ),
          textStyle: theme.textTheme.button,
          onPressed: onPressed,
          child: child,
        ),
      );
    } else if (style == LargeButtonStyle.outline) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: buttonHeight,
        child: OutlinedButton(
          // borderSide: ,
          // highlightColor: buttonThemeData.getHighlightColor(this),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppBorderRadius.largeButton),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: theme.primaryColor, width: 2),
            ),
          ),
          onPressed: onPressed,
          child: child ?? Container(),
        ),
      );
    }

    return Container();
  }
}
