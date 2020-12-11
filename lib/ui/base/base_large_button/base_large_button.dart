import 'package:flutter/material.dart';

import '../../../constants/theme.dart';

class BaseLargeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool enabled;
  const BaseLargeButton({
    Key key,
    this.onPressed,
    this.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width * 0.6;
    const buttonHeight = 48.00;
    final textStyle = Theme.of(context).textTheme.button.copyWith(
          color: Colors.white,
        );
    final fillColor =
        onPressed == null ? Colors.grey : Theme.of(context).primaryColor;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        ),
        fillColor: fillColor,
        onPressed: enabled ? onPressed : null,
        child: Text(
          text.toUpperCase(),
          style: textStyle,
        ),
      ),
    );
  }
}
