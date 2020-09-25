import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/theme.dart';

class Logo extends StatelessWidget {
  static const logoAsset = 'assets/svg/logo.svg';
  final bool withText;

  const Logo({Key key, this.withText = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppInsets.med),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 48,
            child: SvgPicture.asset(
              logoAsset,
            ),
          ),
          if (withText) ...getText()
        ],
      ),
    );
  }

  List<Widget> getText() {
    return [
      const SizedBox(
        width: AppPadding.sm,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getTextChildren(),
      )
    ];
  }

  List<Widget> getTextChildren() {
    return <Widget>[
      const Text(
        'WorkNetwork',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
      const Text(
        'Do more together',
        style: TextStyle(
          fontSize: 14,
        ),
      )
    ];
  }
}
