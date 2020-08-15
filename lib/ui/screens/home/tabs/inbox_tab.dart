import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:worknetwork/blocs/inbox/bloc/inbox_bloc.dart';
import 'package:worknetwork/blocs/notification/bloc/notification_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
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
  NotificationBloc _notificationBloc;

  @override
  void initState() {
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);
    _socketRepository = RepositoryProvider.of(context);
    _inboxBloc = InboxBloc(
      webSocketRepository: _socketRepository,
      notificationBloc: _notificationBloc,
    )..add(
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
      return ValueListenableBuilder(
        valueListenable:
            Hive.box<ChatUser>(AppHiveBoxes.chatUsersBox).listenable(),
        builder: (context, Box<ChatUser> box, child) {
          final persistedUser = box.get(user.pk);
          return UserListItem(
            user: persistedUser,
          );
        },
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
