import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class HomeScreenAppBar extends HookConsumerWidget {
  final Widget title;

  const HomeScreenAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        UserProfileNavItem(
          onPressed: () {
            final user = ref.read(authStateProvider.notifier).getUser();
            if (user != null) {
              AutoRouter.of(context).push(
                ProfileScreenRoute(userId: user.pk ?? '', allowEdit: true),
              );
            }
          },
        ),
      ],
    );
  }
}
