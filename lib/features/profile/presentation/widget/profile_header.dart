import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class ProfileHeader extends HookWidget {
  final UserProfile? profile;
  final Creator? creator;
  final bool showConnect;
  final bool allowEdit;
  final double height;

  const ProfileHeader({
    required this.profile,
    this.creator,
    required this.showConnect,
    required this.allowEdit,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: (profile?.coverFile != null)
              ? Image.network(
                  profile?.coverFile ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                )
              : Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor.fromHex('#010101').withAlpha(0),
                HexColor.fromHex('#010101'),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0,
                0.6,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: 50,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: 104,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor.fromHex('#D5BBFF'),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _buildImage(profile, 92),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (profile != null)
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                profile?.name ?? '',
                                style: Theme.of(context).textTheme.headline6,
                                maxLines: 3,
                              ),
                              if (creator != null && creator!.certified == true)
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.check_circle_outlined,
                                      color: HexColor.fromHex('#D5BBFF'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (creator != null)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 16,
                                      color: HexColor.fromHex('#959595'),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Followers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color: HexColor.fromHex('#959595'),
                                          ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      followerFormat(
                                        creator?.subscriberCount ?? 0,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    // const SizedBox(
                                    //   width: 36,
                                    // ),
                                    // const Icon(
                                    //   Icons.video_call,
                                    //   size: 16,
                                    // ),
                                    // const SizedBox(
                                    //   width: 4,
                                    // ),
                                    // Text(
                                    //   'Streams',
                                    //   style:
                                    //       Theme.of(context).textTheme.subtitle2,
                                    // ),
                                    // const SizedBox(
                                    //   width: 4,
                                    // ),
                                    // Text(
                                    //   followerFormat(
                                    //     creator?.numberOfSubscribers ?? 0,
                                    //   ),
                                    //   style:
                                    //       Theme.of(context).textTheme.subtitle2,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 16),
                              if (!allowEdit)
                                if (showConnect)
                                  BaseLargeButton(
                                    onPressed: () => {},
                                    text: 'Follow',
                                  )
                                else
                                  PlainButton(
                                    title: 'Following',
                                    icon: Icons.check,
                                    onPressed: () {},
                                  ),
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(UserProfile? profile, double radius) {
    final photo = profile?.photo;
    if (photo != null) {
      return CachedNetworkImage(
        imageUrl: photo,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: radius,
            width: radius,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else {
      return Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          image: const DecorationImage(
            image: AppImageAssets.defaultAvatar,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
