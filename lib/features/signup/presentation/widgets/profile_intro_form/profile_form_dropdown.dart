import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/theme.dart';

typedef LabelGetter<T> = String Function(T item);

const charWidth = 8;
const padding = 52;

class _ProfileFormDropDown<T> extends HookWidget {
  final List<T> items;
  final LabelGetter<T> labelGetter;
  final ValueChanged<T> onChanged;

  const _ProfileFormDropDown({
    @required this.items,
    @required this.labelGetter,
    this.onChanged,
  });

  double getWidthOfLargestOption(List<T> items) {
    final String largestOption = items.fold("", (previousValue, element) {
      return labelGetter(element).length > previousValue.length
          ? labelGetter(element)
          : previousValue;
    });
    return (largestOption.length * charWidth + padding).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final state = useState<T>();
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: getWidthOfLargestOption(items),
      ),
      child: ButtonTheme(
        child: DropdownButtonFormField<T>(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppInsets.sm,
              horizontal: AppInsets.med,
            ),
          ),
          value: state.value,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(labelGetter(item)),
                  ))
              .toList(),
          onChanged: (val) {
            state.value = val;
            if (onChanged != null) {
              onChanged(val);
            }
          },
        ),
      ),
    );
  }
}

class ProfileFormDropDown<T> extends FormField<T> {
  final List<T> items;
  final LabelGetter<T> labelGetter;
  final ValueChanged<T> onChanged;

  ProfileFormDropDown({
    T initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    this.items,
    @required this.labelGetter,
    this.onChanged,
  }) : super(
          autovalidateMode: autovalidateMode,
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          builder: (state) => _ProfileFormDropDown<T>(
            items: items,
            labelGetter: labelGetter,
            onChanged: (val) {
              state.didChange(val);
              if (onChanged != null) {
                onChanged(val);
              }
            },
          ),
        );
}
