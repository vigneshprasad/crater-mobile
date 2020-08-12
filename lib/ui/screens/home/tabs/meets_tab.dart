import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/blocs/meeting/bloc/meeting_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/models/meeting/meeting_model.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/ui/modals/register_meet/register_meet.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class MeetsTab extends StatefulWidget {
  @override
  _MeetsTabState createState() => _MeetsTabState();
}

class _MeetsTabState extends State<MeetsTab> {
  MeetingBloc _meetingBloc;
  final bool _showForm = false;

  @override
  void initState() {
    _meetingBloc = BlocProvider.of<MeetingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: _meetingBlocListener,
      builder: _meetsTabBuilder,
    );
  }

  void _meetingBlocListener(BuildContext context, MeetingState state) {
    if (state is MeetingGetSucess) {
      setState(() {});
    }
  }

  Widget _meetsTabBuilder(BuildContext context, MeetingState state) {
    final String title =
        AppLocalizations.of(context).translate("meeting:title");
    final String subtitle =
        AppLocalizations.of(context).translate("meeting:subtitle");
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: AppInsets.xl,
            right: AppInsets.med,
          ),
          child: TabHeader(
            heading: title,
            subHeading: subtitle,
          ),
        ),
        if (!_showForm && state is MeetingGetSucess)
          _buildEmptyState(state.meeting),
      ],
    );
  }

  Widget _buildEmptyState(Meeting meeting) {
    if (meeting.pk != null) {
      final formatDate = DateFormat('MMMM d');
      final date = DateTime.parse(meeting.weekStartDate);

      return Expanded(
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
    return Container();
  }

  void _onPressRegisterMeets() {
    Navigator.of(context).push(RegisterMeetOverlay(meetingBloc: _meetingBloc));
  }
}
