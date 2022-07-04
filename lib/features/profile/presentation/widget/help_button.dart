import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HelpButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.help,
        color: Colors.white,
      ),
      onPressed: () => {},
    );
  }
}
