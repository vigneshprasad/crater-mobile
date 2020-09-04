import 'package:flutter/material.dart';
import 'package:worknetwork/features/community/presentation/widgets/comments_form.dart';

class CommentsModal extends ModalRoute<void> {
  final int postId;

  CommentsModal({
    @required this.postId,
  });

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    final NavigatorState _navigator = Navigator.of(context);
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent <= 0.25 && _navigator.canPop()) {
          _navigator.pop();
          return true;
        }
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    onPressedClose: () => _navigator.pop(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    CommentsForm(
                      postId: postId,
                    )
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    final end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback onPressedClose;

  _SliverAppBarDelegate({
    @required this.onPressedClose,
  });

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: onPressedClose,
              icon: Icon(
                Icons.close,
                color: Colors.grey[600],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
