import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/core/widgets/screens/models/home_screen_tab_model.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../../../../utils/app_localizations.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'meeting_preferences_card.dart';
import 'register_meet.dart';

class MeetingTab extends HomeScreenTab {
  @override
  _MeetingTabState createState() => _MeetingTabState();

  @override
  double get expandedHeight => 116;

  @override
  String get headingKey => "meeting:title";

  @override
  String get subheadingKey => "meeting:subtitle";
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
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: _blockListener,
      builder: (context, state) {
        return HomeTabLayout(
          onRefresh: _onRefreshTab,
          slivers: [
            if (_meetingConfig != null &&
                _meetingConfig.isRegistrationOpen &&
                _preference.pk == null)
              _buildEmptyState(_meetingConfig)
            else if (_meetingConfig != null && _preference.pk != null)
              _buildPreferencesCard(context)
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

  Widget _buildPreferencesCard(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.med),
      sliver: SliverToBoxAdapter(
        child: MeetingPreferencesCard(
          preference: _preference,
          meetingConfig: _meetingConfig,
          objectives: _objectives,
          interests: _interests,
          onTapCard: _onPressRegisterMeets,
        ),
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
    } else if (state is PostMeetingPreferencesLoaded) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text("Meeting Preferences updated"),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _preference = state.preferences;
      });
    } else if (state is PostUserProfileResponseLoaded) {
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUserProfileUpdateRecieved(profile: state.profile));
    }
  }

  Future<void> _onRefreshTab() {
    _bloc.add(const GetMeetingConfigStarted());
    return _completer.future;
  }
}
