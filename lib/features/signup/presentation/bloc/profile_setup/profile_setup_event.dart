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
  final String linkedinUrl;

  const PostProfileRequestStarted({
    @required this.linkedinUrl,
  });

  @override
  List<Object> get props => [linkedinUrl];
}
