import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/post_card/post_card.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/post_entity.dart';
import '../bloc/community/community_bloc.dart';

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
      listener: _blocListener,
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthStateSuccess) {
              final user = authState.user;
              return HomeTabLayout(
                heading: title,
                subheading: subtitle,
                onRefresh: _onRefreshList,
                listController: _controller,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.med,
                      vertical: AppInsets.l,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return PostCard(
                            post: _posts[index],
                            onPostDelete: _onDeletePost,
                            user: user,
                            onLikePost: (postId, myLike) {
                              if (myLike) {
                                _sendDeleteLikeRequest(postId);
                              } else {
                                _sendCreateLikeRequest(postId, authState.user);
                              }
                            },
                            onCommentPost: _onCommentPostPressed,
                          );
                        },
                        childCount: _posts.length,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  void _blocListener(BuildContext context, CommunityState state) {
    if (state is CommunityGetPageResponseReceived) {
      _updatePostsList(state);
    } else if (state is CommunityPostDeletedSuccess) {
      _deletePostFromList(state);
    } else if (state is CommunityCreateLikeReceivedSuccess) {
      _updatePostLikeCreated(state);
    } else if (state is CommunityDeleteLikeReceivedSuccess) {
      _updatePostLikeDeleted(state);
    }
  }

  Future<void> _onRefreshList() async {
    setState(() {
      _pages = 1;
      _currentPage = 1;
      _posts = [];
    });
    _bloc.add(
      GetCommunityPageRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
      ),
    );
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

  void _deletePostFromList(CommunityPostDeletedSuccess state) {
    final updated =
        _posts.where((element) => element.pk != state.postId).toList();
    setState(() {
      _posts = updated;
    });
  }

  void _updatePostLikeCreated(CommunityCreateLikeReceivedSuccess state) {
    final updated = _posts.map((post) {
      final like = state.like;
      if (post.pk == like.post) {
        post = post.copyWith(
          likes: like.likeCount,
          myLike: true,
        );
      }
      return post;
    }).toList();
    setState(() {
      _posts = updated;
    });
  }

  void _updatePostLikeDeleted(CommunityDeleteLikeReceivedSuccess state) {
    final updated = _posts.map((post) {
      final like = state.like;
      if (post.pk == like.post) {
        post = post.copyWith(
          likes: like.likeCount,
          myLike: false,
        );
      }
      return post;
    }).toList();
    setState(() {
      _posts = updated;
    });
  }

  // Scroll Listener for Pagination
  void _listScrollListener() {
    // reached End of scroll
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (_currentPage < _pages) {
        _bloc.add(GetCommunityPageRequestStarted(
          page: _currentPage + 1,
          pageSize: _pageSize,
        ));
      }
    }
  }

  void _onCommentPostPressed(int postId) {
    // Navigator.of(context).push(CommentsModal(postId: postId));
    ExtendedNavigator.of(context)
        .push(Routes.postScreen, arguments: PostScreenArguments(postId: postId))
        .then((value) {
      _onRefreshList();
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

  void _sendCreateLikeRequest(int id, User user) {
    _bloc.add(CreateLikePostRequest(
      postId: id,
      userId: user.pk,
    ));
  }

  void _sendDeleteLikeRequest(int postId) {
    _bloc.add(DeleteLikePostRequest(postId: postId));
  }
}
