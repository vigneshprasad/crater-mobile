import 'package:flutter/material.dart';

import '../../../constants/theme.dart';

class TabHeader extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Widget action;

  const TabHeader({
    Key key,
    @required this.heading,
    this.subHeading,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (heading.isNotEmpty)
                  Text(
                    heading,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                const SizedBox(height: AppPadding.tiny),
                if (subHeading != null)
                  Text(
                    subHeading,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.black45),
                  ),
              ],
            ),
          ),
          if (action != null) action
        ],
      ),
    );
  }
}
