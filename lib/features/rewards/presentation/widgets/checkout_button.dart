import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class CheckoutButton extends MaterialButton {
  final double? width;

  const CheckoutButton({
    required Widget child,
    required VoidCallback onPressed,
    Color? textColor,
    this.width,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final buttonTheme = Theme.of(context).buttonTheme;
    const buttonHeight = 48.00;

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: buttonHeight,
      child: RawMaterialButton(
        fillColor: buttonTheme.getFillColor(this),
        splashColor: buttonTheme.getSplashColor(this),
        focusColor: buttonTheme.getFocusColor(this),
        highlightColor: buttonTheme.getHighlightColor(this),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        ),
        textStyle: theme.textTheme.button?.copyWith(
          fontSize: 15,
          color: textColor ?? buttonTheme.getTextColor(this),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
