import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

typedef LabelGetterFunc<T> = String Function(T item);

class BaseDropdown<T> extends StatefulWidget {
  final List<T> listItems;
  final T? value;
  final LabelGetterFunc<T> labelGetter;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final FormFieldValidator<T>? validator;

  const BaseDropdown({
    Key? key,
    this.value,
    this.onChanged,
    this.placeholder,
    this.validator,
    required this.labelGetter,
    required this.listItems,
  }) : super(key: key);

  @override
  _BaseDropdownState<T> createState() => _BaseDropdownState<T>();
}

class _BaseDropdownState<T> extends State<BaseDropdown<T>> {
  List<DropdownMenuItem<T>>? _dropdownMenuItems;

  @override
  void initState() {
    _dropdownMenuItems = _buildItems(widget.listItems);
    super.initState();
  }

  List<DropdownMenuItem<T>> _buildItems(List<T> items) {
    return items
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(widget.labelGetter(item)),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;
    final borderRadius = BorderRadius.circular(AppBorderRadius.textInput);
    return ButtonTheme(
      padding: const EdgeInsets.only(left: AppInsets.l, right: AppInsets.l),
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        hint: widget.placeholder != null
            ? Text(
                widget.placeholder ?? '',
                style: textStyle?.copyWith(color: Colors.grey[500]),
              )
            : null,
        style: textStyle,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppInsets.l,
            horizontal: AppInsets.sm,
          ),
          isDense: true,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              width: 2,
              color: Colors.transparent,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
        isExpanded: true,
        value: widget.value,
        onChanged: widget.onChanged,
        items: _dropdownMenuItems,
        validator: widget.validator,
      ),
    );
  }
}
