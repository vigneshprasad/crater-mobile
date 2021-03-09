import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';
import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';

class RoundTableCard extends StatelessWidget {
  final RoundTable table;

  const RoundTableCard({
    Key key,
    @required this.table,
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
    final dateFormat = DateFormat("EEE, dd MMM");
    final agendaName = table.topic.name;
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context)
            .push(Routes.roundTableScreen(id: table.id));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppInsets.xl,
            right: AppInsets.xl,
            top: 24,
            bottom: AppInsets.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dateFormat.format(table.start), style: dateTextStyle),
              const SizedBox(height: AppInsets.med),
              if (table.topic.root != null)
                Text(table.topic.root.name, style: categoryStyle),
              const SizedBox(height: AppInsets.med),
              Text(agendaName, style: agendaStyle),
              const SizedBox(height: AppInsets.med),
              Text(
                "${timeFormat.format(table.start)} - ${timeFormat.format(table.end)}",
                style: dateStyle,
              ),
              const SizedBox(height: AppInsets.xxl),
              Wrap(
                children: table.interests
                    .map(
                      (interest) => _InterestTag(interest: interest),
                    )
                    .toList(),
              ),
              const Spacer(),
              const SizedBox(height: AppInsets.l),
              const Divider(),
              const SizedBox(height: AppInsets.l),
              Stack(
                children: [
                  _SpeakersList(speakers: table.speakers),
                ],
              )
            ],
          ),
        ),
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
      height: 48,
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
          left: index * 24.00,
          child: CachedNetworkImage(
            imageUrl: value.photo,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider),
                  border: Border.all(width: 3, color: Colors.white),
                ),
              );
            },
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
          color: Colors.white,
        );
    return Padding(
      padding: const EdgeInsets.only(right: AppInsets.l),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppInsets.sm, horizontal: AppInsets.l),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          interest.name,
          style: labelStyle,
        ),
      ),
    );
  }
}
