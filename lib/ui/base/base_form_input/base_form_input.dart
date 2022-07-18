import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

class BaseFormInput extends StatelessWidget {
  final String label;
  final Widget? icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final bool autovalidate;
  final bool autocorrect;
  final bool enabled;
  final bool autoFocus;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  const BaseFormInput({
    Key? key,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.autovalidate = true,
    this.autocorrect = false,
    this.autoFocus = false,
    this.validator,
    this.enabled = true,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(AppBorderRadius.textInput),
    );
    return TextFormField(
      enabled: enabled,
      autovalidateMode:
          autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      initialValue: initialValue,
      autocorrect: autocorrect,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      autofocus: autoFocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: icon,
        enabledBorder: const OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).errorColor,
          ),
        ),
        filled: true,
        hintText: label,
        hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 15,
              color: Colors.grey,
            ),
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppInsets.med,
          horizontal: AppInsets.l,
        ),
      ),
    );
  }
}
