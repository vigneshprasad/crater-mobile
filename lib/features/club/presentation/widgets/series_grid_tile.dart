import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/widgets/live_time.dart';
import 'package:worknetwork/routes.gr.dart';

class SeriesGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const SeriesGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    final title = user?.name ?? '';

    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(SeriesScreenRoute(id: conversation.id));
      },
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
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
                      if (item.type == GridItemType.upcoming)
                        LiveTime(date: item.conversation?.start?.toLocal()),
                      if (item.type == GridItemType.past)
                        const Center(
                          child: Icon(Icons.play_circle, size: 80),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
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
                          ],
                        ),
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
