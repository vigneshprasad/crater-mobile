import 'dart:math';

import 'package:flutter/material.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_question.dart';
import 'package:worknetwork/features/signup/presentation/widgets/multiselect_dropdown.dart';

class AutoSizeMultiSelectDropdown extends StatelessWidget {
  const AutoSizeMultiSelectDropdown(
      {Key key,
      @required this.element,
      @required this.onValuesChange,
      @required this.initialValue})
      : super(key: key);

  static const charWidth = 8;
  static const padding = 52;

  final Function(String, dynamic) onValuesChange;
  final ProfileIntroElement element;
  final List<ProfileIntroMeta> initialValue;

  double getWidthOfLargestOption(List<ProfileIntroMeta> items) {
    final options = items.cast<ProfileIntroMeta>();
    final ProfileIntroMeta largestOption = options.reduce((value, element) {
      return (element.name.length > value.name.length) ? element : value;
    });
    final itemWidth = largestOption.name.length * charWidth + padding;
    int characters = 0;
    initialValue.forEach((element) {
      characters += element.name.length;
    });
    final selectedWidth =
        characters * charWidth + padding + (initialValue.length * 44);

    return max(itemWidth, selectedWidth).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthOfLargestOption(element.options),
      margin: const EdgeInsets.only(right: 4),
      child: MultiSelectDropdown<ProfileIntroMeta>(
          key: Key(element.id),
          initialValue: initialValue,
          items: element.options,
          labelGetter: (lbl) => lbl.name,
          label: '',
          // validator: (value) {
          //   return value == null ? 'Select a value' : null;
          // },
          onChangeItems: (value) {
            onValuesChange(element.id, value);
          }),
    );
  }
}
