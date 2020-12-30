import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_card_button/base_card_button.dart';
import '../../../../routes.gr.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../data/models/meeting_model.dart';
import '../../domain/entity/meeting_entity.dart';
import 'rsvp_indicator.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final User user;
  final Function onRefresh;

  const MeetingCard({
    Key key,
    @required this.user,
    @required this.meeting,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
      child: Material(
        elevation: 1,
        color: Colors.white,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppInsets.xl,
            vertical: AppInsets.xxl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 42),
              const Divider(),
              const SizedBox(height: AppInsets.l),
              _buildActionsRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final meetingParticipant =
        meeting.participants.firstWhere((element) => element.pk != user.pk);
    final timeFormat = DateFormat.jm();
    final startTime = timeFormat.format(meeting.start);
    final endTime = timeFormat.format(meeting.end);
    final nameStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 18,
        );

    final timeStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          height: 1.6,
        );
    final name = "${meetingParticipant.name}\n";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: name,
                style: nameStyle,
              ),
              TextSpan(
                text: 'at ',
                style: timeStyle,
              ),
              TextSpan(
                text: '$startTime - $endTime',
                style: timeStyle.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        if (!meeting.isPast) _buildCardStatus(context),
      ],
    );
  }

  Widget _buildActionsRow(BuildContext context) {
    return Row(
      children: [
        if (meeting.participants.isNotEmpty)
          ...meeting.participants
              .map((participant) => participant.rsvp != null
                  ? RsvpIndicator(
                      participant: participant,
                      showIndicator: !meeting.isPast,
                    )
                  : Container())
              .toList(),
        const Spacer(),
        BaseCardButton(
          onPressed: () {
            ExtendedNavigator.of(context)
                .push(Routes.meetingDetailScreen,
                    arguments:
                        MeetingDetailScreenArguments(meetingId: meeting.pk))
                .then((value) => onRefresh());
          },
          child: Text('Details'),
        )
      ],
    );
  }

  Widget _buildCardStatus(BuildContext context) {
    String text;
    TextStyle style = Theme.of(context).textTheme.bodyText1;
    switch (meeting.status) {
      case MeetingStatus.confirmed:
        text = 'Meeting Confirmed';
        style = style.copyWith(
          color: Colors.green,
        );
        break;
      case MeetingStatus.cancelled:
        text = 'Meeting Cancelled';
        style = style.copyWith(
          color: Colors.red,
        );
        break;
      case MeetingStatus.pending:
        text = 'RSVP Pending';
        style = style.copyWith(
          color: Colors.yellow[600],
        );
        break;
      case MeetingStatus.rescheduled:
        text = 'Meeting rescheduled';
        style = style.copyWith(
          color: Colors.orange,
        );
        break;
    }
    return Text(
      text,
      style: style,
    );
  }
}
