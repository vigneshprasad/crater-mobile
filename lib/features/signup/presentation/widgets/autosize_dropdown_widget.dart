import 'package:flutter/material.dart';

import '../../../../ui/base/base_dropdown/base_dropdown.dart';
import '../../domain/entity/profile_intro_meta.dart';
import '../../domain/entity/profile_intro_question.dart';

class AutoSizeDropdown extends StatelessWidget {
  const AutoSizeDropdown({
    Key key,
    @required this.element,
    this.value,
    @required this.onValuesChange,
  }) : super(key: key);

  static const charWidth = 8;
  static const padding = 52;

  final Function(String, dynamic) onValuesChange;
  final ProfileIntroElement element;
  final ProfileIntroMeta value;

  double getWidthOfLargestOption(List<ProfileIntroMeta> items) {
    final options = items.cast<ProfileIntroMeta>();
    final ProfileIntroMeta largestOption = options.reduce((value, element) {
      return (element.name.length > value.name.length) ? element : value;
    });
    return (largestOption.name.length * charWidth + padding).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthOfLargestOption(element.options),
      margin: const EdgeInsets.only(right: 4),
      child: BaseDropdown<ProfileIntroMeta>(
          key: Key(element.id),
          value: value,
          listItems: element.options,
          labelGetter: (lbl) => lbl.name,
          validator: (value) {
            return value == null ? 'Select a value' : null;
          },
          onChanged: (value) {
            onValuesChange(element.id, value.value);
          }),
    );
  }
}
