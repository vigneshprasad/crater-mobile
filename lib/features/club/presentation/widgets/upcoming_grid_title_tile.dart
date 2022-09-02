import 'package:flutter/material.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';

class UpcomingGridTitleTile extends StatelessWidget {
  final UpcomingGridItem item;
  const UpcomingGridTitleTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Wrap(
          spacing: 8,
          children: item.title == 'Going Live Soon'
              ? [
                  Text(
                    'Going Live Soon',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ]
              : [
                  Text(
                    'Series',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  Text(
                    'by our creators',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
        ),
      ),
    );
  }
}
