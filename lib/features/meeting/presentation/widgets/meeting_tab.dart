import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_interest_entity.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_objective_entity.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'register_meet.dart';

class MeetingTab extends StatefulWidget {
  @override
  _MeetingTabState createState() => _MeetingTabState();
}

class _MeetingTabState extends State<MeetingTab> {
  MeetingConfig _meetingConfig;
  UserMeetingPreference _preference;
  MeetingBloc _bloc;
  List<MeetingInterest> _interests;
  List<MeetingObjective> _objectives;
  Completer<void> _completer;

  @override
  void initState() {
    _completer = Completer<void>();
    _bloc = BlocProvider.of<MeetingBloc>(context)
      ..add(const GetMeetingConfigStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        AppLocalizations.of(context).translate("meeting:title");
    final String subtitle =
        AppLocalizations.of(context).translate("meeting:subtitle");
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: _blockListener,
      builder: (context, state) {
        return HomeTabLayout(
          heading: title,
          subheading: subtitle,
          onRefresh: _onRefreshTab,
          slivers: [
            if (_meetingConfig != null &&
                _meetingConfig.isRegistrationOpen &&
                _preference.pk == null)
              _buildEmptyState(_meetingConfig)
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(MeetingConfig meeting) {
    final formatDate = DateFormat('MMMM d');
    final date = DateTime.parse(meeting.weekStartDate);

    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            width: 140,
            image: AssetImage('assets/images/img_empty_meetings.png'),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppInsets.med),
          SizedBox(
            width: 300,
            child: Text(
              'You have not signed up for a meeting for the week of ${formatDate.format(date)}. Click here to register.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(height: AppInsets.med),
          RaisedButton(
            onPressed: _onPressRegisterMeets,
            child: const Text('Register Now'),
          )
        ],
      ),
    );
  }

  void _onPressRegisterMeets() {
    Navigator.of(context).push(RegisterMeetOverlay(
      meeting: _meetingConfig,
      preference: _preference,
      objectives: _objectives,
      interests: _interests,
    ));
  }

  void _blockListener(BuildContext context, state) {
    if (state is GetMeetingConfigLoaded) {
      _completer.complete();
      _completer = Completer<void>();
      setState(() {
        _meetingConfig = state.meeting;
        _preference = state.preferences;
        _interests = state.interests;
        _objectives = state.objectives;
      });
    }
  }

  Future<void> _onRefreshTab() {
    _bloc.add(const GetMeetingConfigStarted());
    return _completer.future;
  }
}
