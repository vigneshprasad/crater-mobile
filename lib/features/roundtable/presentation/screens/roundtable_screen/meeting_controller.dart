import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupOverlayControllerProvider = Provider.autoDispose((_) {
  return GroupOverlayController();
});

class GroupOverlayController {
  OverlayEntry _entry;

  void createOverlayEntry(BuildContext context, OverlayEntry entry) {
    removeOverlayEntry();

    _entry = entry;
    Overlay.of(context).insert(_entry);
  }

  void removeOverlayEntry() {
    _entry?.remove();
    _entry = null;
  }

  OverlayEntry get entry => _entry;
}
