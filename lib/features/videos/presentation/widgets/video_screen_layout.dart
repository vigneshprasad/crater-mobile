import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';
import '../../domain/entity/video_entity.dart';

class VideoScreenLayout extends StatelessWidget {
  final Widget videoPlayer;
  final Widget playlist;
  final Video featureVideo;

  const VideoScreenLayout({
    Key key,
    this.featureVideo,
    @required this.videoPlayer,
    @required this.playlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        videoPlayer,
        _buildVideoDetails(context, featureVideo),
        Divider(
          color: Colors.grey[400],
          indent: AppInsets.xl,
          endIndent: AppInsets.xl,
        ),
        Expanded(
          child: playlist,
        )
      ],
    );
  }

  Widget _buildVideoDetails(BuildContext context, Video featureVideo) {
    final headingStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          fontWeight: FontWeight.w500,
        );
    final subheadStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey[400],
          height: 1.2,
          fontSize: 13,
        );

    if (featureVideo == null) {
      return Container(height: 72);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppInsets.l, horizontal: AppInsets.xl),
        child: Container(
          width: double.infinity,
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            text: TextSpan(children: [
              TextSpan(text: "${featureVideo.author}\n\n", style: headingStyle),
              TextSpan(text: featureVideo.description, style: subheadStyle),
            ]),
          ),
        ),
      );
    }
  }
}
