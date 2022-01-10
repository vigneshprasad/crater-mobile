import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class BaseBottomSheetRoute extends PopupRoute<void> {
  final Widget child;
  final double initialHeightRatio;
  final double maxScrollRatio;

  BaseBottomSheetRoute({
    required this.child,
    this.initialHeightRatio = 0.5,
    this.maxScrollRatio = 1.0,
  });

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent < 0.2) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
            return true;
          }
        }
        return false;
      },
      child: DraggableScrollableSheet(
        maxChildSize: maxScrollRatio,
        initialChildSize: initialHeightRatio,
        minChildSize: 0.1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Material(
              shape: AppTheme.bottomSheetShape,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
                  topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
