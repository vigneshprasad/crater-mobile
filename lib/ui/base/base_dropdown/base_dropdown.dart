import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

typedef LabelGetterFunc<T> = String Function(T item);

class BaseDropdown<T> extends StatefulWidget {
  final List<T> listItems;
  final T value;
  final LabelGetterFunc<T> labelGetter;
  final ValueChanged<T> onChanged;

  const BaseDropdown({
    Key key,
    this.value,
    this.onChanged,
    @required this.labelGetter,
    @required this.listItems,
  }) : super(key: key);

  @override
  _BaseDropdownState<T> createState() => _BaseDropdownState<T>();
}

class _BaseDropdownState<T> extends State<BaseDropdown<T>> {
  List<DropdownMenuItem<T>> _dropdownMenuItems;

  @override
  void initState() {
    _dropdownMenuItems = _buildItems(widget.listItems);
    super.initState();
  }

  List<DropdownMenuItem<T>> _buildItems(List<T> items) {
    return items
        .map((item) => DropdownMenuItem(
              value: item,
              child: Text(widget.labelGetter(item)),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          padding: const EdgeInsets.only(left: AppInsets.l, right: AppInsets.l),
          alignedDropdown: true,
          child: DropdownButton<T>(
            isExpanded: true,
            value: widget.value,
            onChanged: widget.onChanged,
            items: _dropdownMenuItems,
          ),
        ),
      ),
    );
  }
}
