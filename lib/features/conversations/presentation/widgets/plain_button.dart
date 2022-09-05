import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class PlainButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final IconData? icon;
  final Color? borderColor;
  final Color? bgColor;
  final Color? textColor;
  const PlainButton({
    Key? key,
    required this.title,
    this.icon,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? Colors.transparent));
    return MaterialButton(
      color: bgColor ?? HexColor.fromHex('#1C1C1E'),
      shape: border,
      onPressed: onPressed,
      splashColor: bgColor ?? HexColor.fromHex('#1C1C1E'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(fontSize: 12)
                .copyWith(color: textColor),
          ),
          if (icon != null)
            Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  icon,
                  size: 16,
                  color: textColor,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
