import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worknetwork/features/meeting/data/repository/meeting_respository_impl.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_bottom_sheet/base_bottom_sheet.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../domain/entity/meeting_request_entity.dart';
import 'reschedule_slot_picker.dart';

class MeetingRequestConfirmSheet extends HookWidget {
  final MeetingRequest meeting;

  const MeetingRequestConfirmSheet({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline5?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        );

    final _selectedSlot = useState<DateTime?>(null);
    return BaseBottomSheet(
      child: Column(
        children: [
          const SizedBox(height: AppInsets.xl),
          Text(
            'Pick a time slot suitable for you',
            style: headingStyle,
          ),
          const SizedBox(height: AppInsets.xxl),
          RescheduleSlotPicker(
            timeSlots: meeting.timeSlots!,
            onValueChanged: (value) {
              _selectedSlot.value = value;
            },
          ),
          const SizedBox(height: AppInsets.xxl),
          BaseLargeButton(
            text: "Submit",
            onPressed: () => _submit(context, _selectedSlot.value),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context, DateTime? selectedSlot) async {
    if (selectedSlot == null) {
      return;
    }
    final response = await context
        .read(meetingRepositoryProvider)
        .postAcceptMeetingRequest(meeting.id!, selectedSlot);

    response.fold(
      (failure) {
        // _overlay.remove();
        Fluttertoast.showToast(msg: failure.toString());
      },
      (optin) async {
        // _overlay.remove();

        // final popupManager = context.read(popupManagerProvider);
        // await popupManager.showPopup(PopupType.conversationOptIn, context);

        Navigator.of(context).pop(true);
      },
    );
  }
}
