import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

typedef LabelGetterFunc<T> = String Function(T item);
typedef OnChangeItems<T> = void Function(List<T> items);

class MultiSelectDropdown<T> extends StatefulWidget {
  final String error;
  final List<T> items;
  final LabelGetterFunc<T> labelGetter;
  final OnChangeItems<T> onChangeItems;
  final int maxLength;
  final bool validate;
  final String label;

  const MultiSelectDropdown({
    Key key,
    this.maxLength,
    @required this.label,
    this.error,
    this.validate,
    @required this.items,
    @required this.labelGetter,
    @required this.onChangeItems,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState<T> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  List<T> _selectedItems;
  List<DropdownMenuItem<T>> _items;

  @override
  void initState() {
    _selectedItems = [];
    _items = _buildItems(widget.items);
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
    final labelStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 15, color: Colors.grey[500]);
    final errorStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 13, color: Colors.red[700]);
    return Container(
      height: kMinInteractiveDimension,
      decoration: BoxDecoration(
        border: _getBorder(),
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
      ),
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              padding:
                  const EdgeInsets.only(left: AppInsets.l, right: AppInsets.l),
              alignedDropdown: true,
              child: DropdownButton<T>(
                isExpanded: true,
                items: _items,
                onChanged: widget.maxLength != null
                    ? (_selectedItems.length >= widget.maxLength
                        ? null
                        : _onChangedDropdownValue)
                    : _onChangedDropdownValue,
              ),
            ),
          ),
          if (_selectedItems.isEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: AppInsets.xl),
                child: Text(
                  widget.label,
                  style: labelStyle,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
            child: Row(
              children: _selectedItems
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(right: AppInsets.med),
                      child: Chip(
                        label: Text(widget.labelGetter(item)),
                        deleteIconColor: Theme.of(context).primaryColor,
                        onDeleted: () {
                          _onDeleteChip(item);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (widget.error != null && widget.validate && _selectedItems.isEmpty)
            Positioned(
              left: AppInsets.xl,
              bottom: -20,
              child: Text(
                widget.error,
                style: errorStyle,
              ),
            )
        ],
      ),
    );
  }

  Border _getBorder() {
    if (widget.error != null && widget.validate && _selectedItems.isEmpty) {
      return Border.all(
        color: Colors.red[700],
      );
    } else {
      return null;
    }
  }

  void _onDeleteChip(T item) {
    setState(() {
      _selectedItems = (_selectedItems..remove(item));
      _items = _updatedDropdownItems(_selectedItems);
    });
    widget.onChangeItems(_selectedItems);
  }

  void _onChangedDropdownValue(T value) {
    setState(() {
      _selectedItems = (_selectedItems..add(value));
      _items = _updatedDropdownItems(_selectedItems);
    });
    widget.onChangeItems(_selectedItems);
  }

  List<DropdownMenuItem<T>> _updatedDropdownItems(List<T> selectedItems) {
    final updated = [...widget.items];
    if (selectedItems.isNotEmpty) {
      updated.removeWhere((element) => selectedItems.contains(element));
    }
    return _buildItems(updated);
  }

  @override
  void didUpdateWidget(MultiSelectDropdown<T> oldWidget) {
    if (oldWidget.items != widget.items) {
      setState(() {
        _selectedItems = [];
        _items = _buildItems(widget.items);
      });
    }
    super.didUpdateWidget(oldWidget);
  }
}
