import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';

class RescheduleSlotPicker extends StatefulWidget {
  final List<DateTime> timeSlots;
  final ValueChanged<DateTime> onValueChanged;
  final bool disabled;

  const RescheduleSlotPicker({
    Key key,
    @required this.timeSlots,
    @required this.onValueChanged,
    this.disabled = false,
  }) : super(key: key);

  @override
  _RescheduleSlotPickerState createState() => _RescheduleSlotPickerState();
}

class _RescheduleSlotPickerState extends State<RescheduleSlotPicker> {
  DateTime _value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.timeSlots
          .map((slot) => _TimeSlots(
                slot: slot,
                selected: _value == slot,
                onPressed: (value) {
                  if (!widget.disabled) {
                    setState(() {
                      _value = value;
                      widget.onValueChanged(_value);
                    });
                  }
                },
              ))
          .toList(),
    );
  }
}

class _TimeSlots extends StatelessWidget {
  final DateTime slot;
  final bool selected;
  final ValueChanged<DateTime> onPressed;

  const _TimeSlots({
    Key key,
    @required this.slot,
    @required this.selected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final dateFormat = DateFormat('EEE, dd MMM - hh:mm a');
    final borderRadius = BorderRadius.circular(8.0);
    final textStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 15,
          color: selected ? Colors.white : Colors.grey[600],
        );
    return Padding(
      padding: const EdgeInsets.only(bottom: AppInsets.xl),
      child: Material(
        color: selected ? primaryColor : Colors.grey[100],
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            onPressed(slot);
          },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(
                vertical: AppInsets.l, horizontal: AppInsets.xl),
            duration: const Duration(milliseconds: 400),
            child: Center(
              child: Text(
                dateFormat.format(slot),
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
