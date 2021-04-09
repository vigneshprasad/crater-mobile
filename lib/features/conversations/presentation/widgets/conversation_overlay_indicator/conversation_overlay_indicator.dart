import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../routes.gr.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../screens/conversation_screen/conversation_screen_controller.dart';

class ConversationOverlayIndicator extends HookWidget {
  final Conversation table;

  const ConversationOverlayIndicator({@required this.table});

  @override
  Widget build(BuildContext context) {
    const radius = 30.0;
    const width = radius * 2;
    final controller = useProvider(conversationScreenControllerProvider(table));
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
                      ExtendedNavigator.of(context)
                          .push(Routes.conversationScreen(id: table.id));
                    },
                    borderRadius: BorderRadius.circular(radius),
                    child: const SizedBox(
                        width: width,
                        height: width,
                        child: Icon(Icons.mic, color: Colors.white))))));
  }
}
