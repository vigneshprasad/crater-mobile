import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/meeting_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'meeting_card.dart';

class MeetingsPastTab extends StatefulWidget {
  final List<Meeting> past;
  final Function onRefresh;

  const MeetingsPastTab({
    Key key,
    @required this.past,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  _MeetingsPastTabState createState() => _MeetingsPastTabState();
}

class _MeetingsPastTabState extends State<MeetingsPastTab> {
  Completer _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            SliverPadding(
              padding: const EdgeInsets.only(
                left: AppInsets.med,
                right: AppInsets.med,
                top: AppInsets.med,
                bottom: 120,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  _meetingItemBuilder,
                  childCount: widget.past.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _meetingItemBuilder(BuildContext context, int index) {
    final Meeting meeting = widget.past[index];
    final User user = BlocProvider.of<AuthBloc>(context).state.user;
    return MeetingCard(
      meeting: meeting,
      user: user,
    );
  }
}
