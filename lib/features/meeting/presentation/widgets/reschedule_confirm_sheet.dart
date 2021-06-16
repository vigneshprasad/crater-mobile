import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_bottom_sheet/base_bottom_sheet.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../domain/entity/meeting_entity.dart';
import '../../domain/entity/reschedule_request_entity.dart';
import '../bloc/meeting_bloc.dart';
import 'reschedule_slot_picker.dart';

class RescheduleConfirmSheet extends StatefulWidget {
  final Meeting meeting;

  const RescheduleConfirmSheet({
    Key key,
    @required this.meeting,
  }) : super(key: key);

  @override
  _RescheduleConfirmSheetState createState() => _RescheduleConfirmSheetState();
}

class _RescheduleConfirmSheetState extends State<RescheduleConfirmSheet> {
  MeetingBloc _bloc;
  bool _loading;
  RescheduleRequest _request;
  DateTime _selectedSlot;

  @override
  void initState() {
    _bloc = BlocProvider.of<MeetingBloc>(context);
    _bloc.add(GetRescheduleRequestStarted(meetingId: widget.meeting.pk));
    _loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        );
    return BlocListener<MeetingBloc, MeetingState>(
      listener: _blocListener,
      child: BaseBottomSheet(
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xl),
            Text(
              'Pick a time slot suitable for you',
              style: headingStyle,
            ),
            const SizedBox(height: AppInsets.xxl),
            if (_loading)
              const SizedBox(
                height: 240,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!_loading)
              RescheduleSlotPicker(
                timeSlots: _request.timeSlots,
                disabled: _loading,
                onValueChanged: (value) {
                  setState(() {
                    _selectedSlot = value;
                  });
                },
              ),
            const SizedBox(height: AppInsets.xxl),
            BaseLargeButton(
              text: "Submit",
              onPressed: _selectedSlot != null
                  ? () {
                      _bloc.add(PostConfirmRescheduleRequestStarted(
                        rescheduleRequest: _request.id,
                        timeSlot: _selectedSlot,
                      ));
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, MeetingState state) {
    if (state is GetMeetingRescheduleRequestLoaded) {
      setState(() {
        _request = state.response;
        _loading = false;
      });
    } else if (state is PostConfirmRescheduleRequestLoaded) {
      Navigator.of(context).pop(true);
    }
  }
}
