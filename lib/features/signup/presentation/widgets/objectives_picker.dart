import 'package:flutter/material.dart';
import 'package:worknetwork/features/signup/domain/entity/user_objective_entity.dart';

import 'objective_cell.dart';

class ObjectivesPicker extends StatelessWidget {
  final List<UserObjective> objectives;
  final ObjectiveCellCallback onPressedItem;

  const ObjectivesPicker({
    Key key,
    @required this.objectives,
    @required this.onPressedItem,
  })  : assert(objectives != null),
        assert(onPressedItem != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<List<UserObjective>> rows = objectives.fold(
      [[]],
      (list, objective) => list.last.length == 3
          ? (list..add([objective]))
          : (list..last.add(objective)),
    );

    rows.map((row) {
      if (row.length < 3) {
        final filler = List(3 - row.length);
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
