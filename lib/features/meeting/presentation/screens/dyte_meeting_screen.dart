import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  DyteMeetingScreen({Key? key, required this.meetingId}) : super(key: key);

  bool showChat = true;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    final profileState = useProvider(getDyteCredsNotifierProvider(meetingId));

    final meetingHandler = useState<DyteMeetingHandler?>(null);

    // final showChat = useState(true);
    // final showReaction = useState(false);

    final videoHeight = min(size.width, size.height);
    final videoWidth = MediaQuery.of(context).size.width;

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
      'dimensions': {
        'height': videoHeight,
        'width': videoWidth,
        // 'mode': 'fillParent',
      },
    });

    Future<void> toggleChat() async {
      showChat = !showChat;

      final videoWidth = size.height;
      meetingHandler.value?.updateUIConfig({
        'dimensions': {
          'height': videoHeight,
          'width': videoWidth,
          // 'mode': 'fillParent',
        }
      });

      await SystemChrome.setPreferredOrientations([
        if (showChat == false)
          DeviceOrientation.landscapeLeft
        else
          DeviceOrientation.portraitUp,
      ]);
    }

    useEffect(() {
      return () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        meetingHandler.value?.events.clear();
        meetingHandler.value?.events.removeAllByEvent('meetingJoin');
        meetingHandler.value?.events.removeAllByEvent('meetingDisconnected');
        meetingHandler.value?.events.removeAllByEvent('meetingEnd');
        // meetingHandler.value = null;
        meetingHandler.dispose();
      };
    }, []);

    return WillPopScope(
      onWillPop: () async {
        return true; // isOngoingMeeting.value == false;
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
                          // key: Key(meetingId.toString()),
                          // constraints: BoxConstraints.expand(
                          height: videoHeight,
                          width: videoWidth,
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
                                  // showChat.value = true;

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

                              // showChat.value = false;
                            },
                          )),
                      SizedBox(
                        height: videoHeight,
                        width: videoWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, left: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: () {
                                  isOngoingMeeting.value = false;
                                  AutoRouter.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: videoHeight,
                        width: videoWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: toggleChat,
                                icon: Icon(
                                  showChat
                                      ? Icons.fullscreen
                                      : Icons.fullscreen_exit,
                                  size: 18,
                                )),
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
                        height: showChat ? fullHeight - videoHeight : 0,
                        width: videoWidth,
                        child: Stack(
                          children: [
                            ChatScreen(
                              recieverId: '',
                              groupId: meetingId.toString(),
                              allowChat: state.allowChat,
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
