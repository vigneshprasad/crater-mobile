import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/theme.dart';
import '../../../../../routes.gr.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../meeting/data/models/meeting_interest_model.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';

class RoundTableCard extends StatelessWidget {
  final RoundTable table;
  final User user;

  const RoundTableCard({
    Key key,
    @required this.table,
    @required this.user,
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
    final categoryName = table.agenda.category.name;
    final agendaName = table.agenda.name;
    return Card(
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
            Text(categoryName, style: categoryStyle),
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
            _HostDisplay(host: table.host),
            const SizedBox(height: AppInsets.l),
            const Divider(),
            const SizedBox(height: AppInsets.l),
            Stack(
              children: [
                _SpeakersList(speakers: table.speakers),
                Align(
                  alignment: Alignment.centerRight,
                  child: _getActionButton(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getActionButton(BuildContext context) {
    final isSpeaker =
        table.speakers.where((element) => element.pk == user.pk).isNotEmpty;
    if (table.host.pk == user.pk) {
      return FlatButton(
        onPressed: () {
          ExtendedNavigator.of(context)
              .push(Routes.roundTableScreen(id: table.id));
        },
        child: Text("Manage Table"),
      );
    } else if (isSpeaker) {
      return FlatButton(
        onPressed: () {
          ExtendedNavigator.of(context)
              .push(Routes.roundTableScreen(id: table.id));
        },
        child: Text("View Table"),
      );
    } else {
      return FlatButton(
        onPressed: () {
          ExtendedNavigator.of(context)
              .push(Routes.roundTableScreen(id: table.id));
        },
        child: Text("Join Table"),
      );
    }
  }
}

class _SpeakersList extends StatelessWidget {
  final List<Speaker> speakers;

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

class _HostDisplay extends StatelessWidget {
  final Host host;

  const _HostDisplay({
    Key key,
    @required this.host,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1;
    return Row(
      children: [
        _buildThumbnail(context),
        const SizedBox(width: AppInsets.med),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hosted by", style: labelStyle),
            Text(host.name, style: labelStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail(BuildContext context) => CachedNetworkImage(
        imageUrl: host.photo,
        imageBuilder: (context, imageProvider) => Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider),
          ),
        ),
      );
}

class _InterestTag extends StatelessWidget {
  final MeetingInterestModel interest;

  const _InterestTag({
    Key key,
    this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith();
    return Padding(
      padding: const EdgeInsets.only(right: AppInsets.l),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppInsets.sm, horizontal: AppInsets.l),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.grey[700], width: 2),
        ),
        child: Text(
          interest.name,
          style: labelStyle,
        ),
      ),
    );
  }
}
