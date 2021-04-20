import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entity/conversation_entity/conversation_entity.dart';

final groupOverlayControllerProvider =
    Provider((_) => ConversationOverlayController());

class ConversationOverlayController {
  OverlayEntry _entry;
  Conversation _roundTable;

  void createOverlayEntry(
      BuildContext context, OverlayEntry entry, Conversation table) {
    removeOverlayEntry();

    _entry = entry;
    _roundTable = table;
    Overlay.of(context).insert(_entry);
  }

  void removeOverlayEntry() {
    _entry?.remove();
    _entry = null;
    _roundTable = null;
  }

  OverlayEntry get entry => _entry;
  Conversation get table => _roundTable;
}
