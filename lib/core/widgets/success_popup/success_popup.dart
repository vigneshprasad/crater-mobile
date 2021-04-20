import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/rewards/presentation/widgets/redeem_button.dart';

class SuccessPopup extends ModalRoute<void> {
  final String title;
  final String message;
  final String buttonTitle;
  final AssetImage iconAsset;
  final VoidCallback onButtonClicked;

  SuccessPopup(
      {@required this.title,
      @required this.message,
      @required this.buttonTitle,
      @required this.iconAsset,
      @required this.onButtonClicked});

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final successStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontSize: 18,
        );
    final descStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: iconAsset, height: 75),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: successStyle,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: descStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  RedeemButton(
                    onPressed: onButtonClicked,
                    child: Text(buttonTitle),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
