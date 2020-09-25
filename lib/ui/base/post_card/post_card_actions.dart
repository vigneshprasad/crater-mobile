import 'package:flutter/material.dart';

import '../../../constants/theme.dart';

class PostCardActions extends StatelessWidget {
  final Text label;
  final Icon icon;
  final VoidCallback onPress;

  const PostCardActions({
    Key key,
    this.label,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        splashColor: Colors.grey[300],
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(AppInsets.med),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              if (label != null)
                const SizedBox(
                  width: AppInsets.sm,
                ),
              if (label != null) label,
            ],
          ),
        ),
      ),
    );
  }
}
