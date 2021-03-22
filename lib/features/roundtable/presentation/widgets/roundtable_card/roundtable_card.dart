import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/roundtable/presentation/widgets/roundtable_card/speakers_table.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card_layout/roundtable_card_layout.dart';

const kAvatarSize = 48.00;

class RoundTableCard extends StatelessWidget {
  final Object data;
  final String rootTopicLabel;
  final String topicLabel;
  final DateTime startTime;
  final DateTime endTime;
  final String description;
  final List<RoundTableUser> speakers;
  final List<MeetingInterestModel> interests;
  final ValueChanged<Object> onPressed;
  final bool isOptin;

  const RoundTableCard({
    Key key,
    @required this.data,
    this.rootTopicLabel,
    @required this.topicLabel,
    @required this.startTime,
    @required this.endTime,
    this.description,
    this.speakers,
    this.interests,
    this.onPressed,
    this.isOptin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final dateTextStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 13,
          color: Colors.grey,
        );
    final categoryStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: Theme.of(context).primaryColor,
        );
    final agendaStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 18,
        );
    final dateStyle = categoryStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
    );
    final descriptionStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 15,
          color: Colors.grey[600],
        );
    final dateFormat = DateFormat("EEE, dd MMM");
    return RoundTableCardLayout(
      onPressed: onPressed != null
          ? () {
              onPressed(data);
            }
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isOptin)
            Text(
              dateFormat.format(startTime),
              style: dateTextStyle,
            ),
          if (rootTopicLabel != null) const SizedBox(height: AppInsets.sm),
          if (rootTopicLabel != null)
            Text(rootTopicLabel, style: categoryStyle),
          Text(topicLabel, style: agendaStyle),
          Text(
            isOptin
                ? AppLocalizations.of(context)
                    .translate("conversations:scheduling")
                : "${timeFormat.format(startTime)} - ${timeFormat.format(endTime)}",
            style: dateStyle,
          ),
          const SizedBox(height: AppInsets.l),
          // if (description != null)
          //   Text(
          //     description,
          //     maxLines: 4,
          //     overflow: TextOverflow.ellipsis,
          //     style: descriptionStyle,
          //   ),
          const Spacer(),
          if (isOptin)
            const Center(
              child: Image(
                image: AppImageAssets.meetingsEmpty,
                height: 120,
              ),
            ),
          const Spacer(),
          if (speakers != null) SpeakersTable(speakers: speakers),
          const Spacer(),
          const Divider(),
          const SizedBox(height: AppInsets.l),
          if (interests != null)
            Wrap(
              children: interests
                  .map(
                    (interest) => _InterestTag(interest: interest),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _SpeakersList extends StatelessWidget {
  final List<RoundTableUser> speakers;

  const _SpeakersList({
    Key key,
    @required this.speakers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kAvatarSize,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: _buildItems(context),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    final List<Widget> items = [];

    speakers.asMap().forEach((index, value) {
      items.add(
        Positioned(
          left: index * (kAvatarSize / 1.5),
          child: BaseNetworkImage(
            imageUrl: value.photo,
            defaultImage: AppImageAssets.defaultAvatar,
            imagebuilder: (context, imageProvider) => Container(
              width: kAvatarSize,
              height: kAvatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider),
                border: Border.all(width: 3, color: Colors.white),
              ),
            ),
          ),
        ),
      );
    });

    return items;
  }
}

class _InterestTag extends StatelessWidget {
  final MeetingInterestModel interest;

  const _InterestTag({
    Key key,
    this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 13.00,
          color: Colors.grey[500],
        );
    return Padding(
      padding: const EdgeInsets.only(right: AppInsets.l),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          "#${interest.name}",
          style: labelStyle,
        ),
      ),
    );
  }
}
