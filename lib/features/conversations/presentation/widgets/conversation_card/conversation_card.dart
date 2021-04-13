import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/layouts/calendar_card_layout/calendar_card_layout.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  final ValueChanged<Conversation> onCardPressed;

  const ConversationCard({
    Key key,
    @required this.conversation,
    this.onCardPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subheadStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 13.00,
        );
    final dateFormat = DateFormat.jm();
    return CalendarCardLayout(
      heading: conversation.topicDetail.name,
      subHeading: dateFormat.format(conversation.start),
      child: Row(
        children: [
          Text("Relevancy: 80%", style: subheadStyle),
          Expanded(
            child:
                _SpeakersAvatarList(speakers: conversation.speakersDetailList),
          ),
        ],
      ),
    );
  }
}

class _SpeakersAvatarList extends StatelessWidget {
  final List<ConversationUser> speakers;

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
    List<Widget> children = [];
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
