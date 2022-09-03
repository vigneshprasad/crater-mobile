import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class PastStreamList extends HookConsumerWidget {
  final List<UpcomingGridItem> gridItems;
  final String title;
  final bool showCategories;
  const PastStreamList({
    required this.gridItems,
    required this.title,
    this.showCategories = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: gridItems.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, index) {
        final c = gridItems[index];
        final image = c.conversation?.topicDetail?.image;
        final title = c.conversation?.topicDetail?.name ?? '';
        final userImage = c.conversation?.hostDetail?.photo;
        final userName = c.conversation?.hostDetail?.name ?? '';

        final items = [
          const SizedBox(
            height: 36,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (showCategories)
            Column(
              children: const [
                SizedBox(
                  height: 12,
                ),
                CategoryGridView(type: GridItemType.past),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
        ];

        return Column(
          children: [
            if (index == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items,
              ),
            InkWell(
              onTap: () {
                AutoRouter.of(context).push(
                  PastStreamDetailScreenRoute(id: c.conversation?.id),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (image != null)
                          Image.network(
                            image,
                            height: 68,
                            width: 114,
                            fit: BoxFit.cover,
                          )
                        else
                          const SizedBox(
                            height: 68,
                            width: 114,
                          ),
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
                                      backgroundImage:
                                          CachedNetworkImageProvider(
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamTime(start: c.conversation?.start)
                  ],
                ),
              ),
            ),
            if (index == gridItems.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Divider(),
                    PlainButton(
                      title: 'View All',
                      icon: Icons.arrow_forward_ios,
                      borderColor: HexColor.fromHex('#373737'),
                      onPressed: () {
                        AutoRouter.of(context).push(PastStreamScreenRoute());
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 32,
        );
      },
    );
  }
}
