import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';
import 'package:worknetwork/core/widgets/base/base_container/scaffold_container.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import 'package:worknetwork/features/conversations/domain/entity/optin_entity/optin_entity.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';
import '../article_topic_card/article_topic_card.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';
import 'topics_tab_state.dart';

class TopicsTab extends HookWidget {
  final String name;

  const TopicsTab({@required this.name});

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
      child: ScaffoldContainer(
        child: CustomScrollView(
          slivers: [
            SliverObstructionInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Hi $name',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pick a topic you want to converse about',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
            topicsState.maybeWhen(
              data: (data) {
                Widget child;
                if (data.isNotEmpty) {
                  child = Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.xxl,
                      vertical: AppInsets.xl,
                    ),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("topic_tab:suggested_topic_heading"),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          // fontWeight: FontWeight.w700,
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
            topicsState.when(
              loading: () => _SliverLoader(child: Container()),
              error: (err, st) => _SliverLoader(child: Container()),
              data: (topics) => _TopicsGrid(
                topics: topics,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: AppInsets.med)),
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
                      AppLocalizations.of(context)
                          .translate("topic_tab:article_topic_headings"),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          // fontWeight: FontWeight.w700,
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
        bottom: AppInsets.xl,
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
          crossAxisSpacing: 40,
          mainAxisSpacing: 28,
          childAspectRatio: 3,
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
          // fontWeight: FontWeight.w700,
        );
    return BaseContainer(
      radius: 8,
      child: Material(
        borderRadius: cardRadius,
        // color: background,
        child: GestureDetector(
          // highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
          // borderRadius: cardRadius,
          // splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: (topic.image != null)
                      ? Image.network(
                          topic.image,
                          width: 56,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                width: 100,
                child: Text(
                  topic.name,
                  style: labelStyle,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
