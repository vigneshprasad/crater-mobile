import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../domain/entity/video_entity.dart';

class VideoPlayerListItem extends StatelessWidget {
  final Video video;
  final VoidCallback onPressItem;

  const VideoPlayerListItem({
    Key? key,
    required this.video,
    required this.onPressItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headingStyle = theme.textTheme.subtitle2;
    final descStyle = theme.textTheme.bodyText2?.copyWith(
      color: Colors.grey[400],
    );
    return ListTile(
      leading: _buildImagePreview(),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppInsets.sm,
        horizontal: AppInsets.xl,
      ),
      isThreeLine: true,
      title: Text(
        video.author!,
        style: headingStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        video.description!,
        style: descStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onPressItem,
    );
  }

  Widget _buildImagePreview() {
    if (video.thumbnail == null) {
      return Container(
        width: 64,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
          image: const DecorationImage(
            image: AppImageAssets.defaultAvatar,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: video.thumbnail!,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 64,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
