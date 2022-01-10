import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/profile_intro_meta.dart';
import '../../domain/entity/profile_intro_question.dart';
import 'autosize_dropdown_widget.dart';
import 'autosize_multiselect_dropdown.dart';
import 'autosize_textfield_widget.dart';

class ProfileInlineQuestion extends StatelessWidget {
  final List<ProfileIntroElement> elements;
  final Map<String, dynamic> values;
  final Function(String, dynamic) onValuesChange;
  final bool animateText;

  const ProfileInlineQuestion({
    Key? key,
    required this.elements,
    required this.values,
    required this.onValuesChange,
    required this.animateText,
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
                    if (animateText == true)
                      AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(element.value!,
                              textStyle: Theme.of(context).textTheme.bodyText1)
                        ],
                      )
                    else
                      Text(
                        element.value!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                  ],
                ),
              );

            case ProfileIntroElementType.text:
              return AutoSizeTextField(
                  value: values[element.id]?.toString(),
                  element: element,
                  onValuesChange: onValuesChange);

            case ProfileIntroElementType.dropdown:
              return AutoSizeDropdown(
                  value: values[element.id] != null
                      ? element.options!.firstWhere((option) =>
                          option.value == (values[element.id] as int))
                      : null,
                  element: element,
                  onValuesChange: onValuesChange);

            case ProfileIntroElementType.multiselect:
              return AutoSizeMultiSelectDropdown(
                  initialValue: values[element.id] as List<ProfileIntroMeta>,
                  element: element,
                  onValuesChange: onValuesChange);

            case ProfileIntroElementType.newline:
              return const SizedBox(width: double.infinity, height: 40);

            default:
              return Container();
          }
        }).toList());
  }
}
