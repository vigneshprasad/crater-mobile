import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../routes.gr.dart';
import '../../screens/conversation_screen_2/conversation_screen_state.dart';

class ConversationOverlayIndicator extends HookWidget {
  final int tableId;

  const ConversationOverlayIndicator({required this.tableId});

  @override
  Widget build(BuildContext context) {
    const radius = 30.0;
    const width = radius * 2;
    // WORKAROUND: Keeping these providers live so that call is not disconnected.
    // ignore: unused_local_variable
    final conversationController =
        useProvider(conversationStateProvider(tableId));
    // ignore: unused_local_variable
    final speakersController = useProvider(conversationSpeakersState(tableId));
    // ignore: unused_local_variable
    final rtcController = useProvider(rtcConnectionProvider(tableId));
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 10,
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                child: InkWell(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(ConversationScreenRoute(id: tableId));
                    },
                    borderRadius: BorderRadius.circular(radius),
                    child: const SizedBox(
                        width: width,
                        height: width,
                        child: Icon(Icons.mic, color: Colors.white))))));
  }
}
