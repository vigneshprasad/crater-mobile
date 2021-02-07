import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';
import '../../../../ui/base/base_error_text/base_error_text.dart';

const _kItemHeight = 44.00;
typedef LabelGetterFunc<T> = String Function(T item);

class BaseMultiSelectDropdown<T> extends StatefulWidget {
  final List<T> initalValue;
  final List<T> items;
  final ValueChanged<List<T>> onChanged;
  final String label;
  final LabelGetterFunc<T> labelGetter;
  final int maxLength;
  final bool error;
  final String errorText;

  const BaseMultiSelectDropdown({
    Key key,
    this.initalValue,
    this.label,
    this.maxLength = 2,
    this.error = false,
    this.errorText,
    @required this.items,
    @required this.onChanged,
    @required this.labelGetter,
  }) : super(key: key);

  @override
  _BaseMultiSelectDropdownState createState() =>
      _BaseMultiSelectDropdownState<T>();
}

class _BaseMultiSelectDropdownState<T> extends State<BaseMultiSelectDropdown<T>>
    with SingleTickerProviderStateMixin {
  List<T> _selected;
  OverlayEntry _overlayEntry;
  bool isOpen;
  AnimationController _controller;

  @override
  void initState() {
    isOpen = false;
    _selected = widget.initalValue ?? [];
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayMenu() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final fullHeight = MediaQuery.of(context).size.height;
    final maxHeight = fullHeight - (2 * _kItemHeight);
    final itemsHeight = widget.items.length * _kItemHeight + 16.00;
    final height = itemsHeight > maxHeight ? maxHeight : itemsHeight;
    double yPosition;

    if (offset.dy + height > fullHeight) {
      yPosition = offset.dy - (fullHeight - height);
    } else {
      yPosition = offset.dy;
    }

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _removeOverlay();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: yPosition,
              width: size.width,
              child: _DropdownMenu<T>(
                height: height,
                controller: _controller,
                items: _buildDropdownItems(),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildDropdownItems() {
    return widget.items.map((item) {
      final selected = _selected.contains(item);
      return _DropDownItem<T>(
        item: item,
        label: widget.labelGetter(item),
        selected: selected,
        onPressed: (value) {
          final selected = _selected.contains(item);
          setState(() {
            if (selected) {
              final updated = [..._selected];
              updated.remove(item);
              _selected = updated;
              widget.onChanged(_selected);
            } else {
              if (_selected.length < widget.maxLength ||
                  widget.maxLength == 0) {
                final updated = [..._selected];
                updated.add(item);
                _selected = updated;
                widget.onChanged(_selected);
              }
            }
            _overlayEntry?.markNeedsBuild();
          });
        },
      );
    }).toList();
  }

  void _onTapDropDown() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _insertOverlay());
      } else {
        _removeOverlay();
      }
    });
  }

  Future<void> _insertOverlay() async {
    setState(() {
      _overlayEntry = _createOverlayMenu();
    });
    Overlay.of(context).insert(_overlayEntry);
    await _controller.forward().orCancel;
  }

  Future<void> _removeOverlay() async {
    await _controller.reverse().orCancel;
    _overlayEntry?.remove();
    setState(() {
      _overlayEntry = null;
    });
  }

  Future<bool> _onBackButtonPressed() async {
    if (_overlayEntry != null) {
      await _removeOverlay();
      return false;
    } else {
      return true;
    }
  }

  Widget _buildSelectedChips() {
    final width = MediaQuery.of(context).size.width - 86;
    return SizedBox(
      width: width,
      child: Wrap(
        children: _selected
            .map((selected) => Padding(
                  padding: const EdgeInsets.only(right: AppInsets.med),
                  child: Chip(
                    label: Text(
                      widget.labelGetter(selected),
                      overflow: TextOverflow.ellipsis,
                    ),
                    deleteIconColor: Theme.of(context).primaryColor,
                    onDeleted: () {
                      setState(() {
                        _selected = _selected..remove(selected);
                      });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _labelStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 14,
          color: Colors.grey[600],
        );
    final _label = widget.label ?? "Select items";
    final border = widget.error
        ? Border.all(width: 2, color: Theme.of(context).errorColor)
        : null;
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: GestureDetector(
        onTap: _onTapDropDown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 48,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
                color: Colors.grey[200],
                border: border,
              ),
              padding: const EdgeInsets.only(
                left: AppInsets.xl,
                right: AppInsets.med,
                top: AppInsets.sm,
                bottom: AppInsets.sm,
              ),
              child: Row(
                children: [
                  if (_selected.isEmpty)
                    Text(
                      _label,
                      style: _labelStyle,
                    ),
                  if (_selected.isNotEmpty) _buildSelectedChips(),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            if (widget.error) const SizedBox(height: AppInsets.sm),
            if (widget.error && widget.errorText != null)
              BaseErrorText(text: widget.errorText),
          ],
        ),
      ),
    );
  }
}

class _DropdownMenu<T> extends StatelessWidget {
  final AnimationController controller;
  final List<Widget> items;
  final double height;

  const _DropdownMenu({
    Key key,
    @required this.items,
    @required this.controller,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<double> _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.ease,
        ),
      ),
    );
    final Animation<double> _height = Tween<double>(
      begin: 48.0,
      end: height,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.25,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Material(
          elevation: 8,
          child: Opacity(
            opacity: _opacity.value,
            child: SizedBox(
              height: _height.value,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
                children: items,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DropDownItem<T> extends StatelessWidget {
  final T item;
  final String label;
  final bool selected;
  final ValueChanged<T> onPressed;

  const _DropDownItem({
    Key key,
    @required this.item,
    @required this.label,
    @required this.selected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onPressed(item);
        },
        child: SizedBox(
          height: _kItemHeight,
          child: Row(
            children: [
              Checkbox(
                value: selected,
                onChanged: (value) {
                  onPressed(item);
                },
              ),
              Text(label),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class BaseMultiSelectDropdownFormField<T> extends FormField<List<T>> {
  final List<T> items;
  final LabelGetterFunc<T> labelGetter;
  final ValueChanged<List<T>> onChanged;
  final int maxLength;
  final String label;

  BaseMultiSelectDropdownFormField({
    List<T> initialValue = const [],
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    this.items,
    this.labelGetter,
    this.onChanged,
    this.maxLength = 2,
    this.label,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (state) {
            return BaseMultiSelectDropdown<T>(
              error: state.hasError,
              errorText: state.errorText,
              items: items,
              onChanged: (selected) {
                state.didChange(selected);
                onChanged(selected);
              },
              labelGetter: labelGetter,
              label: label,
              initalValue: initialValue,
              maxLength: maxLength,
            );
          },
        );
}
