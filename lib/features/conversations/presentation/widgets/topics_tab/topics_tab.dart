import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import 'package:worknetwork/features/conversations/domain/entity/optin_entity/optin_entity.dart';

import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';
import '../article_topic_card/article_topic_card.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';
import 'topics_tab_state.dart';

class TopicsTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final topicsState = useProvider(topicsStateProvider.state);
    final articlesState = useProvider(articleTopicsStateProiver.state);
    return RefreshIndicator(
      displacement: 96.00,
      onRefresh: () {
        final futures = [
          context.read(topicsStateProvider).getTopicsList(),
          context.read(articleTopicsStateProiver).getAllArticleTopcs(),
        ];

        return Future.wait(futures);
      },
      child: CustomScrollView(
        slivers: [
          SliverObstructionInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          topicsState.when(
            loading: () => _SliverLoader(child: Container()),
            error: (err, st) => _SliverLoader(child: Container()),
            data: (topics) => _TopicsGrid(
              topics: topics,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: AppInsets.xl)),
          articlesState.maybeWhen(
            data: (topics) {
              Widget child = Container();
              if (topics.isNotEmpty) {
                child = Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppInsets.xxl,
                    vertical: AppInsets.xl,
                  ),
                  child: Text(
                    "Trending Topics",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: child,
              );
            },
            orElse: () => const SliverToBoxAdapter(),
          ),
          articlesState.when(
            loading: () => _SliverLoader(child: Container()),
            error: (err, st) => _SliverLoader(child: Container()),
            data: (topics) => _ArticleTopicList(topics: topics),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 112.00)),
        ],
      ),
    );
  }
}

class _SliverLoader extends StatelessWidget {
  final Widget child;

  const _SliverLoader({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: child,
    );
  }
}

class _TopicsGrid extends StatelessWidget {
  final List<Topic> topics;

  const _TopicsGrid({
    Key key,
    @required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: AppInsets.xl,
        right: AppInsets.xl,
        top: AppInsets.xl,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _TopicGridCard(
            topic: topics[index],
          ),
          childCount: topics.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppInsets.l,
          mainAxisSpacing: AppInsets.l,
          childAspectRatio: 3.2,
        ),
      ),
    );
  }
}

class _ArticleTopicList extends StatelessWidget {
  final List<Topic> topics;

  const _ArticleTopicList({
    Key key,
    @required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: AppInsets.xl,
        right: AppInsets.xl,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleTopicCard(topic: topics[index]),
          childCount: topics.length,
        ),
      ),
    );
  }
}

class _TopicGridCard extends StatelessWidget {
  final Topic topic;
  const _TopicGridCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = BorderRadius.all(Radius.circular(8.00));
    final background = AppTheme.blueAccent;
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 15.00,
          fontWeight: FontWeight.w700,
        );
    return Material(
      borderRadius: cardRadius,
      color: background,
      child: InkWell(
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: cardRadius,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
        onTap: () {
          ExtendedNavigator.of(context)
              .push(Routes.createConversationScreen,
                  arguments: CreateConversationScreenArguments(
                      topic: topic, type: ConversationType.curated))
              .then((value) {
            if (value is Optin) {
              HomeTabControllerProvider.of(context).controller.animateTo(2);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(topic.name, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
