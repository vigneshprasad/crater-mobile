import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class ClubsScreen extends HookWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
            child: DyteMeeting(
              roomName: '',
              authToken: '',
              onInit: (DyteMeetingHandler meeting) async {
                meeting.events.on('meetingEnd', context, (ev, c) {
                  // AutoRouter.of(context).pop();
                });
              },
            ),
          ) 
    );
  }
}
