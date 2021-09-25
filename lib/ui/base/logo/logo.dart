import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/theme.dart';

class Logo extends StatelessWidget {
  static const logoAsset = 'assets/images/logo.png';
  final bool withText;
  final bool withSubtext;

  const Logo({
    Key? key,
    this.withText = true,
    this.withSubtext = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppInsets.med),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 48,
            child: Image.asset(
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
        'Crater',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      if (withSubtext)
        const Text(
          'Formerly Worknetwork',
          style: TextStyle(
            fontSize: 14,
          ),
        )
    ];
  }
}
