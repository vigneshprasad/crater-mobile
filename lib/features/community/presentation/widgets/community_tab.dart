import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/widgets/layouts/home_tab_layout.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/community/domain/entity/post_entity.dart';
import 'package:worknetwork/features/community/presentation/bloc/community_bloc.dart';
import 'package:worknetwork/ui/base/post_card/post_card.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class CommunityTab extends StatefulWidget {
  @override
  _CommunityTabState createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  final _pageSize = 10;
  bool _fromCache = false;
  int _count = 0;
  int _pages = 1;
  int _currentPage = 1;
  Completer<void> _refreshCompleter;
  List<Post> _posts = [];
  CommunityBloc _bloc;
  ScrollController _controller;

  @override
  void initState() {
    _bloc = BlocProvider.of<CommunityBloc>(context)
      ..add(GetCommunityPageRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
      ));
    _refreshCompleter = Completer<void>();
    _controller = ScrollController();
    _controller.addListener(_listScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        AppLocalizations.of(context).translate("community:title");
    final String subtitle =
        AppLocalizations.of(context).translate("community:subtitle");

    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state is CommunityGetPageResponseReceived) {
          _updatePostsList(state);
        } else if (state is CommunityPostDeletedSuccess) {
          _deletePostFromList(state);
        }
      },
      builder: (context, state) {
        return HomeTabLayout(
          heading: title,
          subheading: subtitle,
          list: RefreshIndicator(
            onRefresh: _onRefreshList,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                if (authState is AuthStateSuccess) {
                  final user = authState.user;
                  return ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppInsets.l,
                      horizontal: AppInsets.med,
                    ),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) => PostCard(
                      post: _posts[index],
                      onPostDelete: _onDeletePost,
                      user: user,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefreshList() async {
    setState(() {
      _pages = 1;
      _currentPage = 1;
      _posts = [];
      _bloc.add(
        GetCommunityPageRequestStarted(
          page: _currentPage,
          pageSize: _pageSize,
        ),
      );
    });
    return _refreshCompleter.future;
  }

  void _updatePostsList(CommunityGetPageResponseReceived state) {
    _refreshCompleter.complete();
    _refreshCompleter = Completer();
    setState(() {
      _currentPage = state.currentPage;
      _posts = [..._posts, ...state.posts];
      _pages = state.pages;
      _count = state.count;
      _fromCache = state.fromCache;
    });
  }

  void _onDeletePost(int postId) {
    final alertContent =
        AppLocalizations.of(context).translate("community:delete_post_text");
    final delete =
        AppLocalizations.of(context).translate("delete").toUpperCase();
    final dismiss =
        AppLocalizations.of(context).translate("dismiss").toUpperCase();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(alertContent),
          actions: [
            FlatButton(
              textColor: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(dismiss),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bloc.add(DeletePostRequestStarted(postId: postId));
              },
              child: Text(delete),
            )
          ],
        );
      },
    );
  }

  void _deletePostFromList(CommunityPostDeletedSuccess state) {
    final updated =
        _posts.where((element) => element.pk != state.postId).toList();
    setState(() {
      _posts = updated;
    });
  }

  void _listScrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (_currentPage < _pages) {
        _bloc.add(GetCommunityPageRequestStarted(
          page: _currentPage + 1,
          pageSize: _pageSize,
        ));
      }
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {});
    }
  }
}
