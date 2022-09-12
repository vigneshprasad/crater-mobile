import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';

const kProfileIconSize = 24.00;

class UserProfileNavItem extends HookConsumerWidget {
  final VoidCallback? onPressed;

  const UserProfileNavItem({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authStateProvider);

    return authState.when(
      loading: () => const CircleAvatar(
        backgroundColor: Colors.white,
        radius: kProfileIconSize / 2,
        backgroundImage: AppImageAssets.defaultAvatar,
      ),
      data: (user) => InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: BaseNetworkImage(
          imageUrl: user.photo,
          defaultImage: AppImageAssets.defaultAvatar,
          imagebuilder: (context, imageProvider) {
            return Container(
              height: kProfileIconSize,
              width: kProfileIconSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ),
      error: (error, stack) => const CircleAvatar(
        backgroundColor: Colors.white,
        radius: kProfileIconSize / 2,
        backgroundImage: AppImageAssets.defaultAvatar,
      ),
    );
  }
}
