part of 'inbox_bloc.dart';

abstract class InboxState extends Equatable {
  final List<ChatUser> users;
  final int page;
  final int pages;

  const InboxState({
    this.users,
    this.page,
    this.pages,
  });
}

class InboxInitial extends InboxState {
  InboxInitial()
      : super(
          users: [],
          page: 1,
          pages: 1,
        );
  @override
  List<Object> get props => [users, page, pages];
}

class PersistChatUsers extends InboxState {
  const PersistChatUsers({
    List<ChatUser> users,
  }) : super(users: users);

  @override
  List<Object> get props => [users];
}

class UpdatedUserData extends InboxState {
  final MessageNotification notification;
  const UpdatedUserData({this.notification});

  @override
  List<Object> get props => [notification];
}

class AllUsersLoaded extends InboxState {
  const AllUsersLoaded({
    List<ChatUser> users,
    int page,
    int pages,
  }) : super(
          users: users,
          page: page,
          pages: pages,
        );

  @override
  List<Object> get props => [users, page, pages];
}
