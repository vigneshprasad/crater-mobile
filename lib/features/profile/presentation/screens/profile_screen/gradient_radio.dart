import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class GradientRadio extends StatelessWidget {
  final Function(bool) onPressed;
  final ButtonStyle? style;
  final Gradient? gradient;
  final double thickness;
  bool isEnabled;

  GradientRadio({
    Key? key,
    required this.onPressed,
    this.style,
    this.gradient,
    this.thickness = 2,
    required this.isEnabled,
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
    final thickness = 4.0;
    final radius = 16.0;
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
      children: [
        Text('NO', style: style),
        Container(
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
              height: 24,
              width: 100,
              margin: EdgeInsets.all(thickness),
              child: Switch(
                value: isEnabled,
                onChanged: (value) {
                  isEnabled = value;
                  onPressed(value);
                },
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                inactiveThumbColor: Colors.white,
              ),
            ),
          ),
        ),
        Text('YES', style: style),
      ],
    );
  }
}
