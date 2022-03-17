import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/screen/time_slots/timeslots_screen.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';

import '../../../../routes.gr.dart';
import 'gradient_button.dart';

class ProfileHeader extends HookWidget {
  final UserProfile? profile;
  final Creator? creator;
  final bool showConnect;
  final double height;

  const ProfileHeader({
    required this.profile,
    this.creator,
    required this.showConnect,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: (profile?.coverFile != null)
              ? Image.network(profile?.coverFile ?? '',
                  fit: BoxFit.contain, width: double.infinity, height: height)
              : Image.asset('assets/images/logo.png',
                  fit: BoxFit.cover, width: double.infinity, height: height),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 16, bottom: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 2.5),
                          borderRadius: BorderRadius.circular(56),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildImage(profile, 40),
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (profile != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    profile?.name ?? '',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    maxLines: 3,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (creator != null &&
                                    creator!.certified == true)
                                  Icon(
                                    Icons.check_circle_outlined,
                                    color: Theme.of(context).accentColor,
                                  ),
                              ],
                            ),
                            // const SizedBox(height: 8),
                            // if (creator != null)
                            //   Text(
                            //     '${followerFormat(creator?.numberOfSubscribers ?? 0)} Followers',
                            //     style: Theme.of(context).textTheme.caption,
                            //   ),
                            const SizedBox(height: 8),
                            if (showConnect)
                              Positioned(
                                  bottom: 50,
                                  right: 20,
                                  child: GradientButton(
                                    onPressed: () => _showTimeSlots(context),
                                    title: 'JOIN CLUB',
                                  ))
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showTimeSlots(BuildContext context) async {

    final token = BlocProvider.of<AuthBloc>(context).state.user?.token;
    if (token == null) {
      // Show login
      AutoRouter.of(context).push(const WelcomeScreenRoute());
      return;
    }
    
    showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
            topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
          ),
          child: TimeSlotsScreen(profileId: profile!.uuid!),
        );
      },
    );
  }

  Widget _buildImage(UserProfile? profile, double radius) {
    final photo = profile?.photo;
    if (photo != null) {
      return CachedNetworkImage(
        imageUrl: photo,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: radius * 2,
            width: radius * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else {
      return Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: const DecorationImage(
              image: AppImageAssets.defaultAvatar, fit: BoxFit.cover),
        ),
      );
    }
  }
}
