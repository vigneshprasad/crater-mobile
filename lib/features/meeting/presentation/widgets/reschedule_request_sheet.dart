import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_bottom_sheet/base_bottom_sheet.dart';
import '../../../../core/widgets/base/base_date_time_picker/base_date_time_picker.dart.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/meeting_entity.dart';
import '../bloc/meeting_bloc.dart';

class RescheduleRequestSheet extends StatefulWidget {
  final Meeting meeting;

  const RescheduleRequestSheet({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  _RescheduleRequestSheetState createState() => _RescheduleRequestSheetState();
}

class _RescheduleRequestSheetState extends State<RescheduleRequestSheet> {
  late MeetingBloc _bloc;
  List<List<DateTime>>? _rescheduleSlots;
  List<DateTime> _selectedSlots = [];
  late bool _loading;
  bool _enableButton = false;

  @override
  void initState() {
    _bloc = BlocProvider.of<MeetingBloc>(context);
    _bloc.add(const GetMeetingRescheduleSlotsStarted());
    _loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        );
    final heading = AppLocalizations.of(context)
        ?.translate("meeting_reschedule:request_heading");
    return BlocListener<MeetingBloc, MeetingState>(
      listener: _blocListener,
      child: BaseBottomSheet(
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.xl),
              child: Text(
                heading!,
                style: headingStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppInsets.xl),
            if (!_loading)
              BaseDateTimePicker<DateTime>(
                initialValue: _selectedSlots,
                timeSlots: _rescheduleSlots ?? [],
                getDateTime: (obj) => obj,
                maxLength: 3,
                onValueChanged: (value) {
                  setState(() {
                    if (value.length == 3) {
                      _enableButton = true;
                    } else {
                      _enableButton = false;
                    }
                    _selectedSlots = value;
                  });
                },
              ),
            const SizedBox(height: AppInsets.xxl),
            BaseLargeButton(
              text: 'Submit',
              onPressed: _enableButton
                  ? () {
                      _onSubmitPressed(context);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmitPressed(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).state.user;
    if (user == null) {
      return;
    }
    _bloc.add(PostMeetingRescheduleRsvpStarted(
      oldMeeting: widget.meeting.pk!,
      requestedBy: user.pk!,
      timeSlots: _selectedSlots,
    ));
  }

  void _blocListener(BuildContext context, MeetingState state) {
    if (state is GetMeetingRescheduleSlotsLoaded) {
      setState(() {
        _rescheduleSlots = state.timeslots;
        _loading = false;
      });
    } else if (state is GetMeetingRescheduleSlotsError) {
      setState(() {
        _loading = false;
      });
    } else if (state is PostMeetingRecheduleRsvpLoaded) {
      Navigator.of(context).pop();
    }
  }
}
