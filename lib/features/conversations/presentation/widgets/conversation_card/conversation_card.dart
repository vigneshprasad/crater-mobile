import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';

import '../../../../../routes.gr.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';

class ConversationCard extends StatelessWidget {
  final Conversation conversation;
  const ConversationCard({
    required this.conversation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final conversation = item;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = conversation.description ?? '';
    }
    String title = user?.name ?? '';
    const type = GridItemType.upcoming;
    if (type == GridItemType.upcoming) {
      title = topic?.name ?? '';
      description = user?.name ?? '';
    }

    return InkWell(
      onTap: () {
        AutoRouter.of(context)
            .push(ConversationScreenRoute(id: conversation.id));
      },
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Theme.of(context).dialogBackgroundColor,
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    if (topic?.image != null)
                      Image.network(
                        topic?.image ?? '',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    if (type == GridItemType.upcoming)
                      LiveTime(date: conversation.start),
                    if (type == GridItemType.past)
                      const Center(
                        child: Icon(Icons.play_circle, size: 80),
                      )
                  ],
                ),
              ),
            )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user?.photo ?? ''),
                      backgroundColor: Theme.of(context).dialogBackgroundColor,
                      radius: 28,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.subtitle2,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (tag?.name?.isNotEmpty ?? false)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                ),
                                child: Text(
                                  tag?.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
