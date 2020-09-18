import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/base_error_text/base_error_text.dart';

typedef LabelGetterFunc<T> = String Function(T item);
typedef OnChangeItems<T> = void Function(List<T> items);

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final LabelGetterFunc<T> labelGetter;
  final OnChangeItems<T> onChangeItems;
  final int maxLength;
  final bool error;
  final String label;
  final List<T> initialValue;

  const MultiSelectDropdown({
    Key key,
    this.maxLength,
    this.error = false,
    this.initialValue = const [],
    @required this.label,
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
    _selectedItems = widget.initialValue;
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
    final border = widget.error
        ? Border.all(width: 2, color: Theme.of(context).errorColor)
        : null;
    return Container(
      height: kMinInteractiveDimension,
      decoration: BoxDecoration(
        border: border,
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
        ],
      ),
    );
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

class MultiSelectDropdownFormField<T> extends FormField<List<T>> {
  final List<T> items;
  final LabelGetterFunc<T> labelGetter;
  final OnChangeItems<T> onChangeItems;
  final int maxLength;
  final String label;

  MultiSelectDropdownFormField({
    List<T> initialValue = const [],
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    bool autovalidate = false,
    this.items,
    this.labelGetter,
    this.onChangeItems,
    this.maxLength,
    this.label,
  }) : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MultiSelectDropdown<T>(
                    initialValue: initialValue,
                    error: state.hasError,
                    items: items,
                    labelGetter: labelGetter,
                    label: label,
                    maxLength: maxLength,
                    onChangeItems: (items) {
                      state.didChange(items);
                      onChangeItems(items);
                    },
                  ),
                  if (state.hasError) const SizedBox(height: AppInsets.med),
                  if (state.hasError) BaseErrorText(text: state.errorText)
                ],
              );
            });
}
