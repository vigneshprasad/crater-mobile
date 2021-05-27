import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/error/failures.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/domain/entity/user_profile_entity.dart';
import '../../../../auth/domain/usecase/patch_user_usecase.dart';
import '../../../domain/usecase/post_user_profile_intro.dart';

part 'profile_basic_event.dart';
part 'profile_basic_state.dart';

class ProfileBasicBloc extends Bloc<ProfileBasicEvent, ProfileBasicState> {
  final UCPostUserProfileIntro postUserProfile;
  final UCPatchUser patchUser;
  final Analytics analytics;

  ProfileBasicBloc({
    @required this.postUserProfile,
    @required this.patchUser,
    @required this.analytics,
  })  : assert(postUserProfile != null),
        assert(patchUser != null),
        assert(analytics != null),
        super(const ProfileBasicInitial());

  @override
  Stream<ProfileBasicState> mapEventToState(
    ProfileBasicEvent event,
  ) async* {
    if (event is GetProfileBasicRequestStarted) {
      yield* _mapGetProfileIntroToState(event);
    } else if (event is PostProfileBasicRequestStarted) {
      yield* _mapPostProfileIntroToState(event);
    }
  }

  Stream<ProfileBasicState> _mapGetProfileIntroToState(
      GetProfileBasicRequestStarted event) async* {
    yield const ProfileBasicRequestLoading();

    yield const ProfileBasicRequestLoaded();
  }

  Stream<ProfileBasicState> _mapPostProfileIntroToState(
      PostProfileBasicRequestStarted event) async* {
    yield const ProfileBasicRequestLoading();

    // Update Profile
    final updateOrError = await postUserProfile(
        UCPostUserProfileIntroParams(body: {'name': event.name}));

    // Update User
    final user = UserModel(name: event.name);
    final patchOrError = await patchUser(PatchUserParams(user: user));
    final updatedUser = patchOrError.getOrElse(() => null);

    yield updateOrError.fold(
      (failure) => ProfileBasicRequestError(error: failure),
      (updatedProfile) {
        final properties = {
          "name": updatedProfile.name,
        };

        analytics.identify(properties: properties);
        analytics.trackEvent(
            eventName: AnalyticsEvents.signUpBasicProfile,
            properties: properties);
        return PatchProfileBasicRequestLoaded(
            user: updatedUser, profile: updatedProfile);
      },
    );
  }
}
