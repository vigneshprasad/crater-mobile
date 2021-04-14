import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../features/rewards/presentation/widgets/redeem_button.dart';

class SuccessPopup extends ModalRoute<void> {
  final String title;
  final String message;
  final String buttonTitle;
  final AssetImage iconAsset;

  SuccessPopup(
      {@required this.title,
      @required this.message,
      @required this.buttonTitle,
      @required this.iconAsset});

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  bool get barrierDismissible => false;

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
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 96,
                        backgroundImage: iconAsset,
                      ),
                      const SizedBox(height: AppInsets.l),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: successStyle,
                      ),
                      const SizedBox(height: AppInsets.med),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: descStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppInsets.xl),
                  child: RedeemButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(buttonTitle),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
