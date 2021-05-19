import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../article/domain/entity/article_entity/article_entity.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../layouts/calendar_card_layout/calendar_card_layout.dart';

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
          color: Colors.white70,
        );
    final isFull = conversation.speakers.length >= conversation.maxSpeakers;
    final now = DateTime.now();
    final difference = conversation.start.toLocal().difference(now).inMinutes;

    final isSoon = difference > 0 && difference <= 30;
    final startTime = difference <= 30 ? "In $difference minutes" : "";
    final dateFormat = DateFormat.jm();

    BoxBorder _border;
    Color background;

    if (conversation.isPast) {
      // _border = Border.all(
      //   color: Colors.grey[200],
      //   width: 2.00,
      // );
      background = Colors.grey[100];
    } else {
      if (conversation.isSpeaker) {
        _border = Border.all(
          color: AppTheme.blueAccentDark,
          width: 2.00,
        );
      } else {
        if (isFull) {
          _border = Border.all(
            color: Theme.of(context).errorColor,
            width: 2.00,
          );
        }
      }

      if (isSoon) {
        background = AppTheme.blueAccent;
      }
    }

    final article = conversation.topicDetail.articleDetail;

    final heading =
        article != null ? article.description : conversation.topicDetail.name;
    final padding = article != null && article.description.isEmpty
        ? const EdgeInsets.symmetric(
            horizontal: AppInsets.xl,
          )
        : const EdgeInsets.symmetric(
            vertical: AppInsets.xl,
            horizontal: AppInsets.xl,
          );

    return CalendarCardLayout(
      onPressed: () {
        ExtendedNavigator.of(context)
            .push(Routes.conversationScreen(id: conversation.id));
      },
      padding: padding,
      background: Theme.of(context).canvasColor,
      heading: Text(heading),
      subHeading: Row(
        children: [
          const Spacer(),
          if (isSoon) Text(startTime, style: subheadStyle),
        ],
      ),
      border: _border,
      child: Column(
        children: [
          if (conversation.topicDetail.articleDetail != null)
            _ArticleDetailCard(article: conversation.topicDetail.articleDetail),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateFormat.format(conversation.start.toLocal())),
                  Text("Relevancy: ${conversation.relevancy}%",
                      style: subheadStyle),
                ],
              ),
              Expanded(
                child: _SpeakersAvatarList(
                    speakers: conversation.speakersDetailList),
              ),
              SizedBox(width: 20),
              BaseContainer(
                  radius: 30,
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      // color: Theme.of(context).wh,

                      onPressed: () => ExtendedNavigator.of(context)
                          .push(Routes.conversationScreen(id: conversation.id)),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArticleDetailCard extends StatelessWidget {
  final Article article;

  const _ArticleDetailCard({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sourceLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.xl),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8.00)),
        color: HexColor.fromHex('#DDE9FD'),
        type: MaterialType.card,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppInsets.l,
            horizontal: AppInsets.l,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BaseNetworkImage(
                    imageUrl: article.articleSourceDetail.image,
                    defaultImage: AppImageAssets.videoPlaceholder,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 12.00,
                    ),
                  ),
                  const SizedBox(width: AppInsets.l),
                  Text(article.articleSourceDetail.name,
                      style: sourceLabelStyle),
                ],
              ),
              const SizedBox(height: AppInsets.l),
              Text(
                article.title,
                style: TextStyle(color: Colors.black),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
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
