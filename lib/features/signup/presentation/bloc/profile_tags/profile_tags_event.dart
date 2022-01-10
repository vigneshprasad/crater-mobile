part of 'profile_tags_bloc.dart';

abstract class ProfileTagsEvent extends Equatable {
  const ProfileTagsEvent();

  @override
  List<Object> get props => [];
}

class GetProfileTagsRequestStarted extends ProfileTagsEvent {
  const GetProfileTagsRequestStarted();
}

class PostProfileTagsRequestStarted extends ProfileTagsEvent {
  final List<int> tagIds;

  const PostProfileTagsRequestStarted({
    required this.tagIds,
  });

  @override
  List<Object> get props => [
        tagIds,
      ];
}
