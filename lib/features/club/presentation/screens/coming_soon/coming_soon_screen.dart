import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
  ),
  InfoItem(
    image: 'club2',
    title: 'Enage your auidence',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
  ),
  InfoItem(
    image: 'club3',
    title: 'Give Exclusive Access',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
  ),
  InfoItem(
    image: 'club4',
    title: 'Monetize',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do',
  ),
];

class InfoItem {
  final String image;
  final String title;
  final String subtitle;

  InfoItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class InfoCell extends StatelessWidget {
  final InfoItem item;
  const InfoCell({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: HexColor.fromHex('#101010'),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/coming_soon/${item.image}.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(item.subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
