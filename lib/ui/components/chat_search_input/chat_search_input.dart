import 'package:flutter/material.dart';

import '../../../utils/app_localizations.dart';

class ChatSearchInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onEditingComplete;

  const ChatSearchInput({
    Key key,
    this.controller,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefixText =
        AppLocalizations.of(context).translate("chat_search:input_prefix");
    final prefixStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey,
        );

    final hintText =
        AppLocalizations.of(context).translate("chat_search:input_prefix_text");
    final inputStyle =
        Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14);
    final hintTextStyle = inputStyle.copyWith(color: Colors.grey);
    return TextField(
      style: inputStyle,
      controller: controller,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintTextStyle,
        icon: Text(prefixText ?? "", style: prefixStyle),
        border: InputBorder.none,
      ),
    );
  }
}
