import 'package:flutter/material.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

enum BaseLargeButtonStyle {
  primary,
  secondary,
  destructive,
}

class BaseLargeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool enabled;
  final bool outlined;
  final BaseLargeButtonStyle style;
  final IconData? icon;
  const BaseLargeButton({
    Key? key,
    this.onPressed,
    this.text,
    this.enabled = true,
    this.outlined = false,
    this.style = BaseLargeButtonStyle.primary,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).textTheme.button?.color;
    switch (style) {
      case BaseLargeButtonStyle.primary:
        color = Theme.of(context).primaryColor;
        textColor = Colors.white;
        break;

      case BaseLargeButtonStyle.secondary:
        color = Colors.white;
        textColor = Colors.black;
        break;

      case BaseLargeButtonStyle.destructive:
        color = Colors.redAccent;
        textColor = Colors.black;
    }
    return NeoPopButton(
      color: color,
      onTapUp: enabled ? onPressed : null,
      enabled: enabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 14),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              text ?? '',
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  icon,
                  size: 20,
                  color: textColor,
                ),
              )
          ],
        ),
      ),
    );
  }
}
