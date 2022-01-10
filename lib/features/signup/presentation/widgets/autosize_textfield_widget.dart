import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../domain/entity/profile_intro_question.dart';

class AutoSizeTextField extends StatefulWidget {
  const AutoSizeTextField({
    Key? key,
    required this.element,
    required this.onValuesChange,
    this.value,
  }) : super(key: key);

  final ProfileIntroElement element;
  final String? value;
  final Function(String, dynamic) onValuesChange;

  static const charWidth = 10;
  static const padding = 20;

  @override
  _AutoSizeTextFieldState createState() => _AutoSizeTextFieldState();
}

class _AutoSizeTextFieldState extends State<AutoSizeTextField> {
  @override
  void initState() {
    text = '';
    width = getWidth();
    super.initState();
  }

  double getWidth() {
    if (widget.element.width != null) {
      return widget.element.width!;
    }

    final length = max(widget.element.placeholder!.length, text.length);
    final width =
        (length * AutoSizeTextField.charWidth + AutoSizeTextField.padding)
            .toDouble();
    return max(width, 120);
  }

  double? width;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 4),
      child: BaseFormInput(
          initialValue: widget.value ?? '',
          label: widget.element.placeholder!,
          key: Key(widget.element.id!),
          autovalidate: false,
          minLines: widget.element.lines,
          validator: (value) {
            if (widget.element.optional!) {
              return null;
            }
            return value!.isEmpty ? 'Enter ${widget.element.id}' : null;
          },
          onChanged: (value) {
            widget.onValuesChange(widget.element.id!, value);
            text = value;
            setState(() {
              width = getWidth();
            });
          }),
    );
  }
}
