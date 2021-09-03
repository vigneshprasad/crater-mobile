import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../routes.gr.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../conversations/presentation/widgets/layouts/calendar_card_layout/calendar_card_layout.dart';
import '../../domain/entity/meeting_participant_entity.dart';
import '../../domain/entity/meeting_request_entity.dart';

class MeetingRequestCard extends StatelessWidget {
  final MeetingRequest meeting;
  final VoidCallback? onCardPressed;

  const MeetingRequestCard({
    Key? key,
    required this.meeting,
    this.onCardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final isRequester = meeting.requestedBy == user!.pk;

    final dateFormat = DateFormat.jm();

    BoxBorder _border;
    final background = Theme.of(context).backgroundColor;
    _border = Border.all(
      color: isRequester ? Colors.orange : Theme.of(context).primaryColor,
      width: 2.00,
    );

    String heading =
        "Meeting requested to - ${meeting.participantDetail!.name}";
    if (!isRequester) {
      heading = "Meeting request from - ${meeting.participantDetail!.name}";
    }
    return CalendarCardLayout(
      onPressed: onCardPressed,
      background: background,
      heading: Text(heading),
      subHeading: Row(
        children: [
          Text(dateFormat.format(meeting.timeSlots![0].toLocal())),
          const Spacer(),
        ],
      ),
      border: _border,
      child: Row(
        children: [
          Expanded(
              child: _SpeakersAvatarList(
            speakers: [meeting.participantDetail!],
          ))
        ],
      ),
    );
  }
}

class _SpeakersAvatarList extends StatelessWidget {
  final List<MeetingParticipant>? speakers;

  const _SpeakersAvatarList({
    Key? key,
    this.speakers,
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

    for (int index = 0; index < (speakers?.length ?? 0); index++) {
      final speaker = speakers![index];
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
