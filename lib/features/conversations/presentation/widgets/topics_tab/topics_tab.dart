import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/topics_list/topics_list.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';
import '../article_topic_card/article_topic_card.dart';
import 'topics_tab_state.dart';

class TopicsTab extends HookWidget {
  final String name;

  const TopicsTab({@required this.name});

  @override
  Widget build(BuildContext context) {
    final articlesState = useProvider(articleTopicsStateProiver.state);

    return DefaultTabController(
      length: 2,
      child: ScaffoldContainer(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              elevation: 0.5,
              forceElevated: true,
              shadowColor: Colors.grey,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: const PreferredSize(
                preferredSize: Size(300, 50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Group topics'),
                      Tab(text: '1:1 topics'),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What type of conversation\nwould you like to have?',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                        onRefresh: () {
                          final futures = [
                            context
                                .read(articleTopicsStateProiver)
                                .getAllArticleTopcs(),
                          ];

                          return Future.wait(futures);
                        },
                        child: articlesState.when(
                          loading: () => Container(),
                          error: (err, st) => Container(),
                          data: (topics) => Column(
                            children: [
                              Expanded(
                                  child: _ArticleTopicList(topics: topics)),
                            ],
                          ),
                        )),
                    TopicsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
    return ListView.builder(
      itemBuilder: (context, index) => ArticleTopicCard(topic: topics[index]),
      itemCount: topics.length,
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
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 15.00,
        );
    return BaseContainer(
      radius: 8,
      child: Material(
        borderRadius: cardRadius,
        child: GestureDetector(
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
              const SizedBox(width: 8),
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
