import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:worknetwork/features/conversations/domain/entity/optin_entity/optin_entity.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/layouts/calendar_card_layout/calendar_card_layout.dart';
import 'package:worknetwork/utils/app_localizations.dart';

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
      subHeading: Text(dateFormat.format(optin.timeSlotList.first.start)),
      border: Border.all(
        color: Color(0xFFFFCB77),
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
