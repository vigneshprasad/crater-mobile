import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/inbox/bloc/inbox_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';
import 'package:worknetwork/ui/components/home_tab_layout/home_tab_layout.dart';
import 'package:worknetwork/ui/components/list_items/user_list_item/user_list_item.dart';

class InboxTab extends StatefulWidget {
  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  WebSocketRepository _socketRepository;
  InboxBloc _inboxBloc;
  List<ChatUser> _users = [];

  @override
  void initState() {
    _socketRepository = RepositoryProvider.of(context);
    _inboxBloc = InboxBloc(webSocketRepository: _socketRepository)
      ..add(
        InboxGetAllUsers(
          request: WSAllUsersRequest(
            message: const AllUserRequestOptions.initial(),
          ),
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _inboxBloc,
      child: BlocConsumer<InboxBloc, InboxState>(
        listener: (context, state) {
          if (state is AllUsersLoaded) {
            setState(() {
              _users = [...state.users];
            });
          }
        },
        builder: (context, state) {
          return HomeTabLayout(
            titleKey: "inbox:title",
            body: _buildAllUsersList(_users),
          );
        },
      ),
    );
  }

  Widget _buildAllUsersList(List<ChatUser> users) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) =>
          _buildUserListItem(context, index, users),
      separatorBuilder: (context, index) {
        return const Divider(
          indent: AppInsets.listDividerInset,
        );
      },
    );
  }

  Widget _buildUserListItem(
      BuildContext context, int index, List<ChatUser> users) {
    final user = users[index];
    if (user != null) {
      return UserListItem(
        user: user,
      );
    }
    return null;
  }

  @override
  void dispose() {
    _inboxBloc.close();
    super.dispose();
  }
}
