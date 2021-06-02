import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/features/popup_manager/popup_manager.dart';
import '../../../../../core/widgets/base/base_container/base_container.dart';
import '../../../../../routes.gr.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../screens/conversation_screen_2/conversation_screen_state.dart';

const kconnectionBarHeight = 48.00;
const kbarBorderRadius = Radius.circular(24.0);
const kconnectionIndicatorSize = 12.00;

class RtcConnectionBar extends HookWidget {
  final Conversation table;
  final RtcConnection connection;

  const RtcConnectionBar({
    Key key,
    this.connection,
    @required this.table,
  }) : super(key: key);

  void _leaveRoundTableChannel(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Leave RoundTable"),
          content: Text("Confirm to leave the roundtable discussion."),
          actions: [
            BaseContainer(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
              ),
            ),
            const SizedBox(width: 4),
            BaseContainer(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () async {
                    context
                        .read(conversationStateProvider(table.id))
                        .leaveAudioCall();
                    // controller.leaveRoundTableChannel();

                    // final popupManager = context.read(popupManagerProvider);
                    // await popupManager.showPopup(
                    //     PopupType.conversationLeave, context);
                    // Navigator.pop(context);

                    ExtendedNavigator.of(context).pushAndRemoveUntil(
                      Routes.onboardingScreen(
                          type: OnboardingType.meetingLeaving.toString()),
                      (_) => false,
                    );
                  },
                  child: const Text(
                    'LEAVE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getLabel(RtcConnection state) {
    switch (state) {
      case RtcConnection.connected:
        return "Connected";
      case RtcConnection.connecting:
        return "Connecting...";
      case RtcConnection.disconnected:
        return "Disconnected";
      default:
        return "Connecting...";
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    final localUser =
        useProvider(conversationSpeakersState(table.id)).localUser;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: kconnectionBarHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: kbarBorderRadius,
          topRight: kbarBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.xxl),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatusIndicator(state: connection),
            const SizedBox(width: AppInsets.med),
            Text(getLabel(connection), style: textStyle),
            const Spacer(),
            if (connection != RtcConnection.connected)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 3.0),
              ),
            if (connection == RtcConnection.connected)
              BaseContainer(
                radius: 22,
                child: _MicrophoneButton(
                  muted: localUser.muted,
                  onPressed: () {
                    context
                        .read(conversationStateProvider(table.id))
                        .muteLocalAudio(muted: !localUser.muted);
                  },
                ),
              ),
            if (connection == RtcConnection.connected)
              const SizedBox(width: AppInsets.xxl),
            if (connection == RtcConnection.connected)
              BaseContainer(
                radius: 22,
                child: _LeaveButton(onPressed: () {
                  _leaveRoundTableChannel(context);
                }),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final RtcConnection state;

  const _StatusIndicator({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getIndicatorColor(state);

    return Container(
      width: kconnectionIndicatorSize,
      height: kconnectionIndicatorSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  MaterialColor getIndicatorColor(RtcConnection state) {
    switch (state) {
      case RtcConnection.connected:
        return Colors.green;
      case RtcConnection.connecting:
        return Colors.orange;
      case RtcConnection.disconnected:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}

class _MicrophoneButton extends StatelessWidget {
  final bool muted;
  final VoidCallback onPressed;

  const _MicrophoneButton({
    Key key,
    @required this.muted,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = muted ? Colors.red : Colors.green;
    final icon = muted ? Icons.mic_off : Icons.mic;
    return Material(
      shape: const CircleBorder(),
      color: color,
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: color[600],
        highlightColor: color.withOpacity(0.4),
        onTap: onPressed,
        child: SizedBox(
          height: 44,
          width: 44,
          child: Center(
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _LeaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LeaveButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Colors.grey[300],
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          height: 44,
          width: 44,
          child: Center(
            child: Icon(Icons.exit_to_app, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
