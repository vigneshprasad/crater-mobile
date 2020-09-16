import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/meeting/domain/entity/time_slot_entity.dart';
import 'package:worknetwork/features/signup/presentation/widgets/multiselect_dropdown.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/utils/app_localizations.dart';

import '../../../../constants/theme.dart';
import '../../../../ui/base/base_dropdown/base_dropdown.dart';
import '../../../../ui/base/base_form_field/base_form_field.dart';
import '../../domain/entity/meeting_config_entity.dart';
import '../../domain/entity/meeting_interest_entity.dart';
import '../../domain/entity/meeting_objective_entity.dart';
import '../../domain/entity/user_meeting_preference_entity.dart';
import 'time_slot_picker.dart';

part 'register_form.dart';

class RegisterMeetOverlay extends ModalRoute<void> {
  final MeetingConfig meeting;
  final UserMeetingPreference preference;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;

  RegisterMeetOverlay({
    @required this.meeting,
    @required this.preference,
    @required this.objectives,
    @required this.interests,
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
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
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
                    RegisterForm(
                      meeting: meeting,
                      preference: preference,
                      interests: interests,
                      objectives: objectives,
                    ),
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
