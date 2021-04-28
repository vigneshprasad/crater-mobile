import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/layouts/calendar_card_layout/calendar_card_layout.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_participant_entity.dart';
import '../../../../routes.gr.dart';
import '../../domain/entity/meeting_entity.dart';

class OneOnOneCard extends StatelessWidget {
  final Meeting meeting;
  final ValueChanged<Meeting> onCardPressed;

  const OneOnOneCard({
    Key key,
    @required this.meeting,
    this.onCardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 13.00,
        );
    final now = DateTime.now();
    final difference = meeting.start.toLocal().difference(now).inMinutes;

    final isSoon = difference > 0 && difference <= 30;
    final startTime = difference <= 30 ? "In $difference minutes" : "";
    final dateFormat = DateFormat.jm();

    BoxBorder _border;
    Color background;

    if (meeting.isPast) {
      _border = Border.all(
        color: Colors.grey[200],
        width: 2.00,
      );
      background = Colors.grey[100];
    } else {
      _border = Border.all(
        color: AppTheme.blueAccentDark,
        width: 2.00,
      );

      if (isSoon) {
        background = AppTheme.blueAccent;
      }
    }

    return CalendarCardLayout(
      onPressed: () {
        ExtendedNavigator.of(context).push(Routes.meetingDetailScreen,
            arguments: MeetingDetailScreenArguments(meetingId: meeting.pk));
      },
      background: background,
      heading: Text('Meeting with ${meeting.participantDetail.name}'),
      subHeading: Row(
        children: [
          Text(dateFormat.format(meeting.start.toLocal())),
          const Spacer(),
          if (isSoon) Text(startTime, style: subheadStyle),
        ],
      ),
      border: _border,
      child: Row(
        children: [
          // Text("Relevancy: 70%", style: subheadStyle),
          Expanded(
            child: _SpeakersAvatarList(speakers: meeting.participants),
          ),
        ],
      ),
    );
  }
}

class _SpeakersAvatarList extends StatelessWidget {
  final List<MeetingParticipant> speakers;

  const _SpeakersAvatarList({
    Key key,
    @required this.speakers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.00,
      child: Stack(
        fit: StackFit.expand,
        children: _buildItemList(context),
      ),
    );
  }

  List<Widget> _buildItemList(BuildContext context) {
    final List<Widget> children = [];
    const background = Color(0xFFCDDAFD);

    for (int index = 0; index < speakers.length; index++) {
      final speaker = speakers[index];
      children.add(
        Positioned(
          right: 20.00 * index,
          child: BaseNetworkImage(
            defaultImage: AppImageAssets.defaultAvatar,
            imageUrl: speaker.photo,
            imagebuilder: (context, imageProvider) => Container(
              width: 32.00,
              height: 32.00,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                shape: BoxShape.circle,
                border: Border.all(color: background, width: 2.00),
              ),
            ),
          ),
        ),
      );
    }

    return children;
  }
}
