import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/create_conversation_screen/create_conversation_state.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/topics_tab/topics_tab_state.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

class TopicsList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final topicsState = useProvider(topicsStateProvider.state);
    return RefreshIndicator(
        onRefresh: () {
          final futures = [
            context.read(topicsStateProvider).getTopicsList(),
          ];

          return Future.wait(futures);
        },
        child: topicsState.when(
          loading: () => Container(),
          error: (err, st) => Container(),
          data: (topics) => ListView.builder(
            itemBuilder: (context, index) => _TopicCard(topic: topics[index]),
            itemCount: topics.length,
          ),
        ));
  }
}

class _TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback onTap;

  const _TopicCard({
    Key key,
    @required this.topic,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.00));
    final backgroundColor = HexColor.fromHex('#DDE9FD');
    final headingStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15.00,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).canvasColor,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Theme.of(context).canvasColor,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.xxl, horizontal: AppInsets.xl),
      child: GestureDetector(
        onTap: () => onTapCard(context),
        child: BaseContainer(
          radius: 8,
          child: Material(
            borderRadius: borderRadius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BaseContainer(
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
                                  imageUrl: topic.image,
                                  defaultImage: AppImageAssets.articleDefault,
                                  imagebuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 14.00,
                                    backgroundImage: imageProvider,
                                  ),
                                ),
                                const SizedBox(width: AppInsets.l),
                                Text(topic.name, style: headingStyle),
                              ],
                            ),
                            const SizedBox(height: AppInsets.xl),
                            Text(
                              topic.description,
                              style: descriptionStyle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppInsets.xxl,
                      right: AppInsets.xl,
                      left: AppInsets.xl),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: BaseContainer(
                      radius: 30,
                      color: Theme.of(context).backgroundColor,
                      child: GestureDetector(
                        onTap: () => onTapCard(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20),
                          child: Text(
                            "Start a conversation",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 14.00,
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

  void onTapCard(BuildContext context) {
    if (onTap != null) {
      onTap();
      return;
    }

    ExtendedNavigator.of(context)
        .push(Routes.createConversationScreen,
            arguments: CreateConversationScreenArguments(
                topic: topic, type: ConversationType.instant))
        .then(
      (value) {
        if (value is Conversation) {
          HomeTabControllerProvider.of(context).controller.animateTo(1);
          ExtendedNavigator.of(context)
              .push(Routes.conversationScreen(id: value.id));
        }
      },
    );
  }
}
