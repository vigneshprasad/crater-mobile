import 'package:flutter/material.dart';

import '../../../constants/theme.dart';

class BaseInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  const BaseInput({
    Key key,
    @required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppBorderRadius.textInput),
            ),
          ),
          filled: true,
          hintText: label,
          labelStyle: const TextStyle(fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppInsets.med,
            horizontal: AppInsets.l,
          )),
    );
  }
}
