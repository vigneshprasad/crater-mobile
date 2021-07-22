import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final Icon? icon;
  final VoidCallback onPressed;

  const BaseIconButton({
    Key? key,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 1,
      fillColor: const Color(0xFFF2F2F2),
      focusColor: Colors.black12,
      splashColor: Colors.black26,
      constraints: const BoxConstraints(
        minHeight: 36,
        minWidth: 36,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
