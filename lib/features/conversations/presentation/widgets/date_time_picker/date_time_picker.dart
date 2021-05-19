import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../../constants/theme.dart';

class DateTimePicker extends HookWidget {
  final List<DateTime> slots;
  final ValueChanged<DateTime> onChanged;

  const DateTimePicker({
    @required this.slots,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = useState<DateTime>(null);
    final dateFormat = DateFormat.yMMMMd('en_US');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Date: ${dateFormat.format(slots[0])}"),
        const SizedBox(height: AppInsets.med),
        Wrap(
          spacing: AppInsets.xl,
          children: [
            ...slots
                .map((slot) => _Slot(
                      slot: slot,
                      selected: selected.value == slot,
                      isNow: false,
                      onPressed: (value) {
                        selected.value = value;
                        if (onChanged != null) {
                          onChanged(selected.value);
                        }
                      },
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }
}

class _Slot extends StatelessWidget {
  final DateTime slot;
  final bool selected;
  final bool isNow;
  final ValueChanged<DateTime> onPressed;

  const _Slot({
    Key key,
    @required this.isNow,
    @required this.slot,
    @required this.selected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.00));
    final timeFormat = DateFormat.jm();
    final width = MediaQuery.of(context).size.width / 2 - AppInsets.xxl * 4;

    final primaryColor = Theme.of(context).primaryColor;
    final background = Theme.of(context).canvasColor;
    final borderColor = selected ? primaryColor : Colors.transparent;
    final textColor = !selected ? Colors.white : primaryColor;
    final border = Border.all(
      color: borderColor,
      width: 1.00,
    );

    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
          color: textColor,
        );
    final label = isNow ? "Now" : timeFormat.format(slot);
    return Padding(
      padding: const EdgeInsets.all(AppInsets.xxl),
      child: BaseContainer(
        child: Material(
          color: background,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              onPressed(slot);
            },
            child: Container(
              height: 44,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: border,
              ),
              child: Center(
                  child: Text(
                label,
                style: labelStyle,
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeFormField extends FormField<DateTime> {
  final List<DateTime> slots;
  final ValueChanged<DateTime> onChanged;

  DateTimeFormField({
    this.onChanged,
    @required this.slots,
    DateTime initialValue,
    FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime> validator,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (state) => Column(
            children: [
              DateTimePicker(
                slots: slots,
                onChanged: (value) {
                  state.didChange(value);
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
              ),
            ],
          ),
        );
}
