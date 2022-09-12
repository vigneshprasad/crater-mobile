import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnChangeCallback = void Function(String value);
typedef OnValidCallback = void Function(bool isValid);

class CodeInput extends StatefulWidget {
  final int length;
  final OnChangeCallback? onChange;
  final OnValidCallback? onValidChange;
  final FocusNode focusNode;

  const CodeInput({
    Key? key,
    required this.length,
    this.onChange,
    this.onValidChange,
    required this.focusNode,
  }) : super(key: key);

  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late List<String> _valuesList;

  @override
  void initState() {
    _valuesList = List.generate(widget.length, (index) => "");
    _focusNode = widget.focusNode;
    _controller = TextEditingController();
    _controller.addListener(_textChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AbsorbPointer(
            child: AutofillGroup(
              child: TextFormField(
                keyboardType: TextInputType.number,
                focusNode: _focusNode,
                controller: _controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.length),
                  FilteringTextInputFormatter.digitsOnly
                ],
                style: const TextStyle(
                  color: Colors.transparent,
                  fontSize: 0.1,
                  height: 0.1,
                ),
                showCursor: false,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                _onFocus();
              },
              child: Row(
                children: List.generate(
                  widget.length,
                  (index) => _buildFieldContainer(context, index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _textChangeListener() {
    final currentText = _controller.text;
    widget.onChange?.call(currentText);
    widget.onValidChange?.call(currentText.length == widget.length);
    _setTextToDisplay(currentText);
  }

  Widget _buildFieldContainer(BuildContext context, int index) {
    final hasFocus = _focusNode.hasFocus;
    final borderColor = hasFocus
        ? _valuesList[index].isEmpty
            ? Theme.of(context).dividerColor
            : Theme.of(context).primaryColor
        : Theme.of(context).dividerColor;

    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            width: 36,
            height: 48,
            child: Center(
              child: Text(
                _valuesList[index],
                style: textStyle,
              ),
            ),
          ),
          Container(
            height: 1,
            width: 36,
            color: borderColor,
          )
        ],
      ),
    );
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      Future.delayed(
        const Duration(microseconds: 1),
        () => _focusNode.requestFocus(),
      );
    } else {
      _focusNode.requestFocus();
    }
  }

  void _setTextToDisplay(String text) {
    final replaceInputList = List<String>.filled(widget.length, '');

    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = text.length > i ? text[i] : "";
    }

    setState(() {
      _valuesList = replaceInputList;
    });
  }
}
