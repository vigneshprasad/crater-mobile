import 'package:flutter/material.dart';

import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

class SuccessPopup extends ModalRoute<void> {
  final String title;
  final String message;
  final String buttonTitle;
  final AssetImage iconAsset;
  final VoidCallback onButtonClicked;

  SuccessPopup({
    required this.title,
    required this.message,
    required this.buttonTitle,
    required this.iconAsset,
    required this.onButtonClicked,
  });

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

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
    final successStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
          fontSize: 18,
        );
    final descStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 15,
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
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: iconAsset,
                        height: 75,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
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

class RedeemButton extends MaterialButton {
  final double? width;
  final ButtonThemeData? buttonTheme;

  const RedeemButton({
    required Widget child,
    required VoidCallback onPressed,
    Color? textColor,
    this.width,
    this.buttonTheme,
  }) : super(
          onPressed: onPressed,
          child: child,
          textColor: textColor,
        );

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 48.00;

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: buttonHeight,
      child: BaseContainer(
        radius: buttonHeight / 2,
        child: TextButton(
          onPressed: onPressed,
          child: child!,
        ),
      ),
    );
  }
}
