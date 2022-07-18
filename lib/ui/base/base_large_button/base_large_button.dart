import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

class BaseLargeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool enabled;
  final bool outlined;
  const BaseLargeButton({
    Key? key,
    this.onPressed,
    this.text,
    this.enabled = true,
    this.outlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 40.00;
    final textStyle = Theme.of(context)
        .textTheme
        .button!
        .copyWith(color: enabled ? Colors.white : Colors.white10);
    final color = outlined
        ? null
        : enabled
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.secondary.withAlpha(70);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
        border: outlined ? Border.all(color: Colors.white54) : null,
        color: color,
      ),
      child: SizedBox(
        // width: buttonWidth,
        height: buttonHeight,
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.largeButton),
          ),
          onPressed: enabled ? onPressed : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text ?? '',
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
