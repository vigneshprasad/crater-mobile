import 'package:flutter/material.dart';
import 'package:worknetwork/core/widgets/base/base_card_button/base_card_button.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../constants/theme.dart';

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
      child: BaseContainer(
        radius: buttonHeight / 2,
        child: FlatButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
