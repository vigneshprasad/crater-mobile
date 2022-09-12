import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

class BaseFormField extends StatelessWidget {
  final String? label;
  final Widget child;

  const BaseFormField({
    Key? key,
    this.label,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppInsets.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) Text(label!, style: labelStyle),
          const SizedBox(height: AppInsets.med),
          child,
        ],
      ),
    );
  }
}
