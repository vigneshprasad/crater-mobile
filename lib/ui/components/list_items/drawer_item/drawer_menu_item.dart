import 'package:flutter/material.dart';

import '../../../../utils/app_localizations.dart';
import '../../app_drawer/app_drawer.dart';

typedef DrawerItemCallback = void Function(DrawerItem);

class DrawerMenuItem extends StatelessWidget {
  final DrawerItem item;
  final DrawerItemCallback onPressItem;

  const DrawerMenuItem({
    Key? key,
    required this.item,
    required this.onPressItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context)?.translate(item.label);
    return ListTile(
      dense: true,
      title: Text(label!),
      leading: Icon(item.icon),
      onTap: () {
        onPressItem(item);
      },
    );
  }
}
