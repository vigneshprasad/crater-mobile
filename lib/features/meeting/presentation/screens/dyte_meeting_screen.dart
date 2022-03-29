import 'package:auto_route/auto_route.dart';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_screen.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen_state.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class DyteMeetingScreen extends HookWidget {
  final int meetingId;
  const DyteMeetingScreen({Key? key, required this.meetingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileState = useProvider(getDyteCredsNotifierProvider(meetingId));

    final meetingHandler = useState<DyteMeetingHandler?>(null);

    final showChat = useState(true);
    final showReaction = useState(false);

    const videoHeight = 400.0;
    final fullHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final isOngoingMeeting = useState(false);

    final config = useState<Map<String, dynamic>>({
      'header': false,
      'controlBarElements': {
        'plugins': false,
        'participants': false,
        'chat': false,
        'polls': false,
      },
    });

    useEffect(() {
      return () {
        meetingHandler.value?.events.clear();
        meetingHandler.value?.events.removeAllByEvent('meetingEnd');
        // meetingHandler.value = null;
        meetingHandler.dispose();
      };
    }, []);

    return WillPopScope(
      onWillPop: () async {
        return isOngoingMeeting.value == false;
      },
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: profileState.when(
            data: (state) => SafeArea(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          key: Key(meetingId.toString()),
                          // constraints: BoxConstraints.expand(
                          height: showChat.value ? videoHeight : fullHeight,
                          width: double.infinity,
                          child: DyteMeeting(
                            roomName: state.room,
                            authToken: state.token,
                            uiConfig: config.value,
                            onInit: (DyteMeetingHandler handler) async {
                              meetingHandler.value = handler;

                              handler.events.on('meetingJoin', context,
                                  (ev, c) {
                                isOngoingMeeting.value = true;
                                Future.delayed(
                                        const Duration(milliseconds: 500))
                                    .then((value) {
                                  showChat.value = true;

                                  final analytics =
                                      KiwiContainer().resolve<Analytics>();
                                  analytics.trackEvent(
                                      eventName: AnalyticsEvents.joinStream,
                                      properties: {
                                        "id": meetingId,
                                      });
                                });
                              });

                              handler.events.on('meetingEnd', context, (ev, c) {
                                isOngoingMeeting.value = false;
                                AutoRouter.of(context).pop();
                              });

                              handler.events.on('meetingDisconnected', this,
                                  (ev, cont) {
                                isOngoingMeeting.value = false;
                                AutoRouter.of(context).pop();
                              });

                              showChat.value = false;
                            },
                          )),
                      SizedBox(
                        height: showChat.value ? videoHeight : fullHeight,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6, right: 4),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  final height = showChat.value == false
                                      ? videoHeight
                                      : fullHeight;
                                  meetingHandler.value?.updateUIConfig({
                                    'dimensions': {'height': height}
                                  });

                                  showChat.value = !showChat.value;
                                },
                                icon: Icon(showChat.value
                                    ? Icons.fullscreen
                                    : Icons.chat_bubble)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: showChat.value ? fullHeight - videoHeight : 0,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ChatScreen(
                              recieverId: '',
                              groupId: meetingId.toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: AnimatedContainer(
                  //     duration: const Duration(milliseconds: 300),
                  //     height: 100,
                  //     width: 100,
                  //     child: Image.network(
                  //         'https://penitence-pre-prod.vercel.app/_next/image?url=https%3A%2F%2F1worknetwork-pre.s3.amazonaws.com%2Fmedia%2Freactions%2Ficons%2Fthe-simpsons-bart-simpson.gif&w=3840&q=75'),
                  //   ),
                  // )
                ],
              ),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
          )),
    );
  }
}
