import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import 'discount_slider_indicator.dart';

class DiscountSlider extends StatefulWidget {
  final int maxUserPoints;
  final double maxDiscount;
  final double maxPoints;
  final double value;
  final ValueChanged<double> onChanged;

  const DiscountSlider({
    Key key,
    @required this.maxUserPoints,
    @required this.maxPoints,
    @required this.maxDiscount,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _DiscountSliderState createState() => _DiscountSliderState();
}

class _DiscountSliderState extends State<DiscountSlider> {
  double _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: Colors.grey[400],
        );
    final currency = NumberFormat.currency(
      decimalDigits: 0,
      locale: 'en-in',
      symbol: '',
    );
    final minVal = currency.format(0);
    final maxVal = currency.format(widget.maxDiscount);
    return SizedBox(
      height: 172,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSlider(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
            child: Row(
              children: [
                Text(
                  minVal,
                  style: labelStyle,
                ),
                const Spacer(),
                Text(
                  maxVal,
                  style: labelStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    final max = widget.maxPoints.toInt();
    return SliderTheme(
      data: Theme.of(context).sliderTheme.copyWith(
            thumbShape: DiscountSliderIndicator(
              thumbHeight: 48.0,
              thumbRadius: 8.0,
              min: 0,
              max: max,
            ),
            showValueIndicator: ShowValueIndicator.never,
            trackHeight: 2.0,
            activeTrackColor: Colors.grey[900],
            inactiveTrackColor: Colors.grey[200],
          ),
      child: Slider(
        label: '${_value.toInt()}',
        max: widget.maxPoints,
        value: _value,
        divisions: widget.maxPoints.toInt(),
        onChanged: (value) {
          setState(() {
            if (value < widget.maxUserPoints) {
              _value = value;
            } else {
              _value = widget.maxUserPoints.toDouble();
            }
            widget.onChanged(_value);
          });
        },
      ),
    );
  }
}
