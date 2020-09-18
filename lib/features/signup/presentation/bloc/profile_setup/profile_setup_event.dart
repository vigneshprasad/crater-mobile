part of 'profile_setup_bloc.dart';

abstract class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object> get props => [];
}

class GetUserTagsRequestStarted extends ProfileSetupEvent {
  const GetUserTagsRequestStarted();
}

class PostProfileRequestStarted extends ProfileSetupEvent {
  final String photoUrl;
  final List<int> userTags;
  final String linkedinUrl;
  final String name;

  const PostProfileRequestStarted({
    this.photoUrl,
    @required this.userTags,
    @required this.linkedinUrl,
    @required this.name,
  });

  @override
  List<Object> get props => [photoUrl, userTags, linkedinUrl];
}
