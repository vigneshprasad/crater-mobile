import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../core/widgets/base/base_network_image/base_network_image.dart';
import '../../bloc/auth_bloc.dart';

const kProfileIconSize = 28.00;

class UserProfileNavItem extends StatelessWidget {
  final VoidCallback onPressed;

  const UserProfileNavItem({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          return InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: BaseNetworkImage(
              imageUrl: state.user.photo,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) {
                return Container(
                  height: kProfileIconSize,
                  width: kProfileIconSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
