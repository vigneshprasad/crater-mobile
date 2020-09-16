import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/meeting/domain/entity/time_slot_entity.dart';

typedef TimeSlotSelectedCallback = void Function(List<TimeSlot> slots);

class TimeSlotPicker extends StatefulWidget {
  final Map<String, List<TimeSlot>> slots;
  final TimeSlotSelectedCallback onChange;

  const TimeSlotPicker({
    Key key,
    @required this.slots,
    @required this.onChange,
  }) : super(key: key);

  @override
  _TimeSlotPickerState createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  int _activePage;
  PageController _pageController;
  List<_TimeSlotItem> _dateSlots;
  List<TimeSlot> _selectedSlots;

  @override
  void initState() {
    _activePage = 0;
    _pageController = PageController(initialPage: _activePage);
    _dateSlots = _parseDateTimeSlots(widget.slots);
    _selectedSlots = [];
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
    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          children: [
            Row(
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
        ));
  }

  List<Widget> _buildPages(BuildContext context, List<_TimeSlotItem> slots) {
    return slots
        .map(
          (slot) => Wrap(
            children: slot.timeSlots
                .map(
                  (timeSlot) => _TimeSlot(
                    slot: timeSlot,
                    selected: _selectedSlots.contains(timeSlot),
                    onTap: () {
                      if (_selectedSlots.contains(timeSlot)) {
                        setState(() {
                          _selectedSlots = (_selectedSlots..remove(timeSlot));
                        });
                      } else {
                        setState(() {
                          _selectedSlots = (_selectedSlots..add(timeSlot));
                        });
                      }
                      if (widget.onChange != null) {
                        widget.onChange(_selectedSlots);
                      }
                    },
                  ),
                )
                .toList(),
          ),
        )
        .toList();
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
    final formatter = DateFormat("E, dd MMM");
    final dateParsed = DateTime.parse(date);
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          color: selected ? Theme.of(context).primaryColor : Colors.grey[400],
        );
    final border = selected
        ? Border(
            bottom: BorderSide(width: 2, color: Theme.of(context).primaryColor),
          )
        : null;
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
            decoration: BoxDecoration(
              border: border,
            ),
            child: Text(
              formatter.format(dateParsed),
              style: labelStyle,
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
    const placeholderDate = "2020-01-01";
    final timeFormatter = DateFormat("hh:mm a");
    final startTime = DateTime.parse("$placeholderDate ${slot.start}");
    final endTime = DateTime.parse("$placeholderDate ${slot.end}");
    final label =
        "${timeFormatter.format(startTime)} to ${timeFormatter.format(endTime)}";
    final labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          color: selected ? Colors.white : Colors.grey[700],
        );
    return Container(
      margin: const EdgeInsets.only(right: AppInsets.med, bottom: AppInsets.xl),
      child: Material(
        color: selected ? Theme.of(context).primaryColor : Colors.grey[200],
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.xl,
              vertical: AppInsets.l,
            ),
            child: Text(
              label,
              style: labelStyle,
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
