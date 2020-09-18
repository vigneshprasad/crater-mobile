import 'package:flutter/material.dart';
import 'package:worknetwork/features/notification/presentation/widgets/notification_screen_header.dart';

class NotificationScreenLayout extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const NotificationScreenLayout({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: NotifficationScreenHeader(
                expandedHeight: 112,
                heading: "Notifications",
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
