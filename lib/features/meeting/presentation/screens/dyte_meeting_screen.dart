import 'package:auto_route/auto_route.dart';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen_state.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class DyteMeetingScreen extends HookWidget {
  final int meetingId;
  const DyteMeetingScreen({Key? key, required this.meetingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getDyteCredsNotifierProvider(meetingId));

    return profileState.when(
      data: (state) => Scaffold(
          appBar: BaseAppBar(),
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SizedBox(
            child: DyteMeeting(
              roomName: state.room,
              authToken: state.token,
              onInit: (DyteMeetingHandler meeting) async {
                meeting.events.on('meetingEnd', context, (ev, c) {
                  AutoRouter.of(context).pop();
                });
              },
            ),
          )),
      loading: () => Scaffold(
        appBar: BaseAppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: const [
                LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
