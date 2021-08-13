import 'package:flutter/material.dart';

class BaseBadge extends StatelessWidget {
  final int count;
  final Widget child;
  final bool showCount;

  const BaseBadge({
    Key? key,
    required this.child,
    required this.count,
    this.showCount = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
        fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700);
    return Stack(
      fit: StackFit.passthrough,
      // overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        child,
        if (count > 0)
          Positioned(
            right: -6,
            bottom: -6,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
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
