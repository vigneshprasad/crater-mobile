import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../routes.gr.dart';
import '../../screens/conversation_screen_2/conversation_screen_state.dart';

class ConversationOverlayIndicator extends HookWidget {
  final int tableId;

  const ConversationOverlayIndicator({@required this.tableId});

  @override
  Widget build(BuildContext context) {
    const radius = 30.0;
    const width = radius * 2;
    final conversationController =
        useProvider(conversationStateProvider(tableId));
    final speakersController = useProvider(conversationSpeakersState(tableId));
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
                          .push(Routes.conversationScreen(id: tableId));
                    },
                    borderRadius: BorderRadius.circular(radius),
                    child: const SizedBox(
                        width: width,
                        height: width,
                        child: Icon(Icons.mic, color: Colors.white))))));
  }
}
