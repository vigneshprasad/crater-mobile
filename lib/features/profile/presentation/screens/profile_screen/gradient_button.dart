import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;
  final double? fontSize;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.style,
    this.gradient,
    this.thickness = 2,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: [
      HexColor.fromHex('#DF3E83'),
      HexColor.fromHex('#2F80ED'),
      HexColor.fromHex('#65C7CC'),
    ]);
    final gradientDB = LinearGradient(colors: [
      HexColor.fromHex('#141D1F'),
      HexColor.fromHex('#29373C'),
    ]);
    final thickness = 1.0;
    final radius = 8.0;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius + 3),
          border: Border.all(
            color: HexColor.fromHex('#4F4F4F'),
          )),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradientDB,
            borderRadius: BorderRadius.circular(radius),
          ),
          height: 28,
          margin: EdgeInsets.all(thickness),
          child: OutlinedButton(
            onPressed: onPressed,
            style: style,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: fontSize ?? 16),
            ),
          ),
        ),
      ),
    );
  }
}
