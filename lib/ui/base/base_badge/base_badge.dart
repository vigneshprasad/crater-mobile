import 'package:flutter/material.dart';

class BaseBadge extends StatelessWidget {
  final int count;
  final Widget child;
  final bool showCount;

  const BaseBadge({
    Key key,
    @required this.child,
    @required this.count,
    this.showCount = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: 10, color: Colors.white);
    return Stack(
      children: [
        child,
        if (count > 0)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.center,
              child:
                  showCount ? Text(count.toString(), style: countStyle) : null,
            ),
          )
      ],
    );
  }
}
