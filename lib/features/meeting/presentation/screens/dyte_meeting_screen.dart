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

    final meetingHandler = useState<DyteMeetingHandler?>(null);

    final canGoBack = useState(false);

    const uiConfig = {
      'header': false,
      'controlBarElements': {
        'plugins': false,
        'participants': false,
        'chat': false,
        'polls': false,
      },
    };

    useEffect(() {
      return () {
        meetingHandler.value?.events.clear();
        meetingHandler.value?.events.removeAllByEvent('meetingEnd');
        meetingHandler.value = null;
        meetingHandler.dispose();
      };
    }, []);

    return WillPopScope(
      onWillPop: () async {
        return canGoBack.value;
      },
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          // appBar: BaseAppBar(),
          body: profileState.when(
            data: (state) => SafeArea(
              child: DyteMeeting(
                roomName: state.room,
                authToken: state.token,
                uiConfig: uiConfig,
                onInit: (DyteMeetingHandler handler) async {
                  meetingHandler.value = handler;

                  handler.events.on('meetingEnd', context, (ev, c) {
                    canGoBack.value = true;
                    AutoRouter.of(context).pop();
                  });
                },
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
