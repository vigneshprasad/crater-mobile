import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/connection/presentation/screen/time_slots/timeslots_screen.dart';
import 'package:worknetwork/features/profile/domain/entity/profile_entity/profile_entity.dart';

import 'gradient_button.dart';

class ProfileHeader extends HookWidget {
  final Profile? profile;
  final bool showConnect;
  final double height;

  const ProfileHeader({
    required this.profile,
    required this.showConnect,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          height: height,
          child: (profile?.photo != null)
              ? Image.network(
                  profile?.photo ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : null,
        ),
        Positioned(
          bottom: 50,
          left: 20,
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
                            Text(
                              profile?.name ?? '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(width: 8),
                            // Icon(
                            //   Icons.check_circle_outlined,
                            //   color: Theme.of(context).accentColor,
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Text(
                        //   '49,765 Followers',
                        //   style: Theme.of(context).textTheme.caption,
                        // ),
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
      ],
    );
  }

  Future<void> _showTimeSlots(BuildContext context) async {
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

  Widget _buildImage(Profile? profile, double radius) {
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
