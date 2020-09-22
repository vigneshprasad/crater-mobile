import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/domain/usecase/post_user_profile_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/aysnc_usecase.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../domain/usecase/get_user_tags_usecase.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final UCGetUserTags getUserTags;
  final UCPostUserProfile postUserProfile;

  ProfileSetupBloc({
    @required this.getUserTags,
    @required this.postUserProfile,
  })  : assert(getUserTags != null),
        assert(postUserProfile != null),
        super(const ProfileSetupInitial());

  @override
  Stream<ProfileSetupState> mapEventToState(
    ProfileSetupEvent event,
  ) async* {
    if (event is GetUserTagsRequestStarted) {
      yield* _mapUserTagsRequestToState(event);
    } else if (event is PostProfileRequestStarted) {
      yield* _mapPostProfileToState(event);
    }
  }

  Stream<ProfileSetupState> _mapUserTagsRequestToState(
      GetUserTagsRequestStarted event) async* {
    yield const ProfileSetupRequestLoading();
    final tagsOrError = await getUserTags(NoParams());

    yield tagsOrError.fold(
      (failure) => ProfileSetupRequestError(error: failure),
      (tags) => ProfileUserTagsRequestLoaded(tags: tags),
    );
  }

  Stream<ProfileSetupState> _mapPostProfileToState(
      PostProfileRequestStarted event) async* {
    yield const ProfileSetupRequestLoading();
    final Map<String, dynamic> body = {
      "linkedin_url": event.linkedinUrl,
      "photo_url": event.photoUrl,
      "tags": event.userTags,
    };
    if (event.name.trim().isNotEmpty) {
      body["name"] = event.name;
    }
    final profileOrError =
        await postUserProfile(PostUserProfileParams(body: body));

    yield profileOrError.fold(
      (failure) => ProfileSetupRequestError(error: failure),
      (profile) => PostUserProfileRequestLoaded(profile: profile),
    );
  }
}
