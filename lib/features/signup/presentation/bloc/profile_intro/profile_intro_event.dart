part of 'profile_intro_bloc.dart';

abstract class ProfileIntroEvent extends Equatable {
  const ProfileIntroEvent();

  @override
  List<Object> get props => [];
}

class GetProfileIntroRequestStarted extends ProfileIntroEvent {
  final User user;
  const GetProfileIntroRequestStarted({@required this.user});

  @override
  List<Object> get props => [user];
}

class GetProfileIntroTagsRequestStarted extends ProfileIntroEvent {
  const GetProfileIntroTagsRequestStarted();
}

class PostProfileIntroRequestStarted extends ProfileIntroEvent {
  final Map<String, dynamic> values;
  final File photo;

  const PostProfileIntroRequestStarted({
    @required this.values,
    this.photo,
  });

  @override
  List<Object> get props => [
        values,
        photo,
      ];
}
