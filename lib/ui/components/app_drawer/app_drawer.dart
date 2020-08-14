import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.blueAccent,
            ),
            child: Container(
              width: double.infinity,
              child: Text('Drawer header'),
            ),
          ),
        ],
      ),
    );
  }
}
