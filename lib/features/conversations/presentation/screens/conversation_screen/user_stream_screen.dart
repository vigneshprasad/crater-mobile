import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_state.dart';
import 'package:worknetwork/routes.gr.dart';

class UserStreamScreen extends HookConsumerWidget {
  final String userId;
  final int conversationId;
  const UserStreamScreen({
    Key? key,
    required this.userId,
    required this.conversationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastProvider = ref.watch(profilePastStreamsStateProvider(userId));
    return pastProvider.when(
      loading: () => Container(),
      error: (e, s) => Container(),
      data: (conversations) {
        final filterd = conversations
            .skipWhile((value) => value.conversation?.id == conversationId)
            .take(2)
            .toList()
            .asMap();
        if (filterd.isEmpty) return Container();
        final items = <Widget>[];
        filterd.forEach((key, value) {
          final c = value;
          final image = c.conversation?.topicDetail?.image;
          final title = c.conversation?.topicDetail?.name ?? '';
          final userImage = c.conversation?.hostDetail?.photo;
          final userName = c.conversation?.hostDetail?.name ?? '';
          double toppadding = key == 0 ? 14 : 0;
          final widget = Container(
            color: HexColor.fromHex("#121212"),
            padding: EdgeInsets.only(left: 12, right: 12, top: toppadding),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).push(
                      ConversationScreenRoute(id: c.conversation?.id),
                    );
                  },
                  child: Row(
                    children: [
                      if (image != null)
                        Image.network(
                          image,
                          height: 68,
                          width: 114,
                          fit: BoxFit.cover,
                        )
                      else
                        Container(),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                if (userImage != null)
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundImage: CachedNetworkImageProvider(
                                      userImage,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  userName,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (key < filterd.length - 1)
                  const Divider(
                    height: 32,
                  ),
              ],
            ),
          );
          items.add(widget);
        });

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              Column(
                children: items,
              ),
              Container(
                color: HexColor.fromHex('#121212'),
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 16,
                  bottom: 28,
                ),
                child: PlainButton(
                  title: 'View All',
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    AutoRouter.of(context).push(
                      ProfileScreenRoute(
                        userId: userId,
                        createrId: 0,
                        allowEdit: false,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
