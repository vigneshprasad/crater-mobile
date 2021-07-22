import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class ProfileFormInput extends StatelessWidget {
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final String? initialValue;
  final bool autocorrect;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final TextStyle? style;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;

  const ProfileFormInput({
    Key? key,
    this.initialValue,
    this.controller,
    this.validator,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.decoration,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autocorrect = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.style,
    this.onEditingComplete,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.65,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled,
        autovalidateMode: autovalidateMode,
        initialValue: initialValue,
        autocorrect: autocorrect,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        maxLines: maxLines,
        minLines: minLines,
        onChanged: onChanged,
        style: style,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        decoration: decoration ??
            const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: AppInsets.sm,
                horizontal: AppInsets.med,
              ),
            ),
      ),
    );
  }
}
