import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/meetings_by_date_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'meeting_card.dart';
import 'meeting_date_label.dart';

class MeetingsPastTab extends StatefulWidget {
  final List<MeetingsByDate> past;
  final Function onRefresh;

  const MeetingsPastTab({
    Key? key,
    required this.past,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _MeetingsPastTabState createState() => _MeetingsPastTabState();
}

class _MeetingsPastTabState extends State<MeetingsPastTab> {
  late Completer _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingBloc, MeetingState>(
      listener: (context, state) {
        if (state is GetPastMeetingsLoaded) {
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
            ..._buildMeetingListforDate(context),
            const SliverToBoxAdapter(
              child: SizedBox(height: 120),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMeetingListforDate(BuildContext context) {
    final List<Widget> slivers = [];

    for (final MeetingsByDate meetingsByDate in widget.past) {
      slivers.add(SliverToBoxAdapter(
        child: MeetingDateLabel(
          date: meetingsByDate.date!,
        ),
      ));

      slivers.add(SliverPadding(
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med,
          horizontal: AppInsets.med,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final user = BlocProvider.of<AuthBloc>(context).state.user;
              return MeetingCard(
                meeting: meetingsByDate.meetings![index],
                user: user!,
                onRefresh: widget.onRefresh,
              );
            },
            childCount: meetingsByDate.meetings?.length,
          ),
        ),
      ));
    }

    return slivers;
  }
}
