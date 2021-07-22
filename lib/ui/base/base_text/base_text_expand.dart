import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../utils/app_localizations.dart';

class BaseTextExpand extends StatefulWidget {
  final String data;
  final TextStyle? style;

  const BaseTextExpand(
    this.data, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  _BaseTextExpandState createState() => _BaseTextExpandState();
}

class _BaseTextExpandState extends State<BaseTextExpand> {
  bool _isExpanded = false;
  static const defaultLines = 2;
  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context)?.translate('read_more');
    final labelStyle = Theme.of(context)
        .textTheme
        .button
        ?.copyWith(color: Theme.of(context).primaryColor);
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: widget.data, style: widget.style);
      final tp = TextPainter(
          text: span, textDirection: TextDirection.ltr, maxLines: defaultLines);
      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        // The text has more than three lines.
        // TODO: display the prompt message
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.data,
              style: widget.style,
              maxLines: _isExpanded ? null : defaultLines,
            ),
            if (!_isExpanded)
              GestureDetector(
                onTap: _handleOnTap,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppInsets.sm),
                  child: Text(
                    label!,
                    style: labelStyle,
                  ),
                ),
              ),
          ],
        );
      } else {
        return Text(widget.data, style: widget.style);
      }
    });
  }

  void _handleOnTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
