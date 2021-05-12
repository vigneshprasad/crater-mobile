import 'package:flutter/material.dart';

class ScaffoldContainer extends StatelessWidget {
  final Widget child;

  const ScaffoldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.0, 0.0),
              end: Alignment(0.0, 1.0),
              colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).canvasColor,
          ])),
      child: child,
    );
  }
}
