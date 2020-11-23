import 'package:flutter/material.dart';

class DiscountSliderIndicator extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final int min;
  final int max;

  const DiscountSliderIndicator({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.grey[900] //Thumb Background Color
      ..style = PaintingStyle.fill;

    final TextSpan pointSpan = TextSpan(
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1,
        color: Colors.white,
      ),
      text: getValue(value),
    );

    final TextPainter pointsPainter = TextPainter(
      text: pointSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    pointsPainter.layout();

    final Offset pointsOffset = Offset(
      center.dx - (pointsPainter.width / 2),
      -24,
    );

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, -18),
        width: pointsPainter.width + 20,
        height: pointsPainter.height + 12,
      ),
      const Radius.circular(8),
    );

    canvas.drawRRect(rRect, paint);
    canvas.drawCircle(center, 8.0, paint);
    pointsPainter.paint(canvas, pointsOffset);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
