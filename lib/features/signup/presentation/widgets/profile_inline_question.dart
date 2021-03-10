import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';
import 'package:worknetwork/features/signup/domain/entity/profile_intro_question.dart';
import 'package:worknetwork/features/signup/presentation/widgets/autosize_multiselect_dropdown.dart';

import 'autosize_dropdown_widget.dart';
import 'autosize_textfield_widget.dart';

class ProfileInlineQuestion extends StatelessWidget {
  final List<ProfileIntroElement> elements;
  final Map<String, dynamic> values;
  final Function(String, dynamic) onValuesChange;
  final bool animateText;

  const ProfileInlineQuestion({
    Key key,
    this.elements,
    this.values,
    this.onValuesChange,
    this.animateText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 4,
        runSpacing: 8,
        children: elements.map((element) {
          switch (element.type) {
            case ProfileIntroElementType.label:
              return SizedBox(
                height: 48,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TyperAnimatedTextKit(
                        totalRepeatCount: 1,
                        repeatForever: false,
                        speed: animateText == true
                            ? const Duration(milliseconds: 40)
                            : Duration.zero,
                        text: [element.value],
                        textStyle: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              );
              break;

            case ProfileIntroElementType.text:
              return AutoSizeTextField(
                  value: values[element.id]?.toString(),
                  element: element,
                  onValuesChange: onValuesChange);
              break;

            case ProfileIntroElementType.dropdown:
              return AutoSizeDropdown(
                  value: values[element.id] != null
                      ? element.options.firstWhere((option) =>
                          option.value == (values[element.id] as int))
                      : null,
                  element: element,
                  onValuesChange: onValuesChange);
              break;

            case ProfileIntroElementType.multiselect:
              return AutoSizeMultiSelectDropdown(
                  initialValue:
                      (values[element.id] as List<ProfileIntroMeta>) ?? [],
                  element: element,
                  onValuesChange: onValuesChange);
              break;

            default:
              return Container();
          }
        }).toList());
  }
}
