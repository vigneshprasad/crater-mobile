import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/aysnc_usecase.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/domain/entity/user_profile_entity.dart';
import '../../../../auth/domain/entity/user_tag_entity.dart';
import '../../../../auth/domain/usecase/patch_user_usecase.dart';
import '../../../domain/entity/profile_intro_meta.dart';
import '../../../domain/entity/profile_intro_question.dart';
import '../../../domain/usecase/get_profile_intro_companies.dart';
import '../../../domain/usecase/get_profile_intro_educations.dart';
import '../../../domain/usecase/get_profile_intro_experiences.dart';
import '../../../domain/usecase/get_profile_intro_questions.dart';
import '../../../domain/usecase/get_profile_intro_sectors.dart';
import '../../../domain/usecase/get_user_tags_usecase.dart';
import '../../../domain/usecase/post_user_profile_intro.dart';

part 'profile_intro_event.dart';
part 'profile_intro_state.dart';

class ProfileIntroBloc extends Bloc<ProfileIntroEvent, ProfileIntroState> {
  final UCGetProfileIntroQuestions getProfileIntroQuestions;
  final UCGetUserTags getUserTags;
  final UCGetProfileIntroCompanies getProfileIntroCompanies;
  final UCGetProfileIntroEducations getProfileIntroEducations;
  final UCGetProfileIntroExperiences getProfileIntroExperiences;
  final UCGetProfileIntroSectors getProfileIntroSectors;
  final UCPostUserProfileIntro postUserProfile;
  final UCPatchUser patchUser;
  final Analytics analytics;

  ProfileIntroBloc({
    @required this.getProfileIntroQuestions,
    @required this.getUserTags,
    @required this.getProfileIntroCompanies,
    @required this.getProfileIntroEducations,
    @required this.getProfileIntroExperiences,
    @required this.getProfileIntroSectors,
    @required this.postUserProfile,
    @required this.patchUser,
    @required this.analytics,
  })  : assert(getProfileIntroQuestions != null),
        assert(getUserTags != null),
        assert(getProfileIntroCompanies != null),
        assert(getProfileIntroEducations != null),
        assert(getProfileIntroExperiences != null),
        assert(getProfileIntroSectors != null),
        assert(postUserProfile != null),
        assert(patchUser != null),
        assert(analytics != null),
        super(const ProfileIntroInitial());

  @override
  Stream<ProfileIntroState> mapEventToState(
    ProfileIntroEvent event,
  ) async* {
    if (event is GetProfileIntroRequestStarted) {
      yield* _mapGetProfileIntroToState(event);
    } else if (event is PostProfileIntroRequestStarted) {
      yield* _mapPostProfileIntroToState(event);
    }
  }

  Stream<ProfileIntroState> _mapGetProfileIntroToState(
      GetProfileIntroRequestStarted event) async* {
    yield const ProfileIntroRequestLoading();

    final questionsOrError = await getProfileIntroQuestions(NoParams());

    // Get Tags
    final tagsResponse = await getUserTags(NoParams());
    final tags = tagsResponse.getOrElse(null);

    // Get Companies
    final companyResponse = await getProfileIntroCompanies(NoParams());
    final companies = companyResponse.getOrElse(null);

    // Get Experiences
    final experienceResponse = await getProfileIntroExperiences(NoParams());
    final experiences = experienceResponse.getOrElse(null);

    // Get Sectors
    final sectorResponse = await getProfileIntroSectors(NoParams());
    final sectors = sectorResponse.getOrElse(null);

    // Get Educations
    final educationResponse = await getProfileIntroEducations(NoParams());
    final educations = educationResponse.getOrElse(null);

    yield questionsOrError.fold(
      (failure) => ProfileIntroRequestError(error: failure),
      (questions) => ProfileIntroRequestLoaded(
          questions: element(
        questions,
        tags,
        experiences,
        sectors,
        companies,
        educations,
      )),
    );
  }

  List<ProfileIntroQuestion> element(
    List<String> questions,
    List<UserTag> tags,
    List<ProfileIntroMeta> experiences,
    List<ProfileIntroMeta> sectors,
    List<ProfileIntroMeta> companies,
    List<ProfileIntroMeta> educations,
  ) {
    final items = questions.map((sentence) {
      final elements = sentence.split(' ').map((string) {
        if (string.startsWith('{') && string.endsWith('}')) {
          final id = string.replaceFirst('{', '').replaceFirst('}', '');

          ProfileIntroElementType type = ProfileIntroElementType.dropdown;
          String placeholder;

          List<ProfileIntroMeta> options = [];
          double width;
          int lines;
          switch (id) {
            case ProfileIntroElement.name:
              type = ProfileIntroElementType.text;
              placeholder = 'My Name';
              break;
            case ProfileIntroElement.introduction:
              type = ProfileIntroElementType.text;
              placeholder = 'A brief description';
              width = double.infinity;
              lines = 7;
              break;
            case ProfileIntroElement.tags:
              type = ProfileIntroElementType.multiselect;
              options = tags
                  .map((e) => ProfileIntroMeta(value: e.pk, name: e.name))
                  .toList();
              break;
            case ProfileIntroElement.yearsOfExperience:
              options = experiences;
              break;
            case ProfileIntroElement.sector:
              options = sectors;
              break;
            case ProfileIntroElement.companyType:
              options = companies;
              break;
            case ProfileIntroElement.educationLevel:
              options = educations;
              break;
            default:
              options = null;
          }

          return ProfileIntroElement(
              id: id,
              type: type,
              options: options,
              placeholder: placeholder,
              width: width,
              lines: lines);
        } else if (string == '\n') {
          return ProfileIntroElement(type: ProfileIntroElementType.newline);
        } else {
          return ProfileIntroElement(
              type: ProfileIntroElementType.label, value: string);
        }
      }).toList();
      return ProfileIntroQuestion(elements);
    }).toList();

    return items;
  }

  Stream<ProfileIntroState> _mapPostProfileIntroToState(
      PostProfileIntroRequestStarted event) async* {
    yield const ProfileIntroRequestLoading();

    // Update Profile
    Map<String, dynamic> body = Map.from(event.values);
    final tags = body[ProfileIntroElement.tags] as List<ProfileIntroMeta>;
    final tagIds = tags.map((e) => e.value).toList();
    body[ProfileIntroElement.tags] = tagIds;
    final updateOrError = await postUserProfile(
        UCPostUserProfileIntroParams(body: body, photo: event.photo));

    // Update User
    final user =
        UserModel(name: event.values[ProfileIntroElement.name].toString());
    final patchOrError = await patchUser(PatchUserParams(user: user));
    final updatedUser = patchOrError.getOrElse(() => null);

    yield updateOrError.fold(
      (failure) => ProfileIntroRequestError(error: failure),
      (updatedProfile) {
        final properties = {
          "name": updatedProfile.name,
          "user_tags": updatedProfile.tagList.map((e) => e.name).toList(),
        };

        analytics.identify(properties: properties);
        analytics.trackEvent(
            eventName: AnalyticsEvents.signUpBasicProfile,
            properties: properties);
        return PatchProfileIntroRequestLoaded(
            user: updatedUser, profile: updatedProfile);
      },
    );
  }
}
