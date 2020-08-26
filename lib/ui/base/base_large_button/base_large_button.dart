import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class BaseLargeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const BaseLargeButton({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width * 0.6;
    const buttonHeight = 48.00;
    final textStyle = Theme.of(context).textTheme.button.copyWith(
          color: Colors.white,
        );
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        ),
        fillColor: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: textStyle,
        ),
      ),
    );
  }
}
