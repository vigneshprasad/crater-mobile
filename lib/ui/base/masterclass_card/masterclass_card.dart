import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/models/masterclass/masterclass_model.dart';

class MasterclassCard extends StatelessWidget {
  final MasterClass item;

  const MasterclassCard({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        splashColor: Colors.grey[200],
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildVideoThumbnail(),
            _buildVideoInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail() {
    return Container(
      width: double.infinity,
      height: 180,
      color: Colors.grey[500],
      child: Center(
        child: _buildPlayIcon(),
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildVideoInfo(BuildContext context) {
    final headingStyle =
        Theme.of(context).textTheme.headline6.copyWith(fontSize: 18);
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.med,
        left: AppInsets.xl,
        right: AppInsets.xl,
        bottom: AppInsets.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.author, style: headingStyle),
          const SizedBox(height: AppInsets.sm),
          Text(item.description, style: bodyStyle)
        ],
      ),
    );
  }
}
