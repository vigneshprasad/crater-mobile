import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/widgets/base/base_container/base_container.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/features/popup_manager/popup_manager.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../screens/conversation_screen/conversation_screen_controller.dart';

const kconnectionBarHeight = 68.00;
const kbarBorderRadius = Radius.circular(24.0);
const kconnectionIndicatorSize = 12.00;

class RtcConnectionBar extends HookWidget {
  final Conversation table;
  final ConversationScreenController controller;

  const RtcConnectionBar({
    Key key,
    this.controller,
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
                  child: Text('CANCEL'),
                ),
              ),
            ),
            SizedBox(width: 4),
            BaseContainer(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () async {
                    controller.leaveRoundTableChannel();

                    final popupManager = context.read(popupManagerProvider);
                    await popupManager.showPopup(
                        PopupType.conversationLeave, context);

                    Navigator.pop(context);
                  },
                  child: Text(
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

  String getLabel(RtcConnectionState state) {
    switch (state) {
      case RtcConnectionState.connected:
        return "Connected";
      case RtcConnectionState.connecting:
        return "Connecting...";
      case RtcConnectionState.disconnected:
        return "DIsconnected";
      default:
        return "Connecting...";
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionState = controller.connectionState;
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Container(
      height: kconnectionBarHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.white,
        // boxShadow: kElevationToShadow[3],
        borderRadius: const BorderRadius.only(
          topLeft: kbarBorderRadius,
          topRight: kbarBorderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.xxl),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatusIndicator(state: connectionState),
            const SizedBox(width: AppInsets.med),
            Text(getLabel(connectionState), style: textStyle),
            const Spacer(),
            if (connectionState != RtcConnectionState.connected)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 3.0),
              ),
            if (connectionState == RtcConnectionState.connected)
              BaseContainer(
                radius: 22,
                child: _MicrophoneButton(
                  muted: controller.locaRtclUser.muted ?? false,
                  onPressed: () {
                    controller.muteLocalAudioStream(
                        muted: !controller.locaRtclUser.muted);
                  },
                ),
              ),
            if (connectionState == RtcConnectionState.connected)
              const SizedBox(width: AppInsets.xxl),
            if (connectionState == RtcConnectionState.connected)
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
  final RtcConnectionState state;

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

  MaterialColor getIndicatorColor(RtcConnectionState state) {
    switch (state) {
      case RtcConnectionState.connected:
        return Colors.green;
      case RtcConnectionState.connecting:
        return Colors.orange;
      case RtcConnectionState.disconnected:
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
