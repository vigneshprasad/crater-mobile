import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class BaseLargeIconButton extends MaterialButton {
  final IconData icon;
  final String text;

  const BaseLargeIconButton({
    @required VoidCallback onPressed,
    @required this.icon,
    @required this.text,
    Widget child,
  }) : super(
          onPressed: onPressed,
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 76.00;
    const buttonWidth = 76.00;
    const iconSize = 28.00;
    const borderRadius = 8.0;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
              ),
              const SizedBox(height: AppInsets.med),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
