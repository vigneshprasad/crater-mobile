import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/roundtable/domain/entity/roundtable_entity/roundtable_entity.dart';

final groupOverlayControllerProvider =
    Provider((_) => GroupOverlayController());

class GroupOverlayController {
  OverlayEntry _entry;
  RoundTable _roundTable;

  void createOverlayEntry(
      BuildContext context, OverlayEntry entry, RoundTable table) {
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
  RoundTable get table => _roundTable;
}
