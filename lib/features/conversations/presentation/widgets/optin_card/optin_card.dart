import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_localizations.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../layouts/calendar_card_layout/calendar_card_layout.dart';

class OptinCard extends StatelessWidget {
  final Optin optin;

  const OptinCard({
    Key key,
    @required this.optin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label =
        AppLocalizations.of(context).translate("conversations:scheduling");
    final dateFormat = DateFormat.jm();
    return CalendarCardLayout(
      heading: Text(optin.topicDetail.name),
      subHeading:
          Text(dateFormat.format(optin.timeSlotList.first.start.toLocal())),
      border: Border.all(
        color: const Color(0xFFFFCB77),
        width: 2.00,
      ),
      child: Row(
        children: [
          Text(label),
        ],
      ),
    );
  }
}
