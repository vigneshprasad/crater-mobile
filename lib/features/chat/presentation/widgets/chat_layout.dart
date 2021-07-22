import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';

class ChatLayout extends StatefulWidget {
  final bool userIsTyping;
  final ChatUser? user;
  final IndexedWidgetBuilder? listBuilder;
  final Widget? chatBar;
  final int itemCount;

  const ChatLayout({
    Key? key,
    this.user,
    required this.userIsTyping,
    this.listBuilder,
    this.chatBar,
    required this.itemCount,
  }) : super(key: key);

  @override
  _ChatLayoutState createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  ScrollController? _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        color: Colors.white,
        elevation: 1,
        title: _buildLabel(context, 1.0),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomScrollView(
                  controller: _controller,
                  reverse: true,
                  slivers: [
                    if (widget.listBuilder != null)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            widget.listBuilder!,
                            childCount: widget.itemCount),
                      ),
                    // SliverPersistentHeader(
                    //   delegate: ChatHeader(
                    //     expandedHeight: screenHeight * 0.4,
                    //     user: widget.user,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.chatBar != null) Center(child: widget.chatBar),
        ],
      ),
    );
  }

  Widget? _buildLabel(BuildContext context, double opacity) {
    if (widget.user != null) {
      final formatDate = DateFormat("h:mm a");
      final image = widget.user!.photo != null
          ? NetworkImage(widget.user!.photo!)
          : AppImageAssets.defaultAvatar as ImageProvider;
      final name = widget.user!.name.isNotEmpty ? widget.user!.name : "";
      // ignore: unused_local_variable
      final lastSeen = widget.user!.lastSeen != null
          ? formatDate.format(widget.user!.lastSeen!)
          : "";
      final headerStyle = Theme.of(context).textTheme.subtitle2;

      return Opacity(
        opacity: opacity,
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: image,
            ),
            const SizedBox(width: AppInsets.xl),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: headerStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
