import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/aysnc_usecase.dart';
import '../../../../auth/domain/entity/user_profile_entity.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../domain/usecase/get_user_tags_usecase.dart';
import '../../../domain/usecase/post_user_profile_intro.dart';

part 'profile_tags_event.dart';
part 'profile_tags_state.dart';

class ProfileTagsBloc extends Bloc<ProfileTagsEvent, ProfileTagsState> {
  final UCGetUserTags getUserTags;
  final UCPostUserProfileIntro postUserProfile;
  final Analytics analytics;

  ProfileTagsBloc({
    @required this.getUserTags,
    @required this.postUserProfile,
    @required this.analytics,
  })  : assert(getUserTags != null),
        assert(postUserProfile != null),
        assert(analytics != null),
        super(const ProfileTagsInitial());

  @override
  Stream<ProfileTagsState> mapEventToState(
    ProfileTagsEvent event,
  ) async* {
    if (event is GetProfileTagsRequestStarted) {
      yield* _mapGetProfileTagsToState(event);
    } else if (event is PostProfileTagsRequestStarted) {
      yield* _mapPostProfileTagsToState(event);
    }
  }

  Stream<ProfileTagsState> _mapGetProfileTagsToState(
      GetProfileTagsRequestStarted event) async* {
    yield const ProfileTagsRequestLoading();

    // Get Tags
    final tagsResponse = await getUserTags(NoParams());

    yield tagsResponse.fold(
      (failure) => ProfileTagsRequestError(error: failure),
      (questions) => ProfileTagsRequestLoaded(tags: questions),
    );
  }

  Stream<ProfileTagsState> _mapPostProfileTagsToState(
      PostProfileTagsRequestStarted event) async* {
    yield const ProfileTagsRequestLoading();

    // Update Profile
    final tags = {'tags': event.tagIds};
    final updateOrError =
        await postUserProfile(UCPostUserProfileIntroParams(body: tags));

    yield updateOrError.fold(
      (failure) => ProfileTagsRequestError(error: failure),
      (updatedProfile) {
        final properties = {
          "user_tags": tags,
        };

        analytics.identify(properties: properties);
        analytics.trackEvent(
            eventName: AnalyticsEvents.signUpBasicProfile,
            properties: properties);
        return PostProfileTagsRequestLoaded(user: updatedProfile);
      },
    );
  }
}
