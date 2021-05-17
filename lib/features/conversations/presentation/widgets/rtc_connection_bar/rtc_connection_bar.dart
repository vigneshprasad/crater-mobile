import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/features/popup_manager/popup_manager.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../screens/conversation_screen_2/conversation_screen_state.dart';

const kconnectionBarHeight = 68.00;
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
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                context
                    .read(conversationStateProvider(table.id))
                    .leaveAudioCall();
                // controller.leaveRoundTableChannel();

                final popupManager = context.read(popupManagerProvider);
                await popupManager.showPopup(
                    PopupType.conversationLeave, context);

                Navigator.pop(context);
              },
              child: Text('LEAVE'),
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
    return Container(
      height: kconnectionBarHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kElevationToShadow[3],
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
              _MicrophoneButton(
                muted: false,
                onPressed: () {
                  // controller.muteLocalAudioStream(
                  //     muted: !controller.locaRtclUser.muted);
                },
              ),
            if (connection == RtcConnection.connected)
              const SizedBox(width: AppInsets.l),
            if (connection == RtcConnection.connected)
              _LeaveButton(onPressed: () {
                _leaveRoundTableChannel(context);
              }),
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
          height: 40,
          width: 40,
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
          height: 40,
          width: 40,
          child: Center(
            child: Icon(Icons.exit_to_app, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
