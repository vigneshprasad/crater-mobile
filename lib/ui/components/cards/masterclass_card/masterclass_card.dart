import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../features/videos/domain/entity/video_entity.dart';
import '../../../../routes.gr.dart';

class MasterclassCard extends StatelessWidget {
  final Video item;

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
        onTap: () {
          if (item.thumbnail != null) {
            ExtendedNavigator.of(context).push(
              Routes.videoPlayerScreen,
              arguments: VideoPlayerScreenArguments(videoId: item.pk),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildVideoThumbnail(context),
            _buildVideoInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail(BuildContext context) {
    final ImageProvider<dynamic> image = item.thumbnail == null
        ? AppImageAssets.videoPlaceholder
        : CachedNetworkImageProvider(item.thumbnail) as ImageProvider;
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
            image: image, fit: item.thumbnail == null ? null : BoxFit.cover),
      ),
      child: Center(
        child: item.thumbnail != null ? _buildPlayIcon() : null,
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
        Theme.of(context).textTheme.headline6.copyWith(fontSize: 16);
    final bodyStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 14, color: Colors.grey[600]);
    return Padding(
      padding: const EdgeInsets.only(
        top: AppInsets.xl,
        left: AppInsets.xl,
        right: AppInsets.xl,
        bottom: AppInsets.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.author, style: headingStyle),
          const SizedBox(height: AppInsets.sm),
          Text(
            item.description,
            style: bodyStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
