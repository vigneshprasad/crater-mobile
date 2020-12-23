import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../domain/entity/meeting_rsvp_entity.dart';
import '../utils/meeting_rsvp_utils.dart';

class RsvpIndicator extends StatelessWidget {
  final MeetingRsvp rsvp;

  const RsvpIndicator({
    Key key,
    @required this.rsvp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        _buildImagePreview(context),
        _buildStatusIndicator(context),
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    final photo = rsvp.participant.photo;
    if (photo == null) {
      return _buildAvatar(AppImageAssets.defaultAvatar);
    }
    return CachedNetworkImage(
      imageUrl: photo,
      imageBuilder: (context, imageProvider) => _buildAvatar(imageProvider),
    );
  }

  Widget _buildAvatar(ImageProvider photo) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.sm),
        child: CircleAvatar(
          radius: 14,
          backgroundImage: photo,
        ),
      );

  Widget _buildStatusIndicator(BuildContext context) {
    return Positioned.directional(
      textDirection: TextDirection.ltr,
      bottom: -4.0,
      end: 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: MeetingRsvpUtils.getRsvpStatusColor(rsvp.status),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
