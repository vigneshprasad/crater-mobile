import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class BaseFormInput extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final bool autovalidate;
  final bool autocorrect;
  final bool enabled;
  final FormFieldValidator<String> validator;

  const BaseFormInput({
    Key key,
    @required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.autovalidate = true,
    this.autocorrect = false,
    this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      autovalidate: autovalidate,
      autocorrect: autocorrect,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
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
