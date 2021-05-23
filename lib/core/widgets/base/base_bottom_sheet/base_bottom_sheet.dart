import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class BaseBottomSheet extends StatelessWidget {
  final bool showIndicator;
  final Widget child;

  const BaseBottomSheet({
    Key key,
    this.showIndicator = true,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.xxl, horizontal: AppInsets.xl),
      child: Column(
        children: [
          if (showIndicator)
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          if (showIndicator) const SizedBox(height: AppInsets.xl),
          if (child != null) child,
        ],
      ),
    );
  }
}
