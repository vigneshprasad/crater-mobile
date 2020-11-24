import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class RedeemButton extends MaterialButton {
  final double width;
  final ButtonThemeData buttonTheme;

  const RedeemButton({
    @required Widget child,
    @required VoidCallback onPressed,
    Color textColor,
    this.width,
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
    const buttonHeight = 48.00;

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: buttonHeight,
      child: RawMaterialButton(
        fillColor: buttonThemeData.getFillColor(this),
        splashColor: buttonThemeData.getSplashColor(this),
        focusColor: buttonThemeData.getFocusColor(this),
        highlightColor: buttonThemeData.getHighlightColor(this),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        ),
        textStyle: theme.textTheme.button.copyWith(
          color: textColor ?? buttonThemeData.getTextColor(this),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
