import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/theme.dart';
import 'objectives_picker.dart';

typedef ObjectiveCellCallback = void Function(
  PickerItem item,
  bool isSelected,
);

class ObjectiveCell extends StatefulWidget {
  final PickerItem item;
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unselectedColor = Colors.grey[200];
    final selectedColor = Theme.of(context).primaryColor;
    final backgroundColor =
        widget.item.selected ? selectedColor : unselectedColor;
    const borderRadius = BorderRadius.all(Radius.circular(12.0));
    final iconColor = widget.item.selected ? Colors.white : selectedColor;
    return Container(
      margin: const EdgeInsets.all(AppInsets.med),
      height: 50,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: backgroundColor),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: () {
              widget.onPressedItem(widget.item, !widget.item.selected);
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
                  Text(
                    widget.item.name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
