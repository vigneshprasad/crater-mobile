import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/color/color.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';
import '../topics_tab/topics_tab_state.dart';

class TopicsList extends HookWidget {
  final bool showTitle;

  const TopicsList({
    Key? key,
    @PathParam("editMode") required this.showTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicsState = useProvider(topicsStateProvider);
    return Scaffold(
      appBar: !showTitle
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(
                'Pick a 1:1 topic you wish to discuss',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
      body: RefreshIndicator(
          onRefresh: () {
            final futures = [
              context.read(topicsStateProvider.notifier).getTopicsList(),
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
          )),
    );
  }
}

class AMATopicsList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final topicsState = useProvider(amaTopicsStateProvider);
    return RefreshIndicator(
        onRefresh: () {
          final futures = [
            context.read(amaTopicsStateProvider.notifier).getTopicsList(),
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
  final VoidCallback? onTap;

  const _TopicCard({
    Key? key,
    required this.topic,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20.00));
    final backgroundColor = HexColor.fromHex('#DDE9FD');
    final headingStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          fontSize: 15.00,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).canvasColor,
        );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).canvasColor,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.l, horizontal: AppInsets.xl),
      child: GestureDetector(
        onTap: () => onTapCard(context),
        child: Material(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: borderRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
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
                            Expanded(
                              child:
                                  Text(topic.name ?? '', style: headingStyle),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppInsets.xl),
                        Text(
                          topic.description ?? '',
                          style: descriptionStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
                  child: BaseLargeButton(
                    text: "Start a conversation",
                    outlined: true,
                    onPressed: () => onTapCard(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapCard(BuildContext context) {
    if (onTap != null) {
      onTap!();
      return;
    }

    AutoRouter.of(context)
        .push(CreateConversationScreenRoute(
            topic: topic, type: ConversationType.curated))
        .then(
      (value) {
        if (value is Conversation) {
          HomeTabControllerProvider.of(context)?.controller.animateTo(1);
          AutoRouter.of(context).push(ConversationScreenRoute(id: value.id));
        }
      },
    );
  }
}
