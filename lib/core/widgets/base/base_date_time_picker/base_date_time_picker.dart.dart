import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';

typedef GetDateTimeCallback<T> = DateTime Function(T obj);

class BaseDateTimePicker<T> extends StatefulWidget {
  final List<T> initialValue;
  final List<List<T>> timeSlots;
  final GetDateTimeCallback<T> getDateTime;
  final int maxLength;
  final double height;
  final ValueChanged<List<T>> onValueChanged;

  const BaseDateTimePicker({
    Key key,
    this.initialValue,
    @required this.timeSlots,
    this.getDateTime,
    this.maxLength = 1,
    this.height = 236,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _BaseDateTimePickerState createState() => _BaseDateTimePickerState<T>();
}

class _BaseDateTimePickerState<T> extends State<BaseDateTimePicker<T>>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<DateTime> _displayDays;
  List<T> _value;
  int _activeTab;

  @override
  void initState() {
    _value = widget.initialValue ?? [];
    _displayDays = _intializeDateList();
    _controller = TabController(vsync: this, length: _displayDays.length);
    _controller.addListener(_onChangeTab);
    _activeTab = _controller.index;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<DateTime> _intializeDateList() {
    final List<DateTime> _list = [];
    for (final slots in widget.timeSlots) {
      _list.add(widget.getDateTime(slots[0]));
    }
    return _list;
  }

  void _onChangeTab() {
    setState(() {
      _activeTab = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedLength = _value.length;
    return Container(
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppInsets.xl),
          _DatesTabBar(
            dates: _displayDays,
            selected: _activeTab,
            onTabPressed: (date) {
              final index = _displayDays.indexOf(date);
              _controller.animateTo(index);
            },
          ),
          const SizedBox(height: AppInsets.xl),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                ..._displayDays.map(
                  (date) {
                    return _DateSlotPickerBody<T>(
                      getDateTime: widget.getDateTime,
                      timeslots: widget.timeSlots[_activeTab],
                      selected: _value,
                      onSlotPressed: (value) {
                        final updated = _value;
                        if (updated.contains(value)) {
                          updated.remove(value);
                        } else {
                          if (_value.length < widget.maxLength) {
                            updated.add(value);
                          }
                        }
                        setState(() {
                          _value = updated;
                          if (widget.onValueChanged != null) {
                            widget.onValueChanged(_value);
                          }
                        });
                      },
                    );
                  },
                ).toList(),
              ],
            ),
          ),
          if (widget.maxLength > 1)
            Text("$selectedLength/${widget.maxLength} Selected"),
        ],
      ),
    );
  }
}

class _DateSlotPickerBody<T> extends StatelessWidget {
  final List<T> timeslots;
  final List<T> selected;
  final ValueChanged<T> onSlotPressed;
  final GetDateTimeCallback<T> getDateTime;

  const _DateSlotPickerBody({
    Key key,
    @required this.timeslots,
    @required this.selected,
    @required this.onSlotPressed,
    @required this.getDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: timeslots.length,
      padding: const EdgeInsets.all(AppInsets.med),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 3.8,
      ),
      itemBuilder: (context, index) => _TimeSlot<T>(
        value: timeslots[index],
        active: selected.contains(timeslots[index]),
        time: getDateTime(timeslots[index]),
        onPressed: (value) {
          onSlotPressed(value);
        },
      ),
    );
  }
}

class _TimeSlot<T> extends StatelessWidget {
  final bool active;
  final DateTime time;
  final ValueChanged<T> onPressed;
  final T value;

  const _TimeSlot({
    Key key,
    @required this.active,
    @required this.time,
    @required this.onPressed,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeformat = DateFormat('hh:mm a');
    final primaryColor = Theme.of(context).primaryColor;
    final textStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          color: active ? primaryColor : Colors.white,
        );
    final borderRadius = BorderRadius.circular(6.0);
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          onPressed(value);
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            border: active
                ? Border.all(
                    color: primaryColor,
                    width: 2,
                  )
                : Border.all(
                    color: Colors.grey[300],
                    width: 2,
                  ),
            borderRadius: borderRadius,
          ),
          child: Row(
            children: [
              Checkbox(
                value: active,
                checkColor: Theme.of(context).backgroundColor,
                onChanged: (_) {
                  onPressed(value);
                },
              ),
              const SizedBox(width: AppInsets.l),
              Text(
                timeformat.format(time),
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DatesTabBar extends StatelessWidget {
  final double height;
  final List<DateTime> dates;
  final int selected;
  final ValueChanged<DateTime> onTabPressed;

  const _DatesTabBar({
    Key key,
    @required this.dates,
    @required this.selected,
    this.height = 48,
    this.onTabPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) => _DateTab(
          active: index == selected,
          date: dates[index],
          onPressed: onTabPressed,
        ),
      ),
    );
  }
}

class _DateTab extends StatelessWidget {
  final bool active;
  final DateTime date;
  final ValueChanged<DateTime> onPressed;

  const _DateTab({
    Key key,
    @required this.date,
    @required this.active,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borerRadius = BorderRadius.circular(8);
    final dayFormat = DateFormat('E');
    final dateFormat = DateFormat('dd');
    final BoxDecoration decoration = BoxDecoration(
      borderRadius: borerRadius,
    );
    final textStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          // color: active ? Colors.white : Colors.grey[500],
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.sm),
      child:Container(
        decoration: BoxDecoration(
        // color:  Theme.of(context).dialogBackgroundColor,
        borderRadius: borerRadius,
        border: active ? Border.all(color: Theme.of(context).buttonColor): null,
        ),
        child: InkWell(
          onTap: () {
            onPressed(date);
          },
          splashColor: Theme.of(context).primaryColorLight,
          borderRadius: borerRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
            decoration: decoration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayFormat.format(date),
                  style: textStyle,
                ),
                Text(
                  dateFormat.format(date),
                  style: textStyle.copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
