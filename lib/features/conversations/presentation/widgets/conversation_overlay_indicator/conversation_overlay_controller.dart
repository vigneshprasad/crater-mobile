import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final conversationOverlayProvider =
    ChangeNotifierProvider((_) => ConversationOverlayController());

class ConversationOverlayController extends ChangeNotifier {
  OverlayEntry? _entry;
  int? _groupId;

  OverlayEntry? get entry => _entry;
  int? get groupId => _groupId;

  void createOverlayEntry(
      BuildContext context, OverlayEntry entry, int groupId) {
    removeOverlayEntry();

    _entry = entry;
    _groupId = groupId;
    notifyListeners();

    Overlay.of(context)?.insert(entry);
  }

  void removeOverlayEntry() {
    _entry?.remove();
    _entry = null;
    _groupId = null;
    notifyListeners();
  }
}
