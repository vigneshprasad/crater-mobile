part of 'profile_basic_bloc.dart';

abstract class ProfileBasicEvent extends Equatable {
  const ProfileBasicEvent();

  @override
  List<Object> get props => [];
}

class GetProfileBasicRequestStarted extends ProfileBasicEvent {
  final User user;
  const GetProfileBasicRequestStarted({@required this.user});

  @override
  List<Object> get props => [user];
}

class PostProfileBasicRequestStarted extends ProfileBasicEvent {
  final String name;

  const PostProfileBasicRequestStarted({@required this.name});

  @override
  List<Object> get props => [name];
}
