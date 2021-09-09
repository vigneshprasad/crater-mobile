import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, index) {
        return InfoCell(item: _infoItems[index]);
      },
      separatorBuilder: (c, i) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: _infoItems.length,
    );
  }
}

final _infoItems = [
  InfoItem(
    image: 'club1',
    title: 'Build Your Club',
    subtitle: 'Bring together like minds & your followers.',
    height: 215,
  ),
  InfoItem(
    image: 'club2',
    title: 'Go Live',
    subtitle: 'Stream to your auidence from anywhere & anytime.',
    height: 210,
  ),
  InfoItem(
    image: 'club3',
    title: 'Auction Tokens',
    subtitle: 'These work like tickets for members to buy to unlock rewards.',
    height: 245,
  ),
  InfoItem(
    image: 'club4',
    title: 'Set up rewards',
    subtitle:
        'Tokens unlocks access to your rewards. These can be 1:1, AMAs or Q/A',
    height: 280,
  ),
];

class InfoItem {
  final String image;
  final String title;
  final String subtitle;
  final double height;

  InfoItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.height,
  });
}

class InfoCell extends StatelessWidget {
  final InfoItem item;
  const InfoCell({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor.withAlpha(50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/coming_soon/${item.image}.png",
            width: double.infinity,
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 12),
              Text(item.subtitle, style: Theme.of(context).textTheme.headline6),
            ],
          ),
        ],
      ),
    );
  }
}
