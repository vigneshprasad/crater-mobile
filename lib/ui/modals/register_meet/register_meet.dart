import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:worknetwork/blocs/meeting/bloc/meeting_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/models/meeting/meeting_model.dart';
import 'package:worknetwork/ui/base/base_dropdown/base_dropdown.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/utils/app_localizations.dart';

part 'register_form.dart';

class RegisterMeetOverlay extends ModalRoute<void> {
  final MeetingBloc meetingBloc;

  RegisterMeetOverlay({
    @required this.meetingBloc,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return BlocProvider.value(
      value: meetingBloc,
      child: Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          child: _buildOverlayContent(context),
        ),
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
                  delegate: SliverChildListDelegate([RegisterForm()]),
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
    // You can add your own animations for the overlay content
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
