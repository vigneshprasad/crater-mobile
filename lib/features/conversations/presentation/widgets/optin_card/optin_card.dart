import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:worknetwork/features/conversations/domain/entity/optin_entity/optin_entity.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/layouts/calendar_card_layout/calendar_card_layout.dart';

class OptinCard extends StatelessWidget {
  final Optin optin;

  const OptinCard({
    Key key,
    @required this.optin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.jm();
    return CalendarCardLayout(
      heading: optin.topicDetail.name,
      subHeading: dateFormat.format(optin.timeSlotList.first.start),
      child: Row(
        children: [Text("Settng things up...")],
      ),
    );
  }
}
