import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../ui/components/home_tab_layout/home_tab_layout.dart';
import '../../../../ui/components/list_items/user_list_item/user_list_item.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../bloc/chat_inbox/chat_inbox_bloc.dart';

class InboxTab extends StatefulWidget {
  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  ChatInboxBloc _inboxBloc;
  List<ChatUser> _users = [];
  String _filter = "all";
  int _page = 1;

  @override
  void initState() {
    _inboxBloc = BlocProvider.of<ChatInboxBloc>(context)
      ..add(GetAllChatUsersRequest(
        filter: _filter,
        page: _page,
        search: "",
      ));
    super.initState();
  }

  @override
  void dispose() {
    _inboxBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _inboxBloc,
      child: BlocBuilder<ChatInboxBloc, ChatInboxState>(
        builder: (context, state) {
          return HomeTabLayout(
            titleKey: "inbox:title",
            body: _buildAllUsersList(state.users),
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
        onStarPressed: () {
          _inboxBloc.add(StarUserRequestStarted(
            user: user.pk,
            isStarred: !user.isStarred,
          ));
        },
      );
    }
    return null;
  }
}
