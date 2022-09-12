import 'package:flutter/material.dart';

class ScaffoldContainer extends StatelessWidget {
  final Widget? child;

  const ScaffoldContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.0, -0.999),
          colors: [
            Theme.of(context).appBarTheme.backgroundColor!,
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
        // color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: child,
    );
  }
}
