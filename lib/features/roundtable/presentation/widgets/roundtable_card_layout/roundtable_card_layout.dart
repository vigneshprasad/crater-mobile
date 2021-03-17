import 'package:flutter/material.dart';

import '../../../../../constants/theme.dart';

const kBottomPadding = 40.00;

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
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppInsets.med,
            left: AppInsets.med,
            bottom: kBottomPadding,
          ),
          child: Material(
            type: MaterialType.card,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
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
                padding: const EdgeInsets.only(
                  left: AppInsets.xl,
                  right: AppInsets.xl,
                  top: 24,
                  bottom: AppInsets.xl,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
