import 'package:flutter/material.dart';

class ChatLayout extends StatefulWidget {
  final bool userIsTyping;
  final IndexedWidgetBuilder? listBuilder;
  final Widget? chatBar;
  final int itemCount;

  const ChatLayout({
    Key? key,
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
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
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
                          childCount: widget.itemCount,
                        ),
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
