import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/theme.dart';
import '../../domain/entity/user_objective_entity.dart';

typedef ObjectiveCellCallback = void Function(
  UserObjective item,
  bool isSelected,
);

class ObjectiveCell extends StatefulWidget {
  final UserObjective item;
  final ObjectiveCellCallback onPressedItem;

  const ObjectiveCell({
    Key key,
    @required this.item,
    @required this.onPressedItem,
  })  : assert(item != null),
        assert(onPressedItem != null),
        super(key: key);

  @override
  _ObjectiveCellState createState() => _ObjectiveCellState();
}

class _ObjectiveCellState extends State<ObjectiveCell> {
  bool isSelected;

  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unselectedColor = Colors.grey[200];
    final selectedColor = Theme.of(context).primaryColor;
    final backgroundColor = isSelected ? selectedColor : unselectedColor;
    const borderRadius = BorderRadius.all(Radius.circular(12.0));
    final iconColor = isSelected ? Colors.white : selectedColor;
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          height: 1.2,
          color: isSelected ? Colors.white : Colors.grey[800],
        );
    return Container(
      margin: const EdgeInsets.all(AppInsets.med),
      height: 96,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
          boxShadow: kElevationToShadow[2],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
              widget.onPressedItem(widget.item, isSelected);
            },
            borderRadius: borderRadius,
            splashColor: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppInsets.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.item.icon != null)
                    SvgPicture.network(
                      widget.item.icon,
                      color: iconColor,
                      height: 28,
                    ),
                  const SizedBox(height: AppInsets.med),
                  Text(
                    widget.item.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: labelStyle,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
