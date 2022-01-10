import 'package:auto_route/auto_route.dart';
import 'package:custom_rounded_rectangle_border/custom_rounded_rectangle_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../../routes.gr.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';
import '../speaker_avatar/speaker_avatar.dart';

enum SpeakerChairPosition { top, left, right, bottom }

class SpeakerChair extends StatelessWidget {
  final dynamic speaker;
  final SpeakerChairPosition position;
  final bool isLive;
  final double avtarSize;

  const SpeakerChair({
    Key? key,
    required this.speaker,
    required this.avtarSize,
    required this.position,
    required this.isLive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderWidth = 3;
    const padding = 2;
    final iconSize = avtarSize - (borderWidth + padding) * 2;
    final primaryColor = Theme.of(context).backgroundColor;
    final borderSide = BorderSide(color: primaryColor, width: 3);
    final authUserPK = BlocProvider.of<AuthBloc>(context).state.user!.pk;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: ShapeDecoration(
        shape: CustomRoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          topSide: position == SpeakerChairPosition.top ? borderSide : null,
          leftSide: position == SpeakerChairPosition.left ? borderSide : null,
          rightSide: position == SpeakerChairPosition.right ? borderSide : null,
          bottomSide:
              position == SpeakerChairPosition.bottom ? borderSide : null,
          topLeftCornerSide: position == SpeakerChairPosition.top ||
                  position == SpeakerChairPosition.left
              ? borderSide
              : null,
          topRightCornerSide: position == SpeakerChairPosition.top ||
                  position == SpeakerChairPosition.right
              ? borderSide
              : null,
          bottomLeftCornerSide: position == SpeakerChairPosition.bottom ||
                  position == SpeakerChairPosition.left
              ? borderSide
              : null,
          bottomRightCornerSide: position == SpeakerChairPosition.bottom ||
                  position == SpeakerChairPosition.right
              ? borderSide
              : null,
        ),
      ),
      child:
          speaker != null && (speaker is ConversationUser || speaker is RtcUser)
              ? (speaker is ConversationUser)
                  ? BaseNetworkImage(
                      imageUrl: (speaker as ConversationUser?)?.photo,
                      defaultImage: AppImageAssets.defaultAvatar,
                      imagebuilder: (context, imageProvider) => Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        AutoRouter.of(context).push(ProfileScreenRoute(
                            userId: (speaker as ConversationUser?)!.pk!,
                            allowEdit: speaker.pk == authUserPK));
                      },
                      child: SpeakerAvatar(
                        user: speaker as RtcUser,
                        avtarSize: iconSize,
                        isLive: isLive,
                      ))
              : Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                ),
    );
  }
}
