import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_grid.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/post_rsvp_modal.dart';

import '../../core/push_notfications/push_notifications.dart';
import '../../features/auth/domain/entity/user_entity.dart';
import '../../features/auth/domain/entity/user_profile_entity.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../routes.gr.dart';

const sequence = [
  ProfileBasicScreenRoute.name,
  // ProfileTagsScreenRoute.name,
  // ProfileExtraInfoScreenRoute.name,
  // ProfileImageScreenRoute.name,
  // ProfileBioScreenRoute.name,
  // ProfileSetupScreenRoute.name,
  // ProfileEmailScreenRoute.name,
  // ProfileRequestScreenRoute.name,
  HomeScreenRoute.name,
];

void navigateNextProfileStep({bool editMode = false}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  final state = BlocProvider.of<AuthBloc>(_navigator.currentContext!).state;
  final user = state.user;
  final profile = state.profile;
  navigatePostAuth(user, profile: profile, editMode: editMode);
}

void navigatePostAuth(
  User? user, {
  UserProfile? profile,
  bool editMode = false,
}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  final router = AutoRouter.of(_navigator.currentContext!).root;

  String routeName = _findNextRoute(profile, user, editMode);

  final desiredIndex = sequence.indexOf(routeName);

  final currentRoute = router.topRoute.name;
  if (sequence.contains(currentRoute)) {
    final nextIndex = sequence.indexOf(currentRoute) + 1;
    int index = max(desiredIndex, nextIndex);
    if (editMode) {
      index = nextIndex;
    } else {
      while (sequence.length > index + 1 &&
          shouldShow(sequence[index], profile, user) == false) {
        index++;
      }
    }
    if (index >= 0 && index < sequence.length) {
      routeName = sequence[index];
    }
  }

  final route = _createPageRouteInfo(routeName, editMode);
  router.pushAndPopUntil(route, predicate: (route) => false);
  if (routeName == HomeScreenRoute.name) {
    KiwiContainer().resolve<PushNotifications>().setEventHandlers();
  }
}

PageRouteInfo _createPageRouteInfo(String name, bool editMode) {
  switch (name) {
    case ProfileBasicScreenRoute.name:
      return ProfileBasicScreenRoute(editMode: editMode);
    case ProfileTagsScreenRoute.name:
      return ProfileTagsScreenRoute(editMode: editMode);
    case ProfileExtraInfoScreenRoute.name:
      return ProfileExtraInfoScreenRoute(editMode: editMode);
    case ProfileImageScreenRoute.name:
      return ProfileImageScreenRoute(editMode: editMode);
    case ProfileBioScreenRoute.name:
      return ProfileBioScreenRoute(editMode: editMode);
    case ProfileSetupScreenRoute.name:
      return ProfileSetupScreenRoute(editMode: editMode);
    case ProfileRequestScreenRoute.name:
      return ProfileRequestScreenRoute(editMode: editMode);
    case ProfileEmailScreenRoute.name:
      return ProfileEmailScreenRoute(editMode: editMode);
    default:
      return HomeScreenRoute();
  }
}

bool shouldShow(String name, UserProfile? profile, User? user) {
  if (profile == null) {
    return true;
  }
  switch (name) {
    case ProfileBasicScreenRoute.name:
      return profile.name == null || profile.name!.trim().isEmpty;
    case ProfileTagsScreenRoute.name:
      return profile.tagList == null || profile.tagList!.isEmpty;
    case ProfileExtraInfoScreenRoute.name:
      return profile.profileIntroUpdated == false;
    case ProfileImageScreenRoute.name:
      return profile.photo == null;
    case ProfileBioScreenRoute.name:
      return profile.introduction == null;
    case ProfileSetupScreenRoute.name:
      return profile.linkedinUrl == null;
    case ProfileRequestScreenRoute.name:
      return profile.allowMeetingRequest == null ||
          profile.allowMeetingRequest == false;
    case ProfileEmailScreenRoute.name:
      return user?.email == null;
    default:
      return true;
  }
}

String _findNextRoute(UserProfile? profile, User? user, bool isEdit) {
  if (!isEdit) {
    if (profile != null &&
        (profile.name == null || profile.name!.trim().isEmpty)) {
      return ProfileBasicScreenRoute.name;
    }
    return HomeScreenRoute.name;
  }

  int index = 0;
  while (shouldShow(sequence[index], profile, user) == false) {
    index++;
  }
  return sequence[index];
}

Future<bool> manageLoginPopup(BuildContext context) async {
  var user = BlocProvider.of<AuthBloc>(context).state.user;
  if (user != null) {
    return true;
  }

  user = await showModalBottomSheet(
    elevation: 10,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
            topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
          ),
          child: Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
            ),
            child: const PhoneScreen(state: 'popup'),
          ));
    },
  );

  return user != null;
}

Future<void> manageRSVPPopup(BuildContext context, String creatorName,
    {int slide = 1}) async {
  await showModalBottomSheet(
    elevation: 10,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
            topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
          ),
          child: Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
            ),
            child: PostRSVPModal(
              creatorName: creatorName,
              slide: slide,
            ),
          ));
    },
  );
}
