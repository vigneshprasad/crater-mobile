import 'package:flutter/material.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

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
    final textStyle = Theme.of(context).textTheme.button;
    return BaseContainer(
      radius: AppBorderRadius.largeButton,
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
          ),
          onPressed: enabled ? onPressed : null,
          child: Text(
            text.toUpperCase(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
