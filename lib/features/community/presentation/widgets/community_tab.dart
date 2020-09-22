import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/layouts/home_tab_layout.dart';
import '../../../../core/widgets/screens/models/home_screen_tab_model.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/base/post_card/post_card.dart';
import '../../../../utils/app_localizations.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entity/post_entity.dart';
import '../bloc/community/community_bloc.dart';

class CommunityTab extends HomeScreenTab {
  @override
  _CommunityTabState createState() => _CommunityTabState();

  @override
  double get expandedHeight => 116;

  @override
  String get headingKey => "community:title";

  @override
  String get subheadingKey => "community:subtitle";
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
  bool _showShimmer;

  @override
  void initState() {
    _showShimmer = true;
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
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: _blocListener,
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthStateSuccess) {
              final user = authState.user;
              return HomeTabLayout(
                onRefresh: _onRefreshList,
                listController: _controller,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppInsets.med,
                      vertical: AppInsets.l,
                    ),
                    sliver: _showShimmer
                        ? _buildShimmerList()
                        : _buildPostsList(user),
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

  Widget _buildShimmerList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            child: Card(
              margin: const EdgeInsets.symmetric(
                  vertical: AppInsets.sm, horizontal: AppInsets.sm),
              child: Container(
                height: 160,
              ),
            ),
          );
        },
        childCount: 5,
      ),
    );
  }

  Widget _buildPostsList(User user) {
    return SliverList(
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
                _sendCreateLikeRequest(postId, user);
              }
            },
            onCommentPost: _onCommentPostPressed,
          );
        },
        childCount: _posts.length,
      ),
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
    } else if (state is CommunityNewPostLoaded) {
      setState(() {
        _posts = [state.post, ..._posts];
      });
    }
  }

  Future<void> _onRefreshList() async {
    setState(() {
      _pages = 1;
      _currentPage = 1;
      _posts = [];
      _showShimmer = true;
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
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
    setState(() {
      _showShimmer = false;
      _currentPage = state.currentPage;
      _posts =
          state.currentPage == 1 ? state.posts : [..._posts, ...state.posts];
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
