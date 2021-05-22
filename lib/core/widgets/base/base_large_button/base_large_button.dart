import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

enum ButtonStyle {
  fill,
  outline,
}

class BaseLargeButton extends MaterialButton {
  final double width;
  final ButtonThemeData buttonTheme;
  final ButtonStyle style;

  const BaseLargeButton({
    @required Widget child,
    @required VoidCallback onPressed,
    Color textColor,
    this.width,
    this.buttonTheme,
    this.style = ButtonStyle.fill,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  const BaseLargeButton.outline({
    @required Widget child,
    @required VoidCallback onPressed,
    Color textColor,
    this.width,
    this.buttonTheme,
    this.style = ButtonStyle.outline,
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

    if (style == ButtonStyle.fill) {
      return SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: buttonHeight,
        child: RawMaterialButton(
          // fillColor: Theme.of(context)
          // .buttonColor, // buttonThemeData.getFillColor(this),
          splashColor: buttonThemeData.getSplashColor(this),
          focusColor: buttonThemeData.getFocusColor(this),
          highlightColor: buttonThemeData.getHighlightColor(this),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
          ),
          textStyle: theme.textTheme.button.copyWith(
              // color: Colors.black // ?? buttonThemeData.getTextColor(this),
              ),
          onPressed: onPressed,
          child: child,
        ),
      );
    } else if (style == ButtonStyle.outline) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: buttonHeight,
        child: OutlineButton(
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
          highlightColor: buttonThemeData.getHighlightColor(this),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
          ),
          onPressed: onPressed,
          child: child,
        ),
      );
    }

    return Container();
  }
}
