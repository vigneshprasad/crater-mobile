import 'package:flutter/material.dart';

import '../../../../../constants/theme.dart';

const kBottomPadding = 76.00;

class RoundTableCardLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const RoundTableCardLayout({
    Key key,
    @required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      heightFactor: 1,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: kBottomPadding,
        ),
        child: Material(
          type: MaterialType.card,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 2,
          child: InkWell(
            hoverColor: Colors.white,
            highlightColor: Colors.grey[100],
            splashColor: Colors.grey[300],
            onTap: onPressed != null
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppInsets.l,
                horizontal: AppInsets.xl,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
