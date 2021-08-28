import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../screens/create_conversation_screen/create_conversation_state.dart';
import '../article_topic_card/article_topic_card.dart';
import '../topics_list/topics_list.dart';
import 'topics_tab_state.dart';

class TopicsTab extends HookWidget {
  final String name;
  final ValueNotifier<int> topic;

  TopicsTab({
    required this.name,
    required this.topic,
  });

  final titles = [
    'Pick a 1:1 topic you wish to discuss',
    'On what would you like to host an AMA?',
    'What would you like to speak about?',
  ];

  @override
  Widget build(BuildContext context) {
    final articlesState = useProvider(articleTopicsStateProiver);
    final _tabController = useTabController(
        initialLength: titles.length, initialIndex: topic.value);
    final _textController = useTextEditingController();
    final _topicSuggestion = useState('');

    useEffect(() {
      _tabController.index = topic.value;
      return;
    });

    _tabController.addListener(() {
      topic.value = _tabController.index;
    });
    return DefaultTabController(
      length: 3,
      child: ScaffoldContainer(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: const Size(300, 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TabBar(
                    controller: _tabController,
                    onTap: (value) {
                      topic.value = value;
                    },
                    tabs: const [
                      Tab(text: '1:1'),
                      Tab(text: 'AMA'),
                      Tab(text: 'Round Table'),
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
                height: (topic.value != 0) ? 140 : 50,
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
                        titles[topic.value],
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.grey),
                      ),
                      if (topic.value != 0)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: BaseFormInput(
                                        label: 'Suggest a topic',
                                        controller: _textController,
                                        onChanged: (text) =>
                                            _topicSuggestion.value = text,
                                      ),
                                    ),
                                    if (_topicSuggestion.value.isNotEmpty)
                                      SizedBox(
                                        width: 80,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            final result =
                                                await _postTopicSuggestion(
                                              context,
                                              _topicSuggestion.value,
                                              typeForIndex(topic.value),
                                            );
                                            if (result) {
                                              _textController.text = '';
                                              _topicSuggestion.value = '';
                                            }
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TopicsList(showTitle: false),
                    AMATopicsList(),
                    RefreshIndicator(
                        onRefresh: () {
                          final futures = [
                            context
                                .read(articleTopicsStateProiver.notifier)
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TopicType typeForIndex(int index) {
    switch (index) {
      case 1:
        return TopicType.ama;
      case 2:
        return TopicType.group;
      default:
        return TopicType.group;
    }
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Theme.of(context).backgroundColor.withOpacity(0.8),
          child: _Loader(),
        );
      },
    );
  }

  Future<bool> _postTopicSuggestion(
    BuildContext context,
    String topic,
    TopicType type,
  ) async {
    final _overlay = _buildLoaderOverlay();

    Overlay.of(context)?.insert(_overlay);

    final response = await context
        .read(conversationRepositoryProvider)
        .postTopicSuggestion(Topic(
          name: topic,
          type: type,
        ));

    return response.fold(
      (failure) {
        _overlay.remove();
        Fluttertoast.showToast(msg: failure.message!);
        return false;
      },
      (topic) {
        _overlay.remove();

        final conversationType = type == TopicType.ama
            ? ConversationType.instant
            : ConversationType.ama;
        AutoRouter.of(context)
            .push(CreateConversationScreenRoute(
                topic: topic, type: conversationType))
            .then(
          (value) {
            if (value is Conversation) {
              HomeTabControllerProvider.of(context)?.controller.animateTo(1);
              AutoRouter.of(context)
                  .push(ConversationScreenRoute(id: value.id));
            }
          },
        );

        return true;
      },
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ArticleTopicList extends StatelessWidget {
  final List<Topic> topics;

  const _ArticleTopicList({
    Key? key,
    required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ArticleTopicCard(topic: topics[index]),
      itemCount: topics.length,
    );
  }
}
