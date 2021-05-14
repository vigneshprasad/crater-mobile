import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/custom_tabs/custom_tabs.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import '../../../../../routes.gr.dart';
import '../../../../article/domain/entity/article_entity/article_entity.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';

class ArticleTopicCard extends StatelessWidget {
  final Topic topic;

  const ArticleTopicCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canvas = Theme.of(context).canvasColor;
    const borderRadius = BorderRadius.all(Radius.circular(8.00));
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 16.00,
          fontWeight: FontWeight.w500,
        );
    final border = Border.all(
      // width: 1.00,
      color: Colors.grey[200],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.xxl),
      child: BaseContainer(
        radius: 8,
        child: Material(
          // color: canvas,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              ExtendedNavigator.of(context)
                  .push(Routes.createConversationScreen,
                      arguments: CreateConversationScreenArguments(
                          topic: topic, type: ConversationType.instant))
                  .then(
                (value) {
                  if (value is Conversation) {
                    HomeTabControllerProvider.of(context)
                        .controller
                        .animateTo(1);
                    ExtendedNavigator.of(context)
                        .push(Routes.conversationScreen(id: value.id));
                  }
                },
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (topic.articleDetail.description.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppInsets.xl,
                          vertical: AppInsets.xl,
                        ),
                        child: Text(topic.articleDetail.description,
                            style: headingStyle),
                      )
                    : const SizedBox(height: AppInsets.xxl),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppInsets.xxl),
                  child: _ArticleContent(article: topic.articleDetail),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppInsets.xl),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: BaseContainer(
                      radius: 30,
                      child: RaisedButton(
                        // elevation: 0,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Start a conversation",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                  fontSize: 14.00,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  final Article article;

  const _ArticleContent({
    Key key,
    @required this.article,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final backgroundColor = HexColor.fromHex('#DDE9FD');
    final headingStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15.00,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).canvasColor,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Theme.of(context).canvasColor,
        );
    return BaseContainer(
      radius: 10,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppInsets.l,
            right: AppInsets.l,
            left: AppInsets.xl,
            bottom: AppInsets.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BaseNetworkImage(
                    imageUrl: article.articleSourceDetail.image,
                    defaultImage: AppImageAssets.articleDefault,
                    imagebuilder: (context, imageProvider) => CircleAvatar(
                      radius: 14.00,
                      backgroundImage: imageProvider,
                    ),
                  ),
                  const SizedBox(width: AppInsets.l),
                  Text(article.articleSourceDetail.name, style: headingStyle),
                  const Spacer(),
                  IconButton(
                    splashRadius: 22.00,
                    icon: Icon(
                      Icons.launch,
                      size: 20.00,
                      color: Colors.grey[800].withOpacity(0.3),
                    ),
                    onPressed: () {
                      KiwiContainer()
                          .resolve<CustomTabs>()
                          .openLink(article.websiteUrl);
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppInsets.sm),
              Text(
                article.title,
                style: descriptionStyle,
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
