import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/custom_tabs/custom_tabs.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_participant_entity.dart';
import 'package:worknetwork/ui/base/base_text/base_text_expand.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../constants/theme.dart';
import '../../../../routes.gr.dart';
import '../../domain/entity/meeting_entity.dart';

class MeetingCard extends StatelessWidget {
  final Meeting meeting;
  final User user;

  const MeetingCard({
    Key key,
    @required this.meeting,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MeetingParticipant participant =
        meeting.participants.firstWhere((element) => element.pk != user.pk);
    final introStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          height: 1.4,
          color: Colors.grey[700],
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppInsets.xl,
          right: AppInsets.xl,
          top: AppInsets.xxl,
          bottom: AppInsets.med,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, participant),
            const SizedBox(height: AppInsets.l),
            const Divider(),
            const SizedBox(height: AppInsets.l),
            BaseTextExpand(
              participant.introduction,
              style: introStyle,
            ),
            const SizedBox(height: AppInsets.l),
            const Divider(),
            const SizedBox(height: AppInsets.med),
            _buildCardActions(context, participant)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MeetingParticipant participant) {
    final DateFormat dateFormat = DateFormat('jm').add_yMMMEd();
    final dateStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          color: Colors.grey[500],
        );
    final String titleText = meeting.isPast ? 'You met ' : 'You will meet ';
    final baseNameStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[500],
        );
    return Row(
      children: [
        if (participant.photo != null)
          CachedNetworkImage(
            imageUrl: participant.photo,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
            ),
          ),
        if (participant.photo == null)
          const CircleAvatar(backgroundImage: AppImageAssets.defaultAvatar),
        const SizedBox(width: AppInsets.l),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: baseNameStyle,
                children: [
                  TextSpan(text: titleText),
                  TextSpan(
                    text: participant.name,
                    style: baseNameStyle.copyWith(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppInsets.xs),
            if (meeting.start != null)
              Text(
                'at ${dateFormat.format(meeting.start)}',
                style: dateStyle,
              ),
          ],
        )
      ],
    );
  }

  Widget _buildCardActions(
      BuildContext context, MeetingParticipant participant) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlineButton(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
          onPressed: () {
            ExtendedNavigator.of(context).push(
              Routes.chatScreen,
              arguments: ChatScreenArguments(recieverId: participant.pk),
            );
          },
          child: Text(AppLocalizations.of(context)
              .translate("meeting:card_chat_button")),
        ),
        const SizedBox(width: AppInsets.l),
        if (!meeting.isPast)
          FlatButton(
            onPressed: () {
              KiwiContainer().resolve<CustomTabs>().openLink(meeting.link);
            },
            color: Theme.of(context).primaryColor,
            child: Text(AppLocalizations.of(context)
                .translate("meeting:card_join_link_button")),
          ),
        if (meeting.isPast)
          FlatButton(
            onPressed: () {
              final link = "${AppConstants.meetingTypeformLink}${user.email}";
              KiwiContainer().resolve<CustomTabs>().openLink(link);
            },
            color: Theme.of(context).primaryColor,
            child: Text(AppLocalizations.of(context)
                .translate("meeting:card_share_feedback")),
          ),
      ],
    );
  }
}
