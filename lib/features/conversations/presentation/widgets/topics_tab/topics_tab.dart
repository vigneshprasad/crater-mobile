import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/topics_list/topics_list.dart';

import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../article_topic_card/article_topic_card.dart';
import 'topics_tab_state.dart';

class TopicsTab extends HookWidget {
  final String name;
  final int topic;

  const TopicsTab({
    @required this.name,
    this.topic = 0,
  });

  @override
  Widget build(BuildContext context) {
    final articlesState = useProvider(articleTopicsStateProiver.state);

    return DefaultTabController(
      length: 2,
      initialIndex: topic,
      child: ScaffoldContainer(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              // floating: true,
              // elevation: 0.5,
              // forceElevated: true,
              // shadowColor: Colors.grey,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: const Size(300, 60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: const [
                      TabBar(
                        tabs: [
                          Tab(text: 'Group topics'),
                          Tab(text: '1:1 topics'),
                        ],
                      ),
                      Divider(height: 0.5)
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
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'What type of conversation would you like to have?',
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
