import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

import '../../../../constants/app_constants.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/base_app_bar/base_app_bar.dart';

class HomeScreenAppBar extends StatelessWidget {
  final Widget title;

  const HomeScreenAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      title: title,
      actions: [
        IconButton(
          splashRadius: 18.00,
          color: Colors.grey[500],
          icon: const Icon(Icons.outgoing_mail),
          onPressed: () {
            Share.share(AppConstants.defaultShareText);
          },
        ),
        // IconButton(
        //   splashRadius: 18.00,
        //   color: Colors.black87,
        //   icon: const Icon(WorkNetIcons.notification),
        //   onPressed: () {
        //     AutoRouter.of(context).push(Routes.notificationsScreen);
        //   },
        // ),
        UserProfileNavItem(
          onPressed: () {
            final user = BlocProvider.of<AuthBloc>(context).state.user;
            if (user != null) {
              AutoRouter.of(context)
                  .push(ProfileScreenRoute(userId: user.pk!, allowEdit: true));
            }
          },
        ),
      ],
    );
  }
}
