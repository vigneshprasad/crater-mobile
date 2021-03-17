import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_model.dart';

import '../../../../meeting/domain/entity/meeting_entity.dart';
import '../roundtable_card_layout/roundtable_card_layout.dart';

const kAvatarSize = 48.00;
const kBottomPadding = 40.00;

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final ValueChanged<Meeting> onPressed;

  const MeetingCard({
    Key key,
    @required this.meeting,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final dateTextStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          color: Colors.grey,
        );
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 20,
        );
    final categoryStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
        );
    final dateStyle = categoryStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
    );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );

    final dateFormat = DateFormat("EEE, dd MMM");
    return RoundTableCardLayout(
      onPressed: onPressed != null
          ? () {
              onPressed(meeting);
            }
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateFormat.format(meeting.start),
            style: dateTextStyle,
          ),
          if (meeting.participantDetail != null)
            Text(
              "Meeting with ${meeting.participantDetail.name}",
              style: headingStyle,
            ),
          const SizedBox(height: AppInsets.med),
          Text(
            "${timeFormat.format(meeting.start)} - ${timeFormat.format(meeting.end)}",
            style: dateStyle,
          ),
          // if (meeting.participantDetail != null)
          //   Text(
          //     meeting.participantDetail.introduction,
          //     maxLines: 4,
          //     overflow: TextOverflow.ellipsis,
          //     style: descriptionStyle,
          //   ),
          const SizedBox(height: AppInsets.l),
          _MeetingStatusLabel(status: meeting.status),
          const Spacer(),
          if (meeting.participantDetail != null)
            BaseNetworkImage(
              imageUrl: meeting.participantDetail.photo,
              imagebuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
              ),
              defaultImage: AppImageAssets.defaultAvatar,
            ),
        ],
      ),
    );
  }
}

class _MeetingStatusLabel extends StatelessWidget {
  final MeetingStatus status;

  const _MeetingStatusLabel({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        color:
            status != MeetingStatus.pending ? Colors.white : Colors.grey[700]);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.l),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: const BorderRadius.all(Radius.circular(6.00)),
      ),
      child: Text(
        _getTextContent(),
        style: style,
      ),
    );
  }

  String _getTextContent() {
    switch (status) {
      case MeetingStatus.confirmed:
        return 'Meeting Confirmed';
      case MeetingStatus.cancelled:
        return 'Meeting Cancelled';
      case MeetingStatus.pending:
        return 'RSVP Pending';
      case MeetingStatus.rescheduled:
        return 'Reschedule Requested';
      default:
        return "";
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case MeetingStatus.confirmed:
        return Colors.green;
      case MeetingStatus.cancelled:
        return Colors.red;
      case MeetingStatus.pending:
        return Colors.yellow[600];
      case MeetingStatus.rescheduled:
        return Colors.orange;
      default:
        return Colors.orange;
    }
  }

  Widget _buildCardStatus(BuildContext context) {
    String text;
    TextStyle style = Theme.of(context).textTheme.bodyText1;
    switch (status) {
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
        text = 'Reschedule Requested';
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
