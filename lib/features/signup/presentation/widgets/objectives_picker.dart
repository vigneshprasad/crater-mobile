import 'package:flutter/material.dart';

import 'objective_cell.dart';

class PickerItem {
  final String name;
  final String? icon;
  final bool selected;

  PickerItem({required this.name, this.icon, this.selected = false});
}

class ObjectivesPicker extends StatelessWidget {
  final List<PickerItem> objectives;
  final ObjectiveCellCallback onPressedItem;
  static const column = 2;

  const ObjectivesPicker({
    Key? key,
    required this.objectives,
    required this.onPressedItem,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<List<PickerItem?>> rows = objectives.fold(
      [[]],
      (list, objective) => list.last.length == column
          ? (list..add([objective]))
          : (list..last.add(objective)),
    );

    rows.map((row) {
      if (row.length < column) {
        final filler = List.filled(column - row.length, 0);
        row.addAll(filler.map((e) => null));
      }
    }).toList();

    return Table(
      children: rows
          .map((row) => TableRow(
                children: row
                    .map(
                      (col) => col != null
                          ? ObjectiveCell(
                              item: col,
                              onPressedItem: (item, isSelected) {
                                onPressedItem(item, isSelected);
                              },
                            )
                          : Container(),
                    )
                    .toList(),
              ))
          .toList(),
    );
  }
}
