import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/theme.dart';

typedef OnChangeCallback = void Function(String value);
typedef OnValidCallback = void Function(bool isValid);

class CodeInput extends StatefulWidget {
  final int length;
  final OnChangeCallback? onChange;
  final OnValidCallback? onValidChange;

  const CodeInput({
    Key? key,
    required this.length,
    this.onChange,
    this.onValidChange,
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
    _focusNode = FocusNode();
    _controller = TextEditingController();
    _controller.addListener(_textChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
                  contentPadding: EdgeInsets.all(0),
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
                children: List.generate(widget.length,
                    (index) => _buildFieldContainer(context, index)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _textChangeListener() {
    final currentText = _controller.text;
    if (widget.onChange != null) {
      widget.onChange!(currentText);
    }

    if (widget.onValidChange != null) {
      widget.onValidChange!(currentText.length == widget.length);
    }
    _setTextToDisplay(currentText);
  }

  Widget _buildFieldContainer(BuildContext context, int index) {
    final hasFocus = _focusNode.hasFocus;
    final border = hasFocus
        ? Border.all(
            width: 2,
            color: _valuesList[index].isEmpty
                ? Colors.grey[400]!
                : Theme.of(context).primaryColor,
          )
        : null;

    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      width: 48,
      height: 48,
      margin: const EdgeInsets.only(right: AppInsets.med, top: AppInsets.med),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(AppBorderRadius.textInput),
        border: border,
      ),
      child: Center(
        child: Text(
          _valuesList[index],
          style: textStyle,
          textAlign: TextAlign.center,
        ),
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
