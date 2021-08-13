import 'package:flutter/material.dart';

class QuantityPicker extends StatefulWidget {
  final int? value;
  final ValueChanged<int>? onChange;

  const QuantityPicker({
    Key? key,
    this.value,
    this.onChange,
  }) : super(key: key);

  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  late int _value;

  @override
  void initState() {
    _value = widget.value ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 22;
    const double iconSplashRadius = 20;
    final labelStyle = Theme.of(context).textTheme.subtitle2?.copyWith(
          fontSize: 16,
        );
    return Row(
      children: [
        IconButton(
          color: Colors.grey[900],
          disabledColor: Colors.grey[200],
          iconSize: iconSize,
          splashRadius: iconSplashRadius,
          icon: const Icon(Icons.remove_circle),
          onPressed: _value > 1 ? decreseValue : null,
        ),
        Text(
          _value.toString(),
          style: labelStyle,
        ),
        IconButton(
          color: Colors.grey[900],
          disabledColor: Colors.grey[200],
          iconSize: iconSize,
          splashRadius: iconSplashRadius,
          icon: const Icon(Icons.add_circle),
          onPressed: _increaseValue,
        ),
      ],
    );
  }

  void _increaseValue() {
    setState(() {
      _value = _value + 1;
      if (widget.onChange != null) {
        widget.onChange!(_value);
      }
    });
  }

  void decreseValue() {
    setState(() {
      _value = _value - 1;
      if (widget.onChange != null) {
        widget.onChange!(_value);
      }
    });
  }
}
