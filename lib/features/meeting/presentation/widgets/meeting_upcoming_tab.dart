import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/features/meeting/presentation/bloc/meeting_bloc.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import 'meeting_card.dart';

class MeetingUpcomingTab extends StatefulWidget {
  final List<Meeting> upcoming;
  final MeetingConfig config;
  final UserMeetingPreference preference;
  final Function onRefresh;

  const MeetingUpcomingTab({
    Key key,
    @required this.upcoming,
    @required this.config,
    @required this.preference,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  _MeetingUpcomingTabState createState() => _MeetingUpcomingTabState();
}

class _MeetingUpcomingTabState extends State<MeetingUpcomingTab> {
  Completer _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emptyLabelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey[600],
          height: 1.4,
        );
    final List<Widget> slivers = [];
    final image = widget.preference == null
        ? AppImageAssets.meetingsEmpty
        : AppImageAssets.meetingScheduled;
    final text = widget.preference == null
        ? AppLocalizations.of(context).translate("meeting:empty_meetings")
        : AppLocalizations.of(context).translate("meeting:empty_scheduled");
    if (widget.upcoming.isEmpty) {
      slivers.add(SliverToBoxAdapter(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: image,
                  width: 220,
                ),
                const SizedBox(height: AppInsets.l),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    text,
                    style: emptyLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    } else {
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.only(
            left: AppInsets.med,
            right: AppInsets.med,
            top: AppInsets.med,
            bottom: 120,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              _buildMeetingCard,
              childCount: widget.upcoming.length,
            ),
          ),
        ),
      );
    }

    return BlocListener<MeetingBloc, MeetingState>(
      listener: (context, state) {
        if (state is GetMeetingLoaded) {
          _completer.complete();
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          _completer = Completer();
          widget.onRefresh();
          return _completer.future;
        },
        displacement: 120,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            ...slivers
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingCard(BuildContext context, int index) {
    final Meeting meeting = widget.upcoming[index];
    final User user = BlocProvider.of<AuthBloc>(context).state.user;
    return MeetingCard(
      meeting: meeting,
      user: user,
    );
  }
}
