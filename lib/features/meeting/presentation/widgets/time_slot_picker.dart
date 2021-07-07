import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../ui/base/base_error_text/base_error_text.dart';
import '../../domain/entity/time_slot_entity.dart';

typedef TimeSlotTappedCallback = void Function(TimeSlot slot);
typedef TimeSelectedChangeCallback = void Function(List<TimeSlot> slots);

class TimeSlotPicker extends StatefulWidget {
  final List<TimeSlot> value;
  final Map<String, List<TimeSlot>> slots;
  final TimeSlotTappedCallback onSlotTap;

  const TimeSlotPicker({
    Key key,
    this.value = const [],
    @required this.slots,
    @required this.onSlotTap,
  }) : super(key: key);

  @override
  _TimeSlotPickerState createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  int _activePage;
  PageController _pageController;
  List<_TimeSlotItem> _dateSlots;

  @override
  void initState() {
    _activePage = 0;
    _pageController = PageController(initialPage: _activePage);
    _dateSlots = _parseDateTimeSlots(widget.slots);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<_TimeSlotItem> _parseDateTimeSlots(Map<String, List<TimeSlot>> slots) {
    return slots.entries
        .map(
          (slot) => _TimeSlotItem(
            date: slot.key,
            timeSlots: slot.value,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildHeaderTabs(context),
          ),
          const SizedBox(height: AppInsets.xxl),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _activePage = value;
                });
              },
              children: _buildPages(context, _dateSlots),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPages(BuildContext context, List<_TimeSlotItem> slots) {
    return slots.map(
      (slot) {
        final List<List<TimeSlot>> rows = slot.timeSlots.fold(
          [[]],
          (list, timeSlot) => list.last.length == 2
              ? (list..add([timeSlot]))
              : (list..last.add(timeSlot)),
        );

        rows.map((row) {
          if (row.length < 2) {
            final filler = List(2 - row.length);
            row.addAll(filler.map((e) => null));
          }
        }).toList();

        return Table(
          children: rows
              .map(
                (row) => TableRow(
                  children: row
                      .map(
                        (col) => col != null
                            ? _TimeSlot(
                                slot: col,
                                selected: widget.value.contains(col),
                                onTap: () {
                                  widget.onSlotTap(col);
                                },
                              )
                            : Container(),
                      )
                      .toList(),
                ),
              )
              .toList(),
        );
      },
    ).toList();
  }

  List<Widget> _buildHeaderTabs(BuildContext context) {
    return _dateSlots.map(
      (slot) {
        final index = _dateSlots.indexOf(slot);
        return _TimeSlotTab(
          selected: _activePage == index,
          date: slot.date,
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
        );
      },
    ).toList();
  }
}

class TimeSlotFormField extends FormField<List<TimeSlot>> {
  final Map<String, List<TimeSlot>> slots;
  final TimeSelectedChangeCallback onChange;

  TimeSlotFormField({
    List<TimeSlot> initialValue,
    FormFieldSetter<List<TimeSlot>> onSaved,
    FormFieldValidator<List<TimeSlot>> validator,
    bool autovalidate = false,
    @required this.slots,
    @required this.onChange,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<TimeSlot>> state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeSlotPicker(
                  value: state.value,
                  slots: slots,
                  onSlotTap: (slot) {
                    final selected = state.value.contains(slot);
                    final updated = [...state.value];
                    if (selected) {
                      updated.remove(slot);
                    } else {
                      updated.add(slot);
                    }
                    state.didChange(updated);
                    onChange(updated);
                  },
                ),
                if (state.hasError)
                  BaseErrorText(
                    text: state.errorText,
                  )
              ],
            );
          },
        );
}

class _TimeSlotTab extends StatelessWidget {
  final String date;
  final VoidCallback onTap;
  final bool selected;

  const _TimeSlotTab({
    Key key,
    @required this.date,
    @required this.onTap,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd");
    final weekFormatter = DateFormat("E");
    final dateParsed = DateTime.parse(date);
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          color: selected ? Theme.of(context).primaryColor : Colors.white,
        );
    final border =
        selected ? Border.all(color: Theme.of(context).primaryColor) : null;
    final color = Theme.of(context).canvasColor;
    return Container(
      margin: const EdgeInsets.only(right: AppInsets.xl),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.l,
              vertical: AppInsets.med,
            ),
            child: Column(
              children: [
                Text(
                  weekFormatter.format(dateParsed),
                  style: labelStyle,
                ),
                const SizedBox(height: 12),
                BaseContainer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: border,
                    ),
                    width: 44,
                    height: 44,
                    child: Center(
                      child: Text(
                        formatter.format(dateParsed),
                        style: labelStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  final TimeSlot slot;
  final bool selected;
  final VoidCallback onTap;

  const _TimeSlot({
    Key key,
    @required this.slot,
    @required this.selected,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final timeFormatter = DateFormat("hh:mm a");
    final startTime = slot.start;
    final label = timeFormatter.format(startTime.toLocal());
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          color: selected ? Theme.of(context).primaryColor : Colors.white,
        );
    final border =
        selected ? Border.all(color: Theme.of(context).primaryColor) : null;
    return Container(
      padding: const EdgeInsets.all(AppInsets.xxl),
      child: BaseContainer(
        radius: 12,
        child: Material(
          color: Theme.of(context).canvasColor,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: AppInsets.xl,
                vertical: AppInsets.xl,
              ),
              decoration: BoxDecoration(
                border: border,
                borderRadius: borderRadius,
              ),
              child: Text(
                label,
                style: labelStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeSlotItem extends Equatable {
  final String date;
  final List<TimeSlot> timeSlots;

  const _TimeSlotItem({
    @required this.date,
    @required this.timeSlots,
  });

  @override
  List<Object> get props => [date, timeSlots];
}
