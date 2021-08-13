import 'package:flutter/material.dart';

class BaseErrorText extends StatelessWidget {
  final String text;

  const BaseErrorText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).errorColor,
      ),
    );
  }
}
