import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';

class MeetingDateLabel extends StatelessWidget {
  final DateTime date;

  const MeetingDateLabel({
    Key key,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('EEEE, d MMM');
    final dateStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
        );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.l,
        horizontal: AppInsets.xxl,
      ),
      child: Text(
        dateFormat.format(date),
        style: dateStyle,
      ),
    );
  }
}
