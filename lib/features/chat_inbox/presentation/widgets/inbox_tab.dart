import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../ui/components/list_items/user_list_item/user_list_item.dart';
import '../../../conversations/presentation/widgets/sliver_obstruction_injector/sliver_obstruction_injector.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../bloc/chat_inbox/chat_inbox_bloc.dart';

class InboxTab extends StatefulWidget {
  @override
  _InboxTabState createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  late ChatInboxBloc _inboxBloc;
  List<ChatUser> _users = [];
  final _filter = "all";
  int _currentPage = 1;
  late Completer<void> _completer;
  late bool _showShimmer;

  @override
  void initState() {
    _showShimmer = true;
    _inboxBloc = BlocProvider.of<ChatInboxBloc>(context)
      ..add(GetAllChatUsersRequest(
        filter: _filter,
        page: _currentPage,
        search: "",
      ));
    _completer = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _inboxBloc,
      child: BlocConsumer<ChatInboxBloc, ChatInboxState>(
        listener: _blocListener,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _onRefreshList,
            child: CustomScrollView(
              slivers: [
                SliverObstructionInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                if (_showShimmer) _buildShimmerList() else _buildUserList()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
              ),
              title: Container(
                height: 10,
                color: Colors.grey[200],
              ),
              subtitle: Container(
                height: 10,
                color: Colors.grey[200],
              ),
            ),
          );
        },
        childCount: 5,
      ),
    );
  }

  Widget _buildUserList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildAllUsersList,
        childCount: _users.length,
      ),
    );
  }

  Widget _buildAllUsersList(BuildContext context, int index) {
    final user = _users[index];
    return UserListItem(
      user: user,
      onStarPressed: () {
        _inboxBloc.add(StarUserRequestStarted(
          user: user.pk ?? '',
          isStarred: !user.isStarred!,
        ));
      },
    );
  }

  void _blocListener(BuildContext context, ChatInboxState state) {
    if (state is ChatInboxUsersResponseReceived) {
      _completer.complete();
      _completer = Completer();
      // final List<ChatUser> updated =
      //     state.users.fold([], (previousValue, element) {
      //   final exists = _users.where((user) => user.pk == element.pk);
      //   if (exists.isEmpty) {
      //     return [...previousValue, element];
      //   } else {
      //     return [...previousValue, ...exists];
      //   }
      // });
      setState(() {
        _users = [..._users, ...state.users];
        _currentPage = state.page;
        _showShimmer = false;
      });
    } else if (state is ChatInboxStarChangeReceived) {
      setState(() {
        _users = _users.map((e) {
          if (e.pk == state.user.pk) {
            return state.user;
          }
          return e;
        }).toList();
      });
    }
  }

  Future<void> _onRefreshList() {
    setState(() {
      _currentPage = 1;
      _users = [];
      _showShimmer = true;
    });
    _inboxBloc.add(GetAllChatUsersRequest(
      filter: _filter,
      page: _currentPage,
      search: "",
    ));
    return _completer.future;
  }
}
