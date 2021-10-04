import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final String? bgText;
  const UnderlinedText(
    this.text, {
    this.bgText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const showBGText = true;
    if (!showBGText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          Container(
            width: 10,
            height: 2,
            color: Colors.white,
          )
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (bgText != null)
            BorderedText(
              strokeWidth: 1,
              strokeColor: Colors.white38,
              child: Text(
                bgText!,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Container(
                  width: 10,
                  height: 2,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
